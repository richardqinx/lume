// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 * Lume OS - Linux Compatibility Layer
 *
 * Strictly aligned with Linux RISC-V 64 ABI (asm-generic)
 * Reference: linux/usr/include/asm-generic/unistd.h
 */

#pragma once

// File System
#define SYS_getcwd 17
#define SYS_dup 23
#define SYS_dup3 24
#define SYS_fcntl 25
#define SYS_ioctl 29
#define SYS_mknodat 33
#define SYS_mkdirat 34
#define SYS_unlinkat 35
#define SYS_linkat 37
#define SYS_umount2 39
#define SYS_mount 40
#define SYS_statfs 43
#define SYS_ftruncate 46
#define SYS_faccessat 48
#define SYS_chdir 49
#define SYS_fchmod 52
#define SYS_fchmodat 53
#define SYS_fchownat 54
#define SYS_openat 56
#define SYS_close 57
#define SYS_vhangup 58
#define SYS_pipe2 59
#define SYS_getdents64 61
#define SYS_lseek 62
#define SYS_read 63
#define SYS_write 64
#define SYS_readv 65
#define SYS_writev 66
#define SYS_pread64 67
#define SYS_pwrite64 68
#define SYS_pselect6 72
#define SYS_ppoll 73
#define SYS_readlinkat 78
#define SYS_fstatat 79 // newfstatat
#define SYS_fstat 80

// Process Management
#define SYS_exit 93
#define SYS_exit_group 94
#define SYS_set_tid_address 96
#define SYS_nanosleep 101
#define SYS_kill 129
#define SYS_rt_sigaction 134
#define SYS_times 153
#define SYS_uname 160
#define SYS_gettimeofday 169
#define SYS_getpid 172
#define SYS_getppid 173
#define SYS_getuid 174
#define SYS_geteuid 175
#define SYS_getgid 176
#define SYS_getegid 177
#define SYS_sysinfo 179
#define SYS_brk 214
#define SYS_munmap 215
#define SYS_mremap 216
#define SYS_clone 220
#define SYS_execve 221
#define SYS_mmap 222
#define SYS_wait4 260
#define SYS_prlimit64 261

// System
#define SYS_reboot 142 // Used for shutdown

// === Custom / Debug (Non-Standard) ===
// Placed above 1000 to avoid conflicts with Linux ABI
#define SYS_putc 1000
#define SYS_disk_test 1001

#ifndef __ASSEMBLER__
void syscall();
#endif