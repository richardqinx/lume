/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * System Call Numbers — RISC-V LP64 (asm-generic/unistd.h compatible)
 *
 * Numbering strictly follows Linux asm-generic so that musl libc / Busybox
 * binaries can be run without modification.
 *
 * Reference: docs/specs/syscall.md §4.3
 */

inline constexpr int SYS_exit           = 93;
inline constexpr int SYS_exit_group     = 94;
inline constexpr int SYS_set_tid_address = 96;
inline constexpr int SYS_sched_yield    = 124;
inline constexpr int SYS_uname          = 160;
inline constexpr int SYS_getpid         = 172;
inline constexpr int SYS_getppid        = 173;
inline constexpr int SYS_getuid         = 174;
inline constexpr int SYS_getgid         = 176;
inline constexpr int SYS_gettid         = 178;
inline constexpr int SYS_brk            = 214;
inline constexpr int SYS_munmap         = 215;
inline constexpr int SYS_clone          = 220;
inline constexpr int SYS_execve         = 221;
inline constexpr int SYS_mmap           = 222;
inline constexpr int SYS_mprotect       = 226;
inline constexpr int SYS_wait4          = 260;

inline constexpr int SYS_getcwd         = 17;
inline constexpr int SYS_dup            = 23;
inline constexpr int SYS_dup3           = 24;
inline constexpr int SYS_ioctl          = 29;
inline constexpr int SYS_mkdirat        = 34;
inline constexpr int SYS_unlinkat       = 35;
inline constexpr int SYS_chdir          = 49;
inline constexpr int SYS_openat         = 56;
inline constexpr int SYS_close          = 57;
inline constexpr int SYS_pipe2          = 59;
inline constexpr int SYS_lseek          = 62;
inline constexpr int SYS_read           = 63;
inline constexpr int SYS_write          = 64;
inline constexpr int SYS_writev         = 66;
inline constexpr int SYS_ppoll          = 73;
inline constexpr int SYS_fstatat        = 79;
inline constexpr int SYS_fstat          = 80;

inline constexpr int SYS_kill           = 129;
inline constexpr int SYS_rt_sigaction   = 134;
inline constexpr int SYS_rt_sigprocmask = 135;
inline constexpr int SYS_rt_sigreturn   = 139;

inline constexpr int SYS_futex          = 98;
inline constexpr int SYS_nanosleep      = 101;
inline constexpr int SYS_clock_gettime  = 113;
inline constexpr int SYS_epoll_create1  = 20;
inline constexpr int SYS_epoll_ctl      = 21;
inline constexpr int SYS_epoll_pwait    = 22;
