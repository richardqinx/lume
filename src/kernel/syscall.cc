#include "kernel/syscall.h"
#include "common/types.h"
#include "kernel/proc.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "drivers/virtio.h"
#include "kernel/timer.h"
#include "kernel/mm.h"
#include "kernel/trap.h"

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


static uint64_t sys_exit()
{
    int n;
    if (argint(0, &n) < 0)
        return static_cast<uint64_t>(-1);
    ProcManager::exit(n);
    return 0;
}

static uint64_t sys_fork()
{
    return static_cast<uint64_t>(fork());
}

static uint64_t sys_wait()
{
    uint64_t p = argraw(0);
    return static_cast<uint64_t>(ProcManager::wait(p));
}

static uint64_t sys_getpid()
{
    return static_cast<uint64_t>(myproc()->pid);
}

static uint64_t sys_putc()
{
    char c = static_cast<char>(argraw(0));
    Drivers::uart_putc(c);
    return 0;
}

static uint64_t sys_write()
{
    int fd;
    int n;
    uint64_t p;

    if (argint(0, &fd) < 0 || argint(2, &n) < 0)
        return static_cast<uint64_t>(-1);

    p = argraw(1);

    // Drivers::uart_puts("DEBUG: sys_write fd=");
    // Drivers::uart_put_int(fd);
    // Drivers::uart_puts(" len=");
    // Drivers::uart_put_int(n);
    // Drivers::uart_puts("\n");

    if (fd == 1) // stdout
    {
        Proc *proc = myproc();
        constexpr int MAX_WRITE_BUF = 128;
        char buf[MAX_WRITE_BUF];
        int i = 0;

        while (i < n)
        {
            int len = n - i;
            if (len > MAX_WRITE_BUF)
                len = MAX_WRITE_BUF;

            if (VM::copyin(proc->pagetable, buf, p + i, static_cast<uint64_t>(len)) < 0)
            {
                Drivers::uart_puts("sys_write: copyin failed\n");
                return static_cast<uint64_t>(-1);
            }

            for (int j = 0; j < len; j++)
            {
                Drivers::uart_putc(buf[j]);
            }
            i += len;
        }
        return static_cast<uint64_t>(n);
    }
    return static_cast<uint64_t>(-1);
}

static uint64_t sys_read()
{
    int fd;
    int n;
    uint64_t p;

    // get param: fd, buf, len
    if (argint(0, &fd) < 0 || argint(2, &n) < 0)
        return -1;
    p = argraw(1);

    if (fd == 0) // stdin
    {
        return Drivers::console_read(p, n);
    }
    return -1;
}

static uint64_t sys_sbrk()
{
    int n;
    if (argint(0, &n) < 0)
        return -1;

    uint64_t addr = myproc()->sz;
    if (ProcManager::growproc(n) < 0)
        return -1;

    return addr;
}

static uint64_t sys_disk_test()
{
    VirtIO::test_rw();
    return 0;
}

void syscall()
{
    Proc *p = myproc();
    int num = p->tf->a7;
    uint64_t ret = static_cast<uint64_t>(-1);

    /* Just For Debug */
    // Drivers::uart_puts("Syscall: ");
    // Drivers::print_hex(num);
    // Drivers::uart_puts("\n");

    switch (num)
    {
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
        ret = static_cast<uint64_t>(-1);
        break;
    }

    p->tf->a0 = ret;
}