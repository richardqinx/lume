#include "kernel/syscall.h"
#include "common/types.h"
#include "kernel/proc.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "kernel/timer.h"
#include "kernel/mm.h"

extern int fork();

namespace ProcManager
{
    void exit(int status);
    int wait(uint64 addr);
}

uint64 argraw(int n)
{
    struct Proc *p = myproc();
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
    }
    return -1;
}

int argint(int n, int *ip)
{
    *ip = argraw(n);
    return 0;
}

uint64 sys_exit()
{
    int n;
    if (argint(0, &n) < 0)
        return -1;
    ProcManager::exit(n);
    return 0;
}

uint64 sys_fork()
{
    return fork();
}

uint64 sys_wait()
{
    uint64 p;
    p = argraw(0);
    return ProcManager::wait(p);
}

uint64 sys_getpid()
{
    return myproc()->pid;
}

uint64 sys_putc()
{
    char c = (char)argraw(0);
    Drivers::uart_putc(c);
    return 0;
}

uint64 sys_write()
{
    int fd;
    uint64 p;
    int n;

    if (argint(0, &fd) < 0 || argint(2, &n) < 0 || argraw(1) == 0)
        return -1;
    p = argraw(1);

    if (fd == 1)
    {
        struct Proc *proc = myproc();
        const int max = 128;
        char buf[max];
        int i = 0;

        while (i < n)
        {
            int len = n - i;
            if (len > max)
                len = max;

            if (VM::copyin(proc->pagetable, buf, p + i, len) < 0)
            {
                return -1;
            }

            for (int j = 0; j < len; j++)
            {
                Drivers::uart_putc(buf[j]);
            }
            i += len;
        }
        return n;
    }
    return -1;
}

void syscall()
{
    struct Proc *p = myproc();
    int num = p->tf->a7;
    uint64 ret = -1;

    switch (num)
    {
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
    case SYS_write:
        ret = sys_write();
        break;
    default:
        Drivers::uart_puts("Unknown Syscall ID: ");
        Drivers::print_hex(num);
        Drivers::uart_puts("\n");
        ret = -1;
        break;
    }

    p->tf->a0 = ret;
}