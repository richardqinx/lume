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

    KernelArgv()
    {
        memset(args, 0, sizeof(args));
    }

    ~KernelArgv()
    {
        for (int i = 0; i < MAX_ARGS; i++)
        {
            if (args[i])
            {
                Slab::kfree(args[i]);
                args[i] = nullptr;
            }
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

static uint64 sys_open()
{
    char path[128];
    int omode;
    int fd;
    struct file *f;
    Inode *ip;

    if (argstr(0, path, 128) < 0 || argint(1, &omode) < 0)
        return -1;

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
    {
        return -1;
    }

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

static uint64 sys_mkdir()
{
    char path[128];
    if (argstr(0, path, 128) < 0)
        return -1;

    Inode *ip = VFS::namei(path);
    if (ip != nullptr)
    {
        VFS::iput(ip);
        return -1; // the dir is exist
    }

    char name[128];
    Inode *dp = VFS::nameiparent(path, name);
    if (dp == nullptr)
        return -1;

    VFS::ilock(dp);
    ip = dp->create(name, T_DIR, 0, 0);
    VFS::iunlockput(dp);

    if (ip == nullptr)
        return -1;

    VFS::iput(ip);
    return 0;
}

static uint64 sys_chdir()
{
    char path[128];
    if (argstr(0, path, 128) < 0)
        return -1;

    Inode *ip = VFS::namei(path);
    if (ip == nullptr)
        return -1;

    VFS::ilock(ip);
    if (ip->type != T_DIR)
    {
        VFS::iunlockput(ip);
        return -1;
    }
    VFS::iunlock(ip);

    struct Proc *p = myproc();
    VFS::iput(p->cwd); // release old cwd
    p->cwd = ip;       // switch to new cwd

    return 0;
}

static uint64 sys_dup()
{
    int oldfd;
    if (argint(0, &oldfd) < 0)
        return -1;

    struct Proc *p = myproc();
    if (oldfd < 0 || oldfd >= NOFILE || p->ofile[oldfd] == nullptr)
        return -1;

    struct file *f = FileTable::dup(p->ofile[oldfd]);
    int newfd = fdalloc(f);
    if (newfd < 0)
    {
        FileTable::close(f); // fdalloc failed
        return -1;
    }
    return newfd;
}

static uint64 sys_fstat()
{
    int fd;
    uint64 stat_addr;

    if (argint(0, &fd) < 0 || argint(1, (int *)&stat_addr) < 0)
        return -1;

    struct Proc *p = myproc();
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == nullptr)
        return -1;

    return FileTable::stat(p->ofile[fd], stat_addr);
}

static uint64 sys_mknod()
{
    char path[128];
    int major, minor;

    if (argstr(0, path, 128) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0)
        return -1;

    Inode *ip = VFS::namei(path);
    if (ip != nullptr)
    {
        VFS::iput(ip);
        return -1;
    }

    char name[128];
    Inode *dp = VFS::nameiparent(path, name);
    if (dp == nullptr)
        return -1;

    VFS::ilock(dp);
    ip = dp->create(name, T_DEVICE, major, minor);
    VFS::iunlockput(dp);

    if (ip == nullptr)
        return -1;

    VFS::iput(ip);
    return 0;
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

static uint64 sys_pipe()
{
    uint64 fdarray; // int fd[2]
    struct file *rf, *wf;
    int fd0, fd1;
    struct Proc *p = myproc();

    if (argint(0, (int *)&fdarray) < 0)
        return -1;

    if(Pipe::create_pair(&rf, &wf) < 0)
        return -1;

    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0)
    {
        if (fd0 >= 0)
            p->ofile[fd0] = nullptr;
        FileTable::close(rf);
        FileTable::close(wf);
        return -1;
    }

    if (VM::copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(int)) < 0 ||
        VM::copyout(p->pagetable, fdarray + sizeof(int), (char *)&fd1, sizeof(int)) < 0)
    {
        p->ofile[fd0] = nullptr;
        p->ofile[fd1] = nullptr;
        FileTable::close(rf);
        FileTable::close(wf);
        return -1;
    }
    return 0;
}

static uint64 sys_link()
{
    Drivers::uart_puts("Not supported now");
    return -1;
}

static uint64 sys_unlink()
{
    char path[128], name[128];
    if (argstr(0, path, 128) < 0)
        return -1;

    Inode *dp = VFS::nameiparent(path, name);
    if (!dp)
        return -1;

    VFS::ilock(dp);
    int ret = dp->unlink(name);
    VFS::iunlockput(dp);

    return ret;
}

static uint64 sys_exec()
{
    char path[128];
    uint64 uargv_ptr;

    if (argstr(0, path, sizeof(path)) < 0)
    {
        return -1;
    }

    uargv_ptr = argraw(1);

    KernelArgv kargv;

    for (int i = 0; i < KernelArgv::MAX_ARGS; ++i)
    {
        uint64 uarg_str_ptr;

        if (VM::copyin(myproc()->pagetable, (char *)&uarg_str_ptr, uargv_ptr + i * sizeof(uint64), sizeof(uint64)) < 0)
        {
            return -1;
        }

        if (uarg_str_ptr == 0)
        {
            kargv.args[i] = nullptr;
            break;
        }

        kargv.args[i] = (char *)Slab::kmalloc(KernelArgv::MAX_ARG_LEN);
        if (kargv.args[i] == nullptr)
        {
            return -1;
        }

        if (VM::copyinstr(myproc()->pagetable, kargv.args[i], uarg_str_ptr, KernelArgv::MAX_ARG_LEN) < 0)
        {
            return -1;
        }
    }

    return Exec::exec(path, kargv.args);
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
        
    p = argraw(1);

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

static uint64 sys_uptime()
{
    return Timer::get_ticks();
}

static uint64 sys_kill()
{
    int pid;
    if (argint(0, &pid) < 0)
        return -1;

    return ProcManager::kill(pid);
}

static uint64 sys_sleep()
{
    int n;
    uint64 ticks0;

    if (argint(0, &n) < 0)
        return -1;

    Spinlock *lk = Timer::get_lock();
    lk->acquire();

    ticks0 = Timer::get_ticks();

    while (Timer::get_ticks() - ticks0 < (uint64)n)
    {
        if (myproc()->killed)
        {
            lk->release();
            return -1;
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
        return -1;

    struct Proc *p = myproc();
    if (fd < 0 || fd >= NOFILE || p->ofile[fd] == 0)
        return -1;

    return FileTable::lseek(p->ofile[fd], offset, whence);
}

static uint64 sys_shutdown()
{
    SBI::sbi_shutdown();
    while (1)
        ;
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
    case SYS_exec:
        ret = sys_exec();
        if (ret != static_cast<uint64>(-1))
            return;
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
    case SYS_lseek:
        ret = sys_lseek();
        break;
    case SYS_dup:
        ret = sys_dup();
        break;
    case SYS_fstat:
        ret = sys_fstat();
        break;
    case SYS_chdir:
        ret = sys_chdir();
        break;
    case SYS_mkdir:
        ret = sys_mkdir();
        break;
    case SYS_mknod:
        ret = sys_mknod();
        break;
    case SYS_pipe:
        ret = sys_pipe();
        break;
    case SYS_unlink:
        ret = sys_unlink();
        break;
    case SYS_link:
        Drivers::uart_puts("Unimplemented syscall\n");
        ret = sys_link();
        break;
    case SYS_uptime:
        ret = sys_uptime();
        break;
    case SYS_sleep:
        ret = sys_sleep();
        break;
    case SYS_kill:
        ret = sys_kill();
        break;
    case SYS_shutdown:
        ret = sys_shutdown();
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