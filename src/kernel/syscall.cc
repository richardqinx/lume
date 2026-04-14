// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 */
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
#include "kernel/slab.h"
#include "kernel/sbi.h"
#include "fs/fat32.h"
#include "fs/file.h"
#include "lib/string.h"
#include "lib/errno.h"

extern "C++" int fork();
namespace Exec
{
    int exec(char *path, char **argv);
}

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

struct KernelArgv
{
    static const int MAX_ARGS = 32;
    static const int MAX_ARG_LEN = 128;
    char *args[MAX_ARGS];

    KernelArgv() { memset(args, 0, sizeof(args)); }
    ~KernelArgv()
    {
        for (int i = 0; i < MAX_ARGS; i++)
            if (args[i])
            {
                Slab::kfree(args[i]);
                args[i] = nullptr;
            }
    }
    KernelArgv(const KernelArgv &) = delete;
    KernelArgv &operator=(const KernelArgv &) = delete;
};

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

// sys_openat(int dfd, const char *filename, int flags, mode_t mode)
static uint64 sys_openat()
{
    char path[128];
    int dfd, omode, mode_unused;
    int fd;
    struct file *f;
    Inode *ip;

    if (argint(0, &dfd) < 0 || argstr(1, path, 128) < 0 || argint(2, &omode) < 0 || argint(3, &mode_unused) < 0)
        return -EINVAL;

    if (omode & O_CREATE)
    {
        ip = VFS::namei(path);
        if (ip == nullptr)
        {
            char name[128];
            Inode *dp = VFS::nameiparent(path, name);
            if (dp)
            {
                VFS::ilock(dp);
                ip = dp->create(name, T_FILE, 0, 0);
                VFS::iunlockput(dp);
            }
        }
    }
    else
    {
        ip = VFS::namei(path);
    }

    if (ip == nullptr)
        return -ENOENT;

    VFS::ilock(ip);
    if ((omode & O_TRUNC) && ip->type == T_FILE)
    {
        ip->truncate();
    }
    VFS::iunlock(ip);

    f = FileTable::alloc();
    if (f == nullptr)
    {
        VFS::iput(ip);
        return -ENFILE;
    }

    fd = fdalloc(f);
    if (fd < 0)
    {
        f->ref = 0;
        f->type = FD_NONE;
        VFS::iput(ip);
        return -EMFILE;
    }

    f->type = FD_INODE;
    f->ip = ip;
    f->off = 0;
    f->readable = !(omode & O_WRONLY);
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

    return fd;
}

// sys_mkdirat(int dfd, const char *pathname, mode_t mode)
static uint64 sys_mkdirat()
{
    char path[128];
    int dfd, mode;

    if (argint(0, &dfd) < 0 || argstr(1, path, 128) < 0 || argint(2, &mode) < 0)
        return -EINVAL;

    Inode *ip = VFS::namei(path);
    if (ip != nullptr)
    {
        VFS::iput(ip);
        return -EEXIST;
    }

    char name[128];
    Inode *dp = VFS::nameiparent(path, name);
    if (dp == nullptr)
        return -ENOENT;

    VFS::ilock(dp);
    ip = dp->create(name, T_DIR, 0, 0);
    VFS::iunlockput(dp);

    if (ip == nullptr)
        return -EIO;

    VFS::iput(ip);
    return 0;
}

static uint64 sys_chdir()
{
    char path[128];
    if (argstr(0, path, 128) < 0)
        return -EFAULT;

    Inode *ip = VFS::namei(path);
    if (ip == nullptr)
        return -ENOENT;

    VFS::ilock(ip);
    if (ip->type != T_DIR)
    {
        VFS::iunlockput(ip);
        return -ENOTDIR;
    }
    VFS::iunlock(ip);

    struct Proc *p = myproc();
    if (p->cwd)
        VFS::iput(p->cwd);
    p->cwd = ip;
    return 0;
}

static uint64 sys_dup()
{
    int oldfd;
    if (argint(0, &oldfd) < 0)
        return -EINVAL;

    struct Proc *p = myproc();
    if (oldfd < 0 || oldfd >= NOFILE || p->ofile[oldfd] == nullptr)
        return -EBADF;

    struct file *f = FileTable::dup(p->ofile[oldfd]);
    int newfd = fdalloc(f);
    if (newfd < 0)
    {
        FileTable::close(f);
        return -EMFILE;
    }
    return newfd;
}

static uint64 sys_fstat()
{
    int fd;
    uint64 stat_addr;

    if (argint(0, &fd) < 0 || argint(1, (int *)&stat_addr) < 0)
        return -EINVAL;

    struct Proc *p = myproc();
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == nullptr)
        return -EBADF;

    if (FileTable::stat(p->ofile[fd], stat_addr) < 0)
        return -EIO;

    return 0;
}

