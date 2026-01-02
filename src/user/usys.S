#include "kernel/syscall.h"

#define SYSCALL(name) \
    .global name; \
    name: \
        li a7, SYS_ ## name; \
        ecall; \
        ret

#define SYSCALL_NAME(name, sysname) \
    .global name; \
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 

SYSCALL(fork)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(fstat)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
SYSCALL(putc)
SYSCALL(disk_test)
SYSCALL(lseek)