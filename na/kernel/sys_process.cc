/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Process Control System Calls
 *
 * Implements: exit, exit_group, getpid, gettid, getppid,
 *             sched_yield, clone (stub), wait4 (stub),
 *             set_tid_address, getuid, getgid.
 *
 * Reference: docs/specs/syscall.md §7.1
 */

#include <lume/types.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/errno.h>
#include <lume/uaccess.h>
#include <lume/wait.h>

/* External: task lifecycle (kernel/task.cc) */
extern void task_exit(int code);
extern void task_destroy(TaskControlBlock* task);
extern int32 task_wait(int32* exit_code);
extern int32 task_fork(arch::TrapFrame* tf);

/* ======================================================================
 * sys_exit / sys_exit_group
 * ====================================================================== */

int64 sys_exit(uint64 code, uint64, uint64, uint64, uint64, uint64)
{
    task_exit(static_cast<int>(code & 0xFF));
    __builtin_unreachable();
}

int64 sys_exit_group(uint64 code, uint64, uint64, uint64, uint64, uint64)
{
    /* Phase 2: single-threaded, equivalent to sys_exit.
     * Phase 3: kill all threads in tgid then exit. */
    task_exit(static_cast<int>(code & 0xFF));
    __builtin_unreachable();
}

/* ======================================================================
 * sys_getpid / sys_gettid / sys_getppid
 * ====================================================================== */

int64 sys_getpid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    return current_task()->tgid;  /* Linux: getpid() returns tgid */
}

int64 sys_gettid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    return current_task()->pid;   /* Linux: gettid() returns real tid */
}

int64 sys_getppid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    TaskControlBlock* parent = current_task()->parent;
    return parent ? parent->tgid : 0;
}

/* ======================================================================
 * sys_sched_yield
 * ====================================================================== */

int64 sys_sched_yield_wrapper(uint64, uint64, uint64, uint64, uint64, uint64)
{
    sched_yield();
    return 0;
}

int64 sys_clone_wrapper(uint64 flags, uint64 child_stack,
                        uint64 ptid, uint64 ctid, uint64 tls, uint64)
{
    /* Phase A: Simple fork() support.
     * Ignore flags/stack for now and just clone the current task. */
    (void)flags; (void)child_stack; (void)ptid; (void)ctid; (void)tls;

    arch::TrapFrame* tf = current_task()->trapframe;
    if (!tf) return -EINVAL;

    return task_fork(tf);
}

/* ========================================================================
 * sys_wait4 — Wait for child to exit
 * ======================================================================== */

int64 sys_wait4_wrapper(uint64 pid, uint64 wstatus_ptr,
                        uint64 options, uint64, uint64, uint64)
{
    /* Phase A: Basic wait() support.
     * TODO: Implement pid-specific wait and WNOHANG in task_wait. */
    (void)pid; (void)options;

    int32 exit_code = 0;
    int32 child_pid = task_wait(&exit_code);

    if (child_pid < 0) return child_pid;

    if (wstatus_ptr != 0) {
        int wstatus = 0;
        if (exit_code & kExitCodeSignalFlag) {
            wstatus = exit_code & 0x7F;
        } else {
            wstatus = W_EXITCODE(exit_code);
        }
        if (copy_to_user(wstatus_ptr, &wstatus, sizeof(int)) < 0)
            return -EFAULT;
    }

    return child_pid;
}

/* ======================================================================
 * sys_set_tid_address — musl libc calls this very early
 * ====================================================================== */

int64 sys_set_tid_address(uint64 tidptr, uint64, uint64,
                          uint64, uint64, uint64)
{
    /* Phase 2: store the clear_child_tid pointer (needed for futex wakeup).
     * For now just return current tid. */
    (void)tidptr;
    return current_task()->pid;
}

/* ======================================================================
 * sys_getuid / sys_getgid — Phase 2: always root
 * ====================================================================== */

int64 sys_getuid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    return 0; /* root */
}

int64 sys_getgid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    return 0; /* root */
}
