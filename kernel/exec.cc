/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * exec.cc — ELF64 binary loader and execve implementation
 *
 * Loads a static ELF64 executable into a fresh address space,
 * constructs the user stack (argc/argv/envp/auxv), and redirects
 * the current task's trapframe to begin executing at the ELF entry.
 *
 * Reference: Linux fs/binfmt_elf.c, fs/exec.c
 */

#include <lume/elf.h>
#include <lume/types.h>
#include <lume/task.h>
#include <lume/vmm.h>
#include <lume/addr.h>
#include <lume/config.h>
#include <lume/errno.h>
#include <lume/pmm.h>
#include <lume/kprintf.h>
#include <lume/klog.h>
#include <lume/file.h>
#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/namei.h>
#include <lume/fdtable.h>
#include <lume/mm_layout.h>
#include <lume/signal_types.h>
#include <arch/pmap.h>
#include <arch/trapframe.h>
#include <arch/mmu.h>
#include <arch/cpu.h>
#include <arch/trap.h>

/* Assembly entry points (trap_vector.S) */
extern "C" void trap_vector();
extern "C" [[noreturn]] void trap_dispatch(arch::TrapFrame*);
extern "C" void userret(arch::TrapFrame* tf);

/* ================================================================== */
/*  Constants                                                         */
/* ================================================================== */

/* User stack layout comes from mm_layout.h (MI layer).
 * kUserStackTop, kUserStackBase, kUserStackSize are defined there,
 * derived from kUserVaLimit so they automatically adapt to the
 * page table mode (SV39/SV48). */

/* ================================================================== */
/*  Helper: kernel_read — read from a file into a kernel buffer       */
/* ================================================================== */

static int64 kernel_read(file* fp, void* buf, uint64 count, int64 offset)
{
    int64 pos = offset;
    if (!fp->f_op || !fp->f_op->read) return -EINVAL;
    return fp->f_op->read(fp, static_cast<char*>(buf), count, &pos);
}

/* ================================================================== */
/*  Helper: copy data to a user page via kernel direct map             */
/* ================================================================== */

static void memcpy_kernel(void* dst, const void* src, uint64 n)
{
    auto* d = static_cast<uint8*>(dst);
    auto* s = static_cast<const uint8*>(src);
    for (uint64 i = 0; i < n; i++)
        d[i] = s[i];
}

static void memset_kernel(void* dst, uint8 val, uint64 n)
{
    auto* d = static_cast<uint8*>(dst);
    for (uint64 i = 0; i < n; i++)
        d[i] = val;
}

static uint64 strlen_kernel(const char* s)
{
    uint64 n = 0;
    while (s[n]) n++;
    return n;
}

/* ================================================================== */
/*  Helper: allocate and map a page at a specific user VA              */
/* ================================================================== */

static int map_page_at(VmSpace* mm, uint64 va, uint64 pte_perm)
{
    Page* pg = pmm_alloc_page();
    if (!pg) return -ENOMEM;

    uint64 pa = page_to_pa(pg).raw;

    /* Zero the page */
    void* kva = reinterpret_cast<void*>(pa_to_va(PhysAddr{pa}).raw);
    memset_kernel(kva, 0, kPageSize);

    int ret = pmap::map(mm->root_pa, va, pa, pte_perm);
    if (ret != 0) {
        pmm_free_page(pg);
        return -ENOMEM;
    }
    page_inc_mapcount(pg);
    return 0;
}

/* ================================================================== */
/*  load_elf_binary — parse ELF and map segments                      */
/* ================================================================== */

struct elf_load_info {
    uint64 entry;       /* ELF entry point (after base offset) */
    uint64 phdr_addr;   /* User VA where phdr was loaded */
    uint16 phnum;       /* Number of program headers */
    uint16 phentsize;   /* Size of each phdr */
    uint64 brk_start;   /* End of highest PT_LOAD segment (for brk) */
    uint64 load_bias;   /* PIE load bias (0 for ET_EXEC) */
};

