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
#include <lume/console.h>
#include <arch/cpu.h>

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
    if (nr >= static_cast<uint64>(kNrSyscalls)) {
        kprintf("[syscall] nr=%llu out of range\n", nr);
        return -ENOSYS;
    }

    /* Per-syscall entry trace.  KLOG_DEBUG keeps it out of the console
     * by default; enable via klog_set_level(KLOG_DEBUG) or read the
     * ring buffer to investigate.  Subsys mask gates this further. */
    pr_debug_s(KLOG_SUBSYS_SYSCALL,
               "syscall: nr=%llu a0=%llx a1=%llx a2=%llx a3=%llx\n",
               nr, args[0], args[1], args[2], args[3]);

    SyscallHandler handler = sys_call_table[nr];
    if (!handler) {
        kprintf("[syscall] unimplemented nr=%llu\n", nr);
        return -ENOSYS;
    }

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
int64 sys_nanosleep(uint64, uint64, uint64, uint64, uint64, uint64);

/* sys_mm.cc */
int64 sys_brk(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_mmap(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_munmap(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_mprotect(uint64, uint64, uint64, uint64, uint64, uint64);

/* sys_info.cc */
int64 sys_uname(uint64, uint64, uint64, uint64, uint64, uint64);

/* sys_fs.cc */
int64 sys_openat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_close(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_read(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_write(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_lseek(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_fstat_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getdents64(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_dup(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_dup3(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getcwd(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_chdir(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_mkdirat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_unlinkat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_writev(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_ioctl(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_ppoll(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_pipe2(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_fcntl(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_socket(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_sendto(uint64, uint64, uint64, uint64, uint64, uint64);

/* sys_signal.cc */
int64 sys_kill(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_tkill(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_tgkill(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_rt_sigaction(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_rt_sigprocmask(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_rt_sigreturn(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_rt_sigtimedwait(uint64, uint64, uint64, uint64, uint64, uint64);

/* exec.cc */
int64 sys_execve_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);

/* sys_misc.cc */
int64 sys_reboot(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_prctl(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_setsid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getsid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_setpgid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getpgid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_geteuid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getegid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_sigaltstack(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_clock_gettime(uint64, uint64, uint64, uint64, uint64, uint64);

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

    /* Phase 3: filesystem */
    sys_call_table[SYS_openat]          = sys_openat;
    sys_call_table[SYS_close]           = sys_close;
    sys_call_table[SYS_read]            = sys_read;
    sys_call_table[SYS_write]           = sys_write;
    sys_call_table[SYS_lseek]           = sys_lseek;
    sys_call_table[SYS_fstat]           = sys_fstat_wrapper;
    sys_call_table[SYS_getdents64]      = sys_getdents64;
    sys_call_table[SYS_dup]             = sys_dup;
    sys_call_table[SYS_dup3]            = sys_dup3;
    sys_call_table[SYS_getcwd]          = sys_getcwd;
    sys_call_table[SYS_chdir]           = sys_chdir;
    sys_call_table[SYS_mkdirat]         = sys_mkdirat;
    sys_call_table[SYS_unlinkat]        = sys_unlinkat;
    sys_call_table[SYS_writev]          = sys_writev;
    sys_call_table[SYS_ioctl]           = sys_ioctl;
    sys_call_table[SYS_ppoll]           = sys_ppoll;

    /* Phase 4: signals */
    sys_call_table[SYS_kill]             = sys_kill;
    sys_call_table[SYS_tkill]            = sys_tkill;
    sys_call_table[SYS_tgkill]           = sys_tgkill;
    sys_call_table[SYS_rt_sigaction]     = sys_rt_sigaction;
    sys_call_table[SYS_rt_sigprocmask]   = sys_rt_sigprocmask;
    sys_call_table[SYS_rt_sigreturn]     = sys_rt_sigreturn;
    sys_call_table[SYS_rt_sigtimedwait]  = sys_rt_sigtimedwait;

    /* Phase 5: exec */
    sys_call_table[SYS_execve]           = sys_execve_wrapper;

    /* Phase 6: pipe + fcntl */
    sys_call_table[SYS_pipe2]            = sys_pipe2;
    sys_call_table[SYS_fcntl]            = sys_fcntl;

    /* Phase 7: busybox bootstrap */
    sys_call_table[SYS_reboot]           = sys_reboot;
    sys_call_table[SYS_prctl]            = sys_prctl;
    sys_call_table[SYS_setsid]           = sys_setsid;
    sys_call_table[SYS_getsid]           = sys_getsid;
    sys_call_table[SYS_setpgid]          = sys_setpgid;
    sys_call_table[SYS_getpgid]          = sys_getpgid;
    sys_call_table[SYS_geteuid]          = sys_geteuid;
    sys_call_table[SYS_getegid]          = sys_getegid;
    sys_call_table[SYS_sigaltstack]      = sys_sigaltstack;
    sys_call_table[SYS_clock_gettime]    = sys_clock_gettime;
    sys_call_table[SYS_nanosleep]        = sys_nanosleep;
    sys_call_table[SYS_socket]           = sys_socket;
    sys_call_table[SYS_sendto]           = sys_sendto;

    printk(KERN_INFO "init: syscall_init done (%d handlers registered)\n", 46);
}
