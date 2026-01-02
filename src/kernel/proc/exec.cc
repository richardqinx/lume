#include "common/types.h"
#include "kernel/riscv.h"
#include "kernel/proc.h"
#include "kernel/mm.h"
#include "kernel/elf.h"
#include "fs/fs.h"
#include "lib/string.h"
#include "drivers/uart.h"
#include "kernel/trap.h"
#include "drivers/uart.h"

extern char trampoline[];

// RAII: Page Table Resource Management
class VmGuard
{
public:
    uint64 *pagetable = nullptr;
    uint64 sz = 0;

    VmGuard() : pagetable(VM::uvmcreate()) {}

    ~VmGuard()
    {
        if (pagetable)
        {
            VM::uvmfree(pagetable, sz);
        }
    }

    // Copying is prohibited
    VmGuard(const VmGuard &) = delete;
    VmGuard &operator=(const VmGuard &) = delete;

    // Submit resources: Ownership transfer, destructor no longer releases
    uint64 *commit()
    {
        uint64 *pt = pagetable;
        pagetable = nullptr;
        return pt;
    }
};

// RAII: Inode Lock Management
class InodeGuard
{
public:
    Inode *ip;
    InodeGuard(Inode *i) : ip(i)
    {
        if (ip)
            VFS::ilock(ip);
    }
    ~InodeGuard()
    {
        if (ip)
        {
            VFS::iunlockput(ip); // Automatically unlock and release references
        }
    }
    // Copying is prohibited
    InodeGuard(const InodeGuard &) = delete;
    InodeGuard &operator=(const InodeGuard &) = delete;
};

// laod segment
static int loadseg(uint64 *pagetable, uint64 va, Inode *ip, uint64 offset, uint64 sz)
{
    for (uint64 i = 0; i < sz; i += PGSIZE)
    {
        uint64 pa = VM::walkaddr(pagetable, va + i);
        if (pa == 0)
            return -1;

        uint64 n = PGSIZE - (va + i) % PGSIZE;
        if (i + n > sz)
            n = sz - i;

        // Read physical address (isUser=0)
        if (ip->read((char *)(pa + (va + i) % PGSIZE), offset + i, n, 0) != (int)n)
            return -1;
    }
    return 0;
}

namespace Exec
{
    int exec(char *path, char **argv)
    {
        // Get Inode
        Inode *raw_ip = VFS::namei(path);
        if (!raw_ip)
            return -1;
        InodeGuard iguard(raw_ip);

        // Get ELF head
        struct elfhdr elf;
        if (raw_ip->read((char *)&elf, 0, sizeof(elf), 0) != sizeof(elf))
            return -1;
        if (elf.magic != ELF_MAGIC)
            return -1;
        // Create new pagetable
        VmGuard vm_guard;
        if (!vm_guard.pagetable)
            return -1;
        // Load Program Segment
        struct proghdr ph;
        for (int i = 0; i < elf.phnum; i++)
        {
            uint64 off = elf.phoff + i * sizeof(ph);
            if (raw_ip->read((char *)&ph, off, sizeof(ph), 0) != sizeof(ph))
                return -1;

            if (ph.type != ELF_PROG_LOAD)
                continue;
            if (ph.memsz < ph.filesz)
                return -1;
            if (ph.vaddr + ph.memsz < ph.vaddr)
                return -1;

            uint64 sz1 = VM::uvmalloc(vm_guard.pagetable, vm_guard.sz, ph.vaddr + ph.memsz, PTE_W | PTE_X | PTE_R | PTE_U);
            if (sz1 == 0)
                return -1;
            vm_guard.sz = sz1;

            if (loadseg(vm_guard.pagetable, ph.vaddr, raw_ip, ph.off, ph.filesz) < 0)
                return -1;
        }

        // Prepare user stack
        uint64 sz = PGROUNDUP(vm_guard.sz);

        const int stack_data_pages = 16;
        const int stack_total_pages = stack_data_pages + 1;

        uint64 sz1 = VM::uvmalloc(vm_guard.pagetable, sz, sz + stack_total_pages * PGSIZE, PTE_W | PTE_R | PTE_U);
        if (sz1 == 0)
            return -1;
        vm_guard.sz = sz1;

        VM::uvmunmap(vm_guard.pagetable, sz, 1, 0); // protected pagetable

        uint64 sp = sz1;
        uint64 stackbase = sp - stack_data_pages * PGSIZE;
        uint64 ustack[32];
        uint64 argc = 0;

        // Push parameter string
        for (; argv[argc]; argc++)
        {
            if (argc >= 31)
                return -1;
            sp -= strlen(argv[argc]) + 1;
            sp -= sp % 16;
            if (sp < stackbase)
                return -1;

            if (VM::copyout(vm_guard.pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
                return -1;
            ustack[argc] = sp;
        }
        ustack[argc] = 0;

        // Push into parameter array
        sp -= (argc + 1) * sizeof(uint64);
        sp -= sp % 16;
        if (sp < stackbase)
            return -1;
        if (VM::copyout(vm_guard.pagetable, sp, (char *)ustack, (argc + 1) * sizeof(uint64)) < 0)
            return -1;

        // Commit Changes
        struct Proc *p = myproc();
        if (VM::mappages(vm_guard.pagetable, TRAPFRAME, PGSIZE, (uint64)p->tf, PTE_R | PTE_W) < 0)
            return -1;

        uint64 oldsz = p->sz;
        uint64 *oldpagetable = p->pagetable;

        // setup Trapframe
        p->tf->a0 = argc;
        p->tf->a1 = sp;
        p->tf->sp = sp;
        p->tf->epc = elf.entry;

        // update process name
        char *s = path, *last = path;
        while (*s)
        {
            if (*s == '/')
                last = s + 1;
            s++;
        }
        // memmove(p->name, last, sizeof(p->name));
        size_t len = 0;
        while (last[len] && len < sizeof(p->name) - 1)
        {
            p->name[len] = last[len];
            len++;
        }
        p->name[len] = '\0';

        // change pagetable
        p->pagetable = vm_guard.commit();
        p->sz = vm_guard.sz;

        // release old pagetable
        VM::uvmfree(oldpagetable, oldsz);

        asm volatile("fence.i");

        return 0; // iguard unlocks and releases IP upon destruction
    }
}