static int load_elf_binary(file* fp, VmSpace* mm, elf_load_info* info)
{
    /* Read ELF header */
    Elf64_Ehdr ehdr{};
    int64 n = kernel_read(fp, &ehdr, sizeof(ehdr), 0);
    if (n < static_cast<int64>(sizeof(ehdr))) {
        printk(KERN_ERR "exec: failed to read ELF header (got %lld)\n", n);
        return -ENOEXEC;
    }

    /* Validate magic */
    if (ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
        ehdr.e_ident[EI_MAG1] != ELFMAG1 ||
        ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
        ehdr.e_ident[EI_MAG3] != ELFMAG3) {
        printk(KERN_ERR "exec: bad ELF magic\n");
        return -ENOEXEC;
    }

    /* Validate class (64-bit) and endianness (little-endian) */
    if (ehdr.e_ident[EI_CLASS] != ELFCLASS64) return -ENOEXEC;
    if (ehdr.e_ident[EI_DATA] != ELFDATA2LSB) return -ENOEXEC;

    /* Validate type and machine */
    if (ehdr.e_type != ET_EXEC && ehdr.e_type != ET_DYN) return -ENOEXEC;
    if (ehdr.e_machine != EM_RISCV) return -ENOEXEC;

    if (ehdr.e_phnum == 0 || ehdr.e_phentsize < sizeof(Elf64_Phdr))
        return -ENOEXEC;

    /* Read program headers */
    uint64 phdr_total = static_cast<uint64>(ehdr.e_phnum) * ehdr.e_phentsize;
    if (phdr_total > kPageSize) return -ENOEXEC;  /* Sanity limit */

    /* Allocate kernel buffer for program headers */
    uint8 phdr_buf[512];  /* Max ~8 phdrs * 56 bytes each */
    if (phdr_total > sizeof(phdr_buf)) return -ENOEXEC;

    n = kernel_read(fp, phdr_buf, phdr_total, static_cast<int64>(ehdr.e_phoff));
    if (n < static_cast<int64>(phdr_total)) return -ENOEXEC;

    info->phnum = ehdr.e_phnum;
    info->phentsize = ehdr.e_phentsize;
    info->phdr_addr = 0;
    info->brk_start = 0;
    info->load_bias = 0;

    /*
     * PIE (ET_DYN): segments have p_vaddr starting near 0.
     * We must choose a load base and add it to all addresses.
     * Linux uses ELF_ET_DYN_BASE (~2/3 of TASK_SIZE); we use 0x400000.
     */
    constexpr uint64 kPieLoadBase = 0x400000;
    uint64 load_bias = (ehdr.e_type == ET_DYN) ? kPieLoadBase : 0;
    info->load_bias = load_bias;
    info->entry = ehdr.e_entry + load_bias;

    /* Process each PT_LOAD segment */
    for (uint16 i = 0; i < ehdr.e_phnum; i++) {
        auto* phdr = reinterpret_cast<Elf64_Phdr*>(
            phdr_buf + i * ehdr.e_phentsize);

        if (phdr->p_type == PT_PHDR) {
            /* Remember where program headers are mapped */
            info->phdr_addr = phdr->p_vaddr + load_bias;
            continue;
        }

        if (phdr->p_type != PT_LOAD) continue;
        if (phdr->p_memsz == 0) continue;

        /* Compute permissions */
        uint64 perm = pmap::PTE_V | pmap::PTE_U;
        if (phdr->p_flags & PF_R) perm |= pmap::PTE_R;
        if (phdr->p_flags & PF_W) perm |= pmap::PTE_W;
        if (phdr->p_flags & PF_X) perm |= pmap::PTE_X;

        /* Page-align the segment boundaries (apply load bias for PIE) */
        uint64 seg_start = page_align_down(phdr->p_vaddr + load_bias);
        uint64 seg_end   = page_align_up(phdr->p_vaddr + phdr->p_memsz + load_bias);

        /* Create VMA for this segment */
        uint64 vm_perm = VM_USER;
        if (phdr->p_flags & PF_R) vm_perm |= VM_READ;
        if (phdr->p_flags & PF_W) vm_perm |= VM_WRITE;
        if (phdr->p_flags & PF_X) vm_perm |= VM_EXEC;

        int err = vmm_map_user(mm, seg_start, seg_end - seg_start, vm_perm);
        if (err) {
            printk(KERN_ERR "exec: vmm_map_user failed for segment %d: %d\n",
                   i, err);
            return err;
        }

        /* Map and fill pages */
        for (uint64 va = seg_start; va < seg_end; va += kPageSize) {
            err = map_page_at(mm, va, perm);
            if (err) return err;

            /* Determine how much file data goes into this page */
            uint64 file_seg_start = phdr->p_vaddr + load_bias;
            uint64 file_seg_end   = phdr->p_vaddr + phdr->p_filesz + load_bias;

            uint64 page_start = va;
            uint64 page_end   = va + kPageSize;

            /* Overlap between [page_start, page_end) and [file_seg_start, file_seg_end) */
            if (page_start < file_seg_end && page_end > file_seg_start) {
                uint64 copy_start = (page_start > file_seg_start) ? page_start : file_seg_start;
                uint64 copy_end   = (page_end < file_seg_end) ? page_end : file_seg_end;
                uint64 copy_len   = copy_end - copy_start;

                /* File offset for this data */
                uint64 file_off = phdr->p_offset + (copy_start - phdr->p_vaddr - load_bias);

                /* Get kernel VA of the mapped page */
                uint64 pa;
                if (!pmap::lookup(mm->root_pa, va, &pa)) return -EFAULT;
                uint8* kva = reinterpret_cast<uint8*>(pa_to_va(PhysAddr{pa}).raw);

                /* Read file data into the page */
                uint64 page_offset = copy_start - va;
                n = kernel_read(fp, kva + page_offset, copy_len,
                                static_cast<int64>(file_off));
                if (n < static_cast<int64>(copy_len)) {
                    printk(KERN_ERR "exec: short read at offset %llu\n", file_off);
                    return -EIO;
                }
            }
            /* BSS region (memsz > filesz) is already zeroed by map_page_at */
        }

        /* Track highest loaded address for brk */
        if (seg_end > info->brk_start)
            info->brk_start = seg_end;

        /* Detect which PT_LOAD contains the program header table.
         * Linux: fs/binfmt_elf.c line ~1209 */
        if (info->phdr_addr == 0 &&
            phdr->p_offset <= ehdr.e_phoff &&
            ehdr.e_phoff < phdr->p_offset + phdr->p_filesz) {
            info->phdr_addr = ehdr.e_phoff - phdr->p_offset
                            + phdr->p_vaddr + load_bias;
        }
    }

    /* phdr_addr should have been set by the PT_LOAD loop above
     * or by a PT_PHDR entry.  If still zero, something is wrong. */
    if (info->phdr_addr == 0) {
        printk(KERN_ERR "exec: unable to determine AT_PHDR address\n");
        return -ENOEXEC;
    }

    return 0;
}