// sys_mknodat(int dfd, const char *filename, mode_t mode, dev_t dev)
static uint64 sys_mknodat()
{
    char path[128];
    int dfd, mode, dev;

    if (argint(0, &dfd) < 0 || argstr(1, path, 128) < 0 || argint(2, &mode) < 0 || argint(3, &dev) < 0)
        return -EINVAL;

    Inode *ip = VFS::namei(path);
    if (ip != nullptr)
    {
        VFS::iput(ip);
        return -EEXIST;
    }

    char name[128];
    Inode *dp = VFS::nameiparent(path, name);
    if (dp == nullptr)
        return -ENOENT;

    // Decode dev_t (Assuming simplified minor/major for now)
    int major = (dev >> 20) & 0xFFF; // Just a guess for Linux packing, or pass raw
    int minor = dev & 0xFFFFF;

    // For Phase 1 compatibility with init.cc:
    // init.cc passes raw major/minor. Shim will pack them.
    // We just unpack naively or assume Shim passed us correct structure.

    VFS::ilock(dp);
    ip = dp->create(name, T_DEVICE, major, minor);
    VFS::iunlockput(dp);

    if (ip == nullptr)
        return -EIO;

    VFS::iput(ip);
    return 0;
}

static uint64 sys_close()
{
    int fd;
    if (argint(0, &fd) < 0)
        return -EINVAL;

    struct Proc *p = myproc();
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == 0)
        return -EBADF;

    FileTable::close(p->ofile[fd]);
    p->ofile[fd] = 0;
    return 0;
}

static uint64 sys_pipe2()
{
    uint64 fdarray;
    int flags;
    struct file *rf, *wf;
    int fd0, fd1;
    struct Proc *p = myproc();

    if (argint(0, (int *)&fdarray) < 0 || argint(1, &flags) < 0)
        return -EFAULT;

    if (Pipe::create_pair(&rf, &wf) < 0)
        return -ENFILE;

    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    {
        if (fd0 >= 0)
            p->ofile[fd0] = nullptr;
        FileTable::close(rf);
        FileTable::close(wf);
        return -EMFILE;
    }

    if (VM::copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(int)) < 0 ||
        VM::copyout(p->pagetable, fdarray + sizeof(int), (char *)&fd1, sizeof(int)) < 0)
    {
        p->ofile[fd0] = nullptr;
        p->ofile[fd1] = nullptr;
        FileTable::close(rf);
        FileTable::close(wf);
        return -EFAULT;
    }
    return 0;
}

static uint64 sys_unlinkat()
{
    char path[128], name[128];
    int dfd, flag;

    if (argint(0, &dfd) < 0 || argstr(1, path, 128) < 0 || argint(2, &flag) < 0)
        return -EINVAL;

    Inode *dp = VFS::nameiparent(path, name);
    if (!dp)
        return -ENOENT;

    VFS::ilock(dp);
    int ret = dp->unlink(name);
    VFS::iunlockput(dp);

    return (ret < 0) ? -EIO : 0;
}

// sys_linkat(int olddirfd, const char *oldpath, int newdirfd, const char *newpath, int flags)
static uint64 sys_linkat()
{
    // FAT32 does not support hard links.
    // Return Error to allow compilation/running to proceed (ln will fail gracefully).
    return -EPERM;
}

static uint64 sys_execve()
{
    char path[128];
    uint64 uargv_ptr;

    if (argstr(0, path, sizeof(path)) < 0)
        return -EFAULT;

    uargv_ptr = argraw(1);
    // uenvp_ptr = argraw(2); // Ignored

    KernelArgv kargv;

    for (int i = 0; i < KernelArgv::MAX_ARGS; ++i)
    {
        uint64 uarg_str_ptr;
        if (VM::copyin(myproc()->pagetable, (char *)&uarg_str_ptr, uargv_ptr + i * sizeof(uint64), sizeof(uint64)) < 0)
            {
                return -EFAULT;
            }

        if (uarg_str_ptr == 0)
        {
            kargv.args[i] = nullptr;
            break;
        }

        kargv.args[i] = (char *)Slab::kmalloc(KernelArgv::MAX_ARG_LEN);
        if (kargv.args[i] == nullptr)
            {
                return -ENOMEM;
            }

        if (VM::copyinstr(myproc()->pagetable, kargv.args[i], uarg_str_ptr, KernelArgv::MAX_ARG_LEN) < 0)
            {
                return -EFAULT;
            }
    }
    return Exec::exec(path, kargv.args);
}

static uint64 sys_exit()
{
    int n;
    if (argint(0, &n) < 0)
        return -EINVAL;
    ProcManager::exit(n);
    return 0;
}

static uint64 sys_clone()
{
    return static_cast<uint64>(fork());
}

