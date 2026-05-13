/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * System Call MI Layer — Jump Table & Dispatcher
 *
 * O(1) function pointer array dispatch. No switch-case.
 * syscall_init() registers all implemented handlers.
 *
 * Reference: docs/specs/syscall.md §6
 */

#include <lume/syscall.h>
#include <lume/syscall_nr.h>
#include <lume/errno.h>
#include <lume/kprintf.h>
#include <lume/klog.h>

/* ======================================================================
 * Jump table
 * ====================================================================== */

inline constexpr int kNrSyscalls = 512;

static SyscallHandler sys_call_table[kNrSyscalls];

/* ======================================================================
 * MI Dispatcher
 * ====================================================================== */

int64 syscall_dispatch(uint64 nr, uint64 args[6])
{
    if (nr >= static_cast<uint64>(kNrSyscalls))
        return -ENOSYS;

    SyscallHandler handler = sys_call_table[nr];
    if (!handler)
        return -ENOSYS;

    return handler(args[0], args[1], args[2],
                   args[3], args[4], args[5]);
}

/* ======================================================================
 * Forward declarations of sys_* handlers
 * ====================================================================== */

/* sys_process.cc */
int64 sys_exit(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_exit_group(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getpid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_gettid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getppid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_sched_yield_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_clone_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_wait4_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_set_tid_address(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getuid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getgid(uint64, uint64, uint64, uint64, uint64, uint64);

/* sys_mm.cc */
int64 sys_brk(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_mmap(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_munmap(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_mprotect(uint64, uint64, uint64, uint64, uint64, uint64);

/* sys_info.cc */
int64 sys_uname(uint64, uint64, uint64, uint64, uint64, uint64);

/* ======================================================================
 * syscall_init — register all handlers
 * ====================================================================== */

void syscall_init()
{
    /* Zero the table (redundant for BSS, but explicit) */
    for (int i = 0; i < kNrSyscalls; i++)
        sys_call_table[i] = nullptr;

    /* Phase 2: minimal runnable set */
    sys_call_table[SYS_exit]            = sys_exit;
    sys_call_table[SYS_exit_group]      = sys_exit_group;
    sys_call_table[SYS_getpid]          = sys_getpid;
    sys_call_table[SYS_gettid]          = sys_gettid;
    sys_call_table[SYS_getppid]         = sys_getppid;
    sys_call_table[SYS_sched_yield]     = sys_sched_yield_wrapper;
    sys_call_table[SYS_clone]           = sys_clone_wrapper;
    sys_call_table[SYS_wait4]           = sys_wait4_wrapper;
    sys_call_table[SYS_set_tid_address] = sys_set_tid_address;
    sys_call_table[SYS_getuid]          = sys_getuid;
    sys_call_table[SYS_getgid]          = sys_getgid;
    sys_call_table[SYS_brk]             = sys_brk;
    sys_call_table[SYS_mmap]            = sys_mmap;
    sys_call_table[SYS_munmap]          = sys_munmap;
    sys_call_table[SYS_mprotect]        = sys_mprotect;
    sys_call_table[SYS_uname]           = sys_uname;

    printk(KERN_INFO "init: syscall_init done (16 handlers registered)\n");
}