/* ================================================================== */
/*  setup_user_stack — build argc/argv/envp/auxv on the user stack     */
/* ================================================================== */

static int setup_user_stack(VmSpace* mm, const char* const* argv,
                            const char* const* envp,
                            const elf_load_info* info,
                            uint64* out_sp)
{
    /* Create stack VMA */
    uint64 vm_perm = VM_USER | VM_READ | VM_WRITE;
    int err = vmm_map_user(mm, kUserStackBase, kUserStackSize, vm_perm);
    if (err) return err;

    /* We only need the top few pages for initial stack content.
     * Map 2 pages at the top for argc/argv/envp/auxv. */
    uint64 perm = pmap::PTE_V | pmap::PTE_U | pmap::PTE_R | pmap::PTE_W;
    for (uint64 va = kUserStackTop - 2 * kPageSize; va < kUserStackTop; va += kPageSize) {
        err = map_page_at(mm, va, perm);
        if (err) return err;
    }

    /* Count arguments and environment */
    int argc = 0;
    int envc = 0;
    if (argv) { while (argv[argc]) argc++; }
    if (envp) { while (envp[envc]) envc++; }

    /*
     * Build the stack from top down using kernel VA access.
     * Layout (top to bottom):
     *   1. String data (argv strings, envp strings)
     *   2. Padding (16-byte align)
     *   3. auxv[]
     *   4. NULL (end of envp)
     *   5. envp[] pointers
     *   6. NULL (end of argv)
     *   7. argv[] pointers
     *   8. argc
     */

    /* First pass: calculate total string space */
    uint64 str_total = 0;
    for (int i = 0; i < argc; i++)
        str_total += strlen_kernel(argv[i]) + 1;
    for (int i = 0; i < envc; i++)
        str_total += strlen_kernel(envp[i]) + 1;

    /* String area starts at top of stack */
    uint64 str_pos = kUserStackTop - str_total;
    str_pos &= ~15ULL;  /* 16-byte align */

    /* Copy strings and record user addresses */
    uint64 argv_addrs[32];  /* Max 32 args */
    uint64 envp_addrs[32];
    if (argc > 32) argc = 32;
    if (envc > 32) envc = 32;

    uint64 cur = str_pos;
    for (int i = 0; i < argc; i++) {
        uint64 len = strlen_kernel(argv[i]) + 1;
        argv_addrs[i] = cur;

        /* Copy string bytes to user stack via kernel VA */
        uint64 pa;
        if (!pmap::lookup(mm->root_pa, page_align_down(cur), &pa))
            return -EFAULT;
        uint8* kva = reinterpret_cast<uint8*>(pa_to_va(PhysAddr{pa}).raw);
        uint64 off = cur - page_align_down(cur);
        memcpy_kernel(kva + off, argv[i], len);
        cur += len;
    }
    for (int i = 0; i < envc; i++) {
        uint64 len = strlen_kernel(envp[i]) + 1;
        envp_addrs[i] = cur;

        uint64 pa;
        if (!pmap::lookup(mm->root_pa, page_align_down(cur), &pa))
            return -EFAULT;
        uint8* kva = reinterpret_cast<uint8*>(pa_to_va(PhysAddr{pa}).raw);
        uint64 off = cur - page_align_down(cur);
        memcpy_kernel(kva + off, envp[i], len);
        cur += len;
    }

    /* Build auxv, envp[], argv[], argc below the strings */
    /* Count entries: argc + argv_ptrs + NULL + envp_ptrs + NULL + auxv (6 pairs + terminator) */
    int auxv_count = 8;  /* AT_PHDR, AT_PHENT, AT_PHNUM, AT_PAGESZ, AT_BASE, AT_ENTRY, AT_RANDOM, AT_NULL */
    uint64 table_size = sizeof(uint64) * (1 + argc + 1 + envc + 1 + auxv_count * 2);
    uint64 table_start = str_pos - table_size;
    table_start &= ~15ULL;

    /* Write the table entries.
     * We need to handle page boundaries, but for simplicity we assume
     * the table fits in the already-mapped pages. */
    uint64 sp = table_start;

    /* Helper: write a uint64 to user stack */
    auto write_u64 = [&](uint64 addr, uint64 val) -> int {
        uint64 pa;
        if (!pmap::lookup(mm->root_pa, page_align_down(addr), &pa))
            return -EFAULT;
        uint8* kva = reinterpret_cast<uint8*>(pa_to_va(PhysAddr{pa}).raw);
        uint64 off = addr - page_align_down(addr);
        *reinterpret_cast<uint64*>(kva + off) = val;
        return 0;
    };

    /* argc */
    err = write_u64(sp, static_cast<uint64>(argc));
    if (err) return err;
    sp += 8;

    /* argv[] */
    for (int i = 0; i < argc; i++) {
        err = write_u64(sp, argv_addrs[i]);
        if (err) return err;
        sp += 8;
    }
    err = write_u64(sp, 0);  /* NULL terminator */
    if (err) return err;
    sp += 8;

    /* envp[] */
    for (int i = 0; i < envc; i++) {
        err = write_u64(sp, envp_addrs[i]);
        if (err) return err;
        sp += 8;
    }
    err = write_u64(sp, 0);  /* NULL terminator */
    if (err) return err;
    sp += 8;

    /* auxv[] */
    auto write_auxv = [&](uint64 type, uint64 val) -> int {
        int r = write_u64(sp, type);
        if (r) return r;
        sp += 8;
        r = write_u64(sp, val);
        if (r) return r;
        sp += 8;
        return 0;
    };

    write_auxv(AT_PHDR,   info->phdr_addr);
    write_auxv(AT_PHENT,  info->phentsize);
    write_auxv(AT_PHNUM,  info->phnum);
    write_auxv(AT_PAGESZ, kPageSize);
    write_auxv(AT_BASE,   info->load_bias);
    write_auxv(AT_ENTRY,  info->entry);
    write_auxv(AT_RANDOM, str_pos - 16);  /* Point to 16 bytes of zeros for now */
    write_auxv(AT_NULL,   0);

    *out_sp = table_start;
    return 0;
}

