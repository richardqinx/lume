# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin

#include "kernel/syscall.h"

#define SYSCALL_NAME(name, sysname) \
    .global name; \
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_openat, openat)
SYSCALL_NAME(sys_mknodat, mknodat)
SYSCALL_NAME(sys_mkdirat, mkdirat)
SYSCALL_NAME(sys_unlinkat, unlinkat)
SYSCALL_NAME(sys_linkat, linkat)
SYSCALL_NAME(sys_chdir, chdir)
SYSCALL_NAME(sys_dup, dup)
SYSCALL_NAME(sys_fstat, fstat)
SYSCALL_NAME(sys_read, read)
SYSCALL_NAME(sys_write, write)
SYSCALL_NAME(sys_close, close)
SYSCALL_NAME(sys_pipe2, pipe2)
SYSCALL_NAME(sys_clone, clone)
SYSCALL_NAME(sys_execve, execve)
SYSCALL_NAME(sys_wait4, wait4)
SYSCALL_NAME(sys_exit, exit)
SYSCALL_NAME(sys_getpid, getpid)
SYSCALL_NAME(sys_brk, brk)
SYSCALL_NAME(sys_kill, kill)
SYSCALL_NAME(sys_nanosleep, nanosleep)
SYSCALL_NAME(sys_reboot, reboot)
SYSCALL_NAME(sys_lseek, lseek)

# === Custom / Debug Syscalls ===
SYSCALL_NAME(sys_putc, putc)
SYSCALL_NAME(sys_disk_test, disk_test)