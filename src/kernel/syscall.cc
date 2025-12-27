#include "kernel/syscall.h"
#include "common/types.h"
#include "kernel/proc.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "kernel/timer.h"

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
    // 简单模拟
    int fd;
    uint64 p;
    int n;

    if (argint(0, &fd) < 0 || argint(2, &n) < 0)
        return -1;
    p = argraw(1); // buffer address

    if (fd == 1)
    {
        struct Proc *proc = myproc();
        // 这里应该有 vm copyin 检查，暂时直接访问物理内存
        (void)p; // 消除 unused variable 警告

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