/* ================================================================== */
/*  do_execve — main entry point                                      */
/* ================================================================== */

int do_execve(const char* pathname, const char* const* argv,
              const char* const* envp)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return -EINVAL;

    /* 1. Look up the file */
    path p{};
    int err = filename_lookup(AT_FDCWD, pathname, 0, &p);
    if (err) {
        printk(KERN_ERR "exec: file not found: %s (err=%d)\n", pathname, err);
        return err;
    }

    inode* ip = p.de->d_inode;
    if (!ip || !S_ISREG(ip->i_mode)) {
        printk(KERN_ERR "exec: not a regular file: %s\n", pathname);
        return -EACCES;
    }

    /* Open a kernel file handle */
    file* fp = alloc_empty_file(O_RDONLY);
    if (!fp) {
        return -ENOMEM;
    }
    fp->f_inode = ip;
    fp->f_path = p;
    fp->f_op = ip->i_fop;
    fp->f_pos = 0;

    if (fp->f_op && fp->f_op->open) {
        err = fp->f_op->open(ip, fp);
        if (err) {
            fput(fp);
            return err;
        }
    }

    /* 2. Create new address space */
    VmSpace* new_mm = VmSpace::create();
    if (!new_mm) {
        fput(fp);
        return -ENOMEM;
    }

    /* 3. Load ELF segments */
    elf_load_info info{};
    err = load_elf_binary(fp, new_mm, &info);
    if (err) {
        printk(KERN_ERR "exec: load_elf_binary failed: %d\n", err);
        new_mm->put();
        fput(fp);
        dput(p.de);
        return err;
    }

    /* 4. Set up user stack */
    uint64 user_sp = 0;
    err = setup_user_stack(new_mm, argv, envp, &info, &user_sp);
    if (err) {
        printk(KERN_ERR "exec: setup_user_stack failed: %d\n", err);
        new_mm->put();
        fput(fp);
        return err;
    }

    /* Set brk */
    new_mm->brk_start = page_align_up(info.brk_start);
    new_mm->brk_end   = new_mm->brk_start;

    /* Set mmap base — Linux: arch_pick_mmap_layout() sets mm->mmap_base
     * to TASK_UNMAPPED_BASE = PAGE_ALIGN(TASK_SIZE / 3).
     * This ensures mmap(NULL) returns addresses well above the ELF
     * text/data segments. */
    new_mm->mmap_base = page_align_up(kUserVaLimit / 3);

    fput(fp);

    /* =============================================================== */
    /* Point of no return — replace the current process                */
    /* =============================================================== */

    /* 5a. Replace address space */
    VmSpace* old_mm = curr->mm;
    curr->mm = new_mm;
    pmap::activate(new_mm->root_pa);
    if (old_mm) old_mm->put();

    /* 5a'. Transition from kernel thread to user process.
     * Linux: begin_new_exec() in fs/exec.c:
     *   current->flags &= ~PF_KTHREAD;   (line 1173)
     *   tsk->exit_signal = SIGCHLD;       (line 1021)
     * Without this, a kernel_execve'd task stays marked as a kthread
     * and would be auto-reaped (exit_signal=-1) instead of becoming
     * a proper zombie for parent wait(). */
    curr->flags &= ~TF_KTHREAD;
    curr->exit_signal = SIGCHLD;

    /* 5b. Reset signal handlers to SIG_DFL (POSIX requirement).
     *
     * Linux fs/exec.c:flush_signal_handlers() runs under sighand->siglock.
     * Even though after fork our sighand is no longer shared with the
     * parent (we copy in task_clone), Linux still locks here — and so
     * must we, because the same sighand may be shared with CLONE_SIGHAND
     * sibling threads of the execing task.  Holding siglock here also
     * keeps the per-task blocked mask reset atomic w.r.t. concurrent
     * sigprocmask / signal delivery on this very task. */
    if (curr->sighand) {
        LockGuard guard(curr->sighand->siglock);
        for (int i = 0; i < _NSIG; i++) {
            if (curr->sighand->action[i].sa_handler != SIG_IGN)
                curr->sighand->action[i].sa_handler = SIG_DFL;
            curr->sighand->action[i].sa_flags = 0;
            curr->sighand->action[i].sa_mask.clear();
        }
        curr->blocked.clear();
    } else {
        curr->blocked.clear();
    }

    /* 5c. Close O_CLOEXEC file descriptors */
    /* TODO: implement close-on-exec */

    /* 6. Set up trapframe to enter user space */
    arch::TrapFrame* tf = curr->trapframe;
    if (!tf) {
        printk(KERN_ERR "exec: no trapframe!\n");
        task_kill_current(SIGKILL);
        return -EINVAL;  /* not reached */
    }

    /* Initialize trapframe for user-mode return.
     * This is the MI equivalent of Linux's start_thread() + kernel
     * metadata setup.  All arch-specific details (sstatus, FP state,
     * kernel_satp, kernel_sp, trap handler address, etc.) are handled
     * by the MD layer.  MI exec never touches arch registers. */
    arch::trapframe_init_user(tf, info.entry, user_sp);

    pr_debug_s(KLOG_SUBSYS_EXEC,
               "exec: pid %d entry=%llx sp=%llx phdr=%llx\n",
               curr->pid, info.entry, user_sp, info.phdr_addr);

    /* Verify loaded data at entry point — debug-level, ring buffer only. */
    {
        uint64 pa;
        if (pmap::lookup(curr->mm->root_pa, page_align_down(info.entry), &pa)) {
            uint8* kva = reinterpret_cast<uint8*>(pa_to_va(PhysAddr{pa}).raw);
            uint64 off = info.entry - page_align_down(info.entry);
            pr_debug_s(KLOG_SUBSYS_EXEC,
                       "exec: entry bytes @%llx: %02x %02x %02x %02x %02x %02x %02x %02x\n",
                       info.entry,
                       kva[off+0], kva[off+1], kva[off+2], kva[off+3],
                       kva[off+4], kva[off+5], kva[off+6], kva[off+7]);
        }
        for (uint64 va = 0x10000; va < 0x14000; va += kPageSize) {
            if (pmap::lookup(curr->mm->root_pa, va, &pa)) {
                uint8* kva2 = reinterpret_cast<uint8*>(pa_to_va(PhysAddr{pa}).raw);
                pr_debug_s(KLOG_SUBSYS_EXEC,
                           "exec: page %llx: %02x%02x%02x%02x %02x%02x%02x%02x\n",
                           va, kva2[0], kva2[1], kva2[2], kva2[3],
                           kva2[4], kva2[5], kva2[6], kva2[7]);
            } else {
                pr_debug_s(KLOG_SUBSYS_EXEC,
                           "exec: page %llx: NOT MAPPED\n", va);
            }
        }
    }

    /* Flush instruction cache after loading executable code into memory.
     * Without this, the I-cache may contain stale data for the pages
     * we just loaded, causing the CPU to execute garbage. */
    arch::mmu::flush_icache();

    return 0;  /* Will return to user mode via trap return */
}

