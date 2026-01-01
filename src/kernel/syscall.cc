#include "kernel/syscall.h"
#include "common/types.h"
#include "common/fcntl.h"
#include "kernel/proc.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "drivers/virtio.h"
#include "kernel/timer.h"
#include "kernel/mm.h"
#include "kernel/trap.h"
#include "fs/fat32.h"
#include "fs/file.h"

extern "C++" int fork();

namespace ProcManager
{
    void exit(int status);
    int wait(uint64_t addr);
}


static uint64_t argraw(int n)
{
    Proc *p = myproc();
    switch (n)
    {
    case 0:
        return p->tf->a0;
    case 1:
        return p->tf->a1;
    case 2:
        return p->tf->a2;
    case 3:
        return p->tf->a3;
    case 4:
        return p->tf->a4;
    case 5:
        return p->tf->a5;
    default:
        return static_cast<uint64_t>(-1);
    }
}

static int argint(int n, int *ip)
{
    *ip = static_cast<int>(argraw(n));
    return 0;
}

static int argstr(int n, char *buf, int max)
{
    uint64 addr = argraw(n);
    return VM::copyinstr(myproc()->pagetable, buf, addr, max);
}

static int fdalloc(struct file *f)
{
    struct Proc *p = myproc();
    for (int i = 0; i < NOFILE; i++)
    {
        if (p->ofile[i] == 0)
        {
            p->ofile[i] = f;
            return i;
        }
    }
    return -1;
}

static uint64 sys_open()
{
    char path[128];
    int omode;
    int fd;
    struct file *f;
    Inode *ip;

    if (argstr(0, path, 128) < 0 || argint(1, &omode) < 0)
        return -1;

    ip = VFS::namei(path);
    if (ip == nullptr)
    {
        return -1;
    }

    f = FileTable::alloc();
    if (f == nullptr)
    {
        VFS::iput(ip);
        return -1;
    }

    fd = fdalloc(f);
    if (fd < 0)
    {
        f->ref = 0;
        f->type = FD_NONE;
        VFS::iput(ip);
        return -1;
    }

    f->type = FD_INODE;
    f->ip = ip;
    f->off = 0;
    f->readable = !(omode & O_WRONLY);
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

    return fd;
}

static uint64 sys_close()
{
    int fd;
    if (argint(0, &fd) < 0)
        return -1;

    struct Proc *p = myproc();
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == 0)
        return -1;

    FileTable::close(p->ofile[fd]);
    p->ofile[fd] = 0;
    return 0;
}

static uint64 sys_exit()
{
    int n;
    if (argint(0, &n) < 0)
        return static_cast<uint64>(-1);
    ProcManager::exit(n);
    return 0;
}

static uint64 sys_fork()
{
    return static_cast<uint64>(fork());
}

static uint64 sys_wait()
{
    uint64 p = argraw(0);
    return static_cast<uint64>(ProcManager::wait(p));
}

static uint64 sys_getpid()
{
    return static_cast<uint64>(myproc()->pid);
}

static uint64 sys_putc()
{
    char c = static_cast<char>(argraw(0));
    Drivers::uart_putc(c);
    return 0;
}

static uint64 sys_write()
{
    struct file *f;
    int n;
    uint64 p;
    int fd;

    if (argint(0, &fd) < 0 || argint(2, &n) < 0 || argint(1, (int *)&p) < 0)
        return -1;

    struct Proc *proc = myproc();

    p = argraw(1);

    // Drivers::uart_puts("DEBUG: sys_write fd=");
    // Drivers::uart_put_int(fd);
    // Drivers::uart_puts(" len=");
    // Drivers::uart_put_int(n);
    // Drivers::uart_puts("\n");

    if (fd == 1 && proc->ofile[fd] == nullptr) // stdout
    {
        constexpr int MAX_WRITE_BUF = 128;
        char buf[MAX_WRITE_BUF];
        int i = 0;

        while (i < n)
        {
            int len = n - i;
            if (len > MAX_WRITE_BUF)
                len = MAX_WRITE_BUF;

            if (VM::copyin(proc->pagetable, buf, p + i, static_cast<uint64>(len)) < 0)
            {
                Drivers::uart_puts("sys_write: copyin failed\n");
                return static_cast<uint64>(-1);
            }

            for (int j = 0; j < len; j++)
            {
                Drivers::uart_putc(buf[j]);
            }
            i += len;
        }
        return static_cast<uint64>(n);
    }
    if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0)
        return static_cast<uint64>(-1);

    return FileTable::write(f, p, n);
}

static uint64_t sys_read()
{
    struct file *f;
    int n;
    uint64 p;
    int fd;

    // get param: fd, buf, len
    if (argint(0, &fd) < 0 || argint(2, &n) < 0 || argint(1, (int *)&p) < 0)
        return -1;
    
    struct Proc* proc = myproc();
    if (fd == 0 && proc->ofile[fd] == nullptr)
    {
        return Drivers::console_read(p, n);
    }

    if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0)
        return -1;

    return FileTable::read(f, p, n);

    return -1;
}

static uint64 sys_sbrk()
{
    int n;
    if (argint(0, &n) < 0)
        return -1;

    uint64 addr = myproc()->sz;
    if (ProcManager::growproc(n) < 0)
        return -1;

    return addr;
}

static uint64 sys_disk_test()
{
    // VirtIO::test_rw();
    // VirtIO::test_bio();
    fat32_test();
    return 0;
}

void syscall()
{
    Proc *p = myproc();
    int num = p->tf->a7;
    uint64 ret = static_cast<uint64>(-1);

    /* Just For Debug */
    // Drivers::uart_puts("Syscall: ");
    // Drivers::print_hex(num);
    // Drivers::uart_puts("\n");

    switch (num)
    {
    case SYS_open:
        ret = sys_open();
        break;
    case SYS_close:
        ret = sys_close();
        break;
    case SYS_write:
        ret = sys_write();
        break;
    case SYS_read:
        ret = sys_read();
        break;
    case SYS_putc:
        ret = sys_putc();
        break;
    case SYS_fork:
        ret = sys_fork();
        break;
    case SYS_exit:
        ret = sys_exit();
        break;
    case SYS_wait:
        ret = sys_wait();
        break;
    case SYS_getpid:
        ret = sys_getpid();
        break;
    case SYS_sbrk:
        ret = sys_sbrk();
        break;
    case SYS_disk_test:
        ret = sys_disk_test();
        break;
    default:
        Drivers::uart_puts("Unknown Syscall ID: ");
        Drivers::print_hex(num);
        Drivers::uart_puts("\n");
        ret = static_cast<uint64>(-1);
        break;
    }

    p->tf->a0 = ret;
}