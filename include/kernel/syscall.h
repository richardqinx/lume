#pragma once

#define SYS_putc    1
#define SYS_fork    2
#define SYS_exit    3
#define SYS_wait    4
#define SYS_pipe    5
#define SYS_read    6
#define SYS_kill    7
#define SYS_exec    8
#define SYS_fstat   9
#define SYS_chdir   10
#define SYS_dup     11
#define SYS_getpid  12
#define SYS_sbrk    13
#define SYS_sleep   14
#define SYS_uptime  15
#define SYS_open    16
#define SYS_write   17
#define SYS_mknod   18
#define SYS_unlink  19
#define SYS_link    20
#define SYS_mkdir   21
#define SYS_close   22
#define SYS_disk_test 23

#ifndef __ASSEMBLER__
void syscall();
#endif