static uint64 sys_wait4()
{
    uint64 status_addr;

    // argraw(0) is pid (ignored)
    status_addr = argraw(1);
    // argraw(2) is options (ignored)
    // argraw(3) is rusage (ignored)

    if (status_addr == static_cast<uint64>(-1))
        return -EINVAL;

    return static_cast<uint64>(ProcManager::wait(status_addr));
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

    if (argint(0, &fd) < 0 || argint(1, (int *)&p) < 0 || argint(2, &n) < 0)
        return -EINVAL;

    p = argraw(1);

    struct Proc *proc = myproc();

    if (fd == 1 && proc->ofile[fd] == nullptr)
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
                return -EFAULT;

            for (int j = 0; j < len; j++)
            {
                Drivers::uart_putc(buf[j]);
            }
            i += len;
        }
        return static_cast<uint64>(n);
    }

    if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0)
        return -EBADF;

    return FileTable::write(f, p, n);
}

static uint64_t sys_read()
{
    struct file *f;
    int n;
    uint64 p;
    int fd;

    if (argint(0, &fd) < 0 || argint(1, (int *)&p) < 0 || argint(2, &n) < 0)
        return -EINVAL;

    p = argraw(1);

    struct Proc *proc = myproc();
    if (fd == 0 && proc->ofile[fd] == nullptr)
        return Drivers::console_read(p, n);

    if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0)
        return -EBADF;

    return FileTable::read(f, p, n);
}

static uint64 sys_brk()
{
    int n;
    if (argint(0, &n) < 0)
        return -EINVAL;

    uint64 addr = myproc()->sz;
    if (ProcManager::growproc(n) < 0)
        return -ENOMEM;

    return addr;
}

static uint64 sys_kill()
{
    int pid;
    if (argint(0, &pid) < 0)
        return -EINVAL;
    return ProcManager::kill(pid);
}

static uint64 sys_sleep()
{
    int n;
    uint64 ticks0;

    if (argint(0, &n) < 0)
        return -EINVAL;

    Spinlock *lk = Timer::get_lock();
    lk->acquire();
    ticks0 = Timer::get_ticks();
    while (Timer::get_ticks() - ticks0 < (uint64)n)
    {
        if (myproc()->killed)
        {
            lk->release();
            return -EINTR;
        }
        ProcManager::sleep(Timer::get_tick_chan(), lk);
    }
    lk->release();
    return 0;
}

static uint64 sys_disk_test()
{
    // VirtIO::test_rw();
    // VirtIO::test_bio();
    fat32_test();
    return 0;
}

static uint64 sys_lseek()
{
    int fd, offset, whence;
    if (argint(0, &fd) < 0 || argint(1, &offset) < 0 || argint(2, &whence) < 0)
        return -EINVAL;

    struct Proc *p = myproc();
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == 0)
        return -EBADF;

    return FileTable::lseek(p->ofile[fd], offset, whence);
}

static uint64 sys_reboot()
{
    SBI::sbi_shutdown();
    return 0;
}

void syscall()
{
    Proc *p = myproc();
    int num = p->tf->a7;
    uint64 ret = static_cast<uint64>(-ENOSYS);

    switch (num)
    {
    case SYS_mknodat:
        ret = sys_mknodat();
        break;
    case SYS_mkdirat:
        ret = sys_mkdirat();
        break;
    case SYS_unlinkat:
        ret = sys_unlinkat();
        break;
    case SYS_linkat:
        ret = sys_linkat();
        break;
    case SYS_chdir:
        ret = sys_chdir();
        break;
    case SYS_openat:
        ret = sys_openat();
        break;
    case SYS_dup:
        ret = sys_dup();
        break;
    case SYS_close:
        ret = sys_close();
        break;
    case SYS_pipe2:
        ret = sys_pipe2();
        break;
    case SYS_lseek:
        ret = sys_lseek();
        break;
    case SYS_read:
        ret = sys_read();
        break;
    case SYS_write:
        ret = sys_write();
        break;
    case SYS_fstat:
        ret = sys_fstat();
        break;
    case SYS_exit:
        ret = sys_exit();
        break;
    case SYS_exit_group:
        ret = sys_exit();
        break;
    case SYS_kill:
        ret = sys_kill();
        break;
    case SYS_getpid:
        ret = sys_getpid();
        break;
    case SYS_brk:
        ret = sys_brk();
        break;
    case SYS_clone:
        ret = sys_clone();
        break;
    case SYS_execve:
        ret = sys_execve();
        if (ret == 0)
            return;
        break;
    case SYS_wait4:
        ret = sys_wait4();
        break;

    // Custom / Debug
    case SYS_reboot:
        ret = sys_reboot();
        break;
    case SYS_putc:
        ret = sys_putc();
        break;
    case SYS_disk_test:
        ret = sys_disk_test();
        break;
    case SYS_nanosleep:
        ret = sys_sleep();
        break;

    default:
        Drivers::uart_puts("Unknown Syscall ID: ");
        Drivers::print_hex(num);
        Drivers::uart_puts("\n");
        ret = -ENOSYS;
        break;
    }

    p->tf->a0 = ret;
}