/* ================================================================== */
/*  sys_execve_wrapper — syscall entry point                          */
/* ================================================================== */

int64 sys_execve_wrapper(uint64 a0, uint64 a1, uint64 a2,
                         uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    const char* pathname = reinterpret_cast<const char*>(a0);
    const char* const* argv = reinterpret_cast<const char* const*>(a1);
    const char* const* envp = reinterpret_cast<const char* const*>(a2);

    return do_execve(pathname, argv, envp);
}

/* ================================================================== */
/*  kernel_execve — call execve from kernel context (e.g. init)       */
/* ================================================================== */

int kernel_execve(const char* pathname, const char* const* argv,
                  const char* const* envp)
{
    TaskControlBlock* curr = current_task();

    int ret = do_execve(pathname, argv, envp);
    if (ret != 0)
        return ret;

    /*
     * do_execve succeeded: the trapframe is set up with entry point,
     * user stack, and sstatus (SPP=0 for U-mode). We must NOT return
     * normally — that would go back through the kthread return path
     * and jump to address 0. Instead, jump directly to user mode via
     * the same userret() path that fork_child_entry uses.
     *
     * Switch stvec from kernelvec to trap_vector so that traps from
     * U-mode are handled by the user trap entry path (which loads
     * kernel context from the trapframe via sscratch).
     */
    arch::trap::set_vector(reinterpret_cast<uint64>(trap_vector));
    userret(curr->trapframe);
    __builtin_unreachable();
}
