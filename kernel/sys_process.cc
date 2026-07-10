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

#include "lume/klog.h"
#include <lume/types.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/errno.h>
#include <lume/uaccess.h>
#include <lume/wait.h>

/* External: task lifecycle (kernel/task.cc) */
extern void task_exit(int code);
extern int32 do_wait4(int32 wait_pid, int options, int32* exit_code);
extern int32 task_clone(arch::TrapFrame* tf, uint64 clone_flags,
                        uint64 child_stack, uint64 parent_tidptr,
                        uint64 child_tidptr, uint64 tls);
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
    arch::TrapFrame* tf = current_task()->trapframe;
    if (!tf) return -EINVAL;

    return task_clone(tf, flags, child_stack, ptid, ctid, tls);
}

/* ========================================================================
 * sys_wait4 — Wait for child to exit
 * ======================================================================== */

int64 sys_wait4_wrapper(uint64 pid, uint64 wstatus_ptr,
                        uint64 options, uint64, uint64, uint64)
{
    int32 exit_code = 0;
    int32 child_pid = do_wait4(static_cast<int32>(pid),
                               static_cast<int>(options),
                               &exit_code);

    if (child_pid < 0) return child_pid;

    /* exit_code is already in Linux wstatus format */
    if (wstatus_ptr != 0) {
        if (copy_to_user(wstatus_ptr, &exit_code, sizeof(int)) < 0)
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
    /* Store clear_child_tid pointer — on exit, kernel writes 0 here
     * and does futex_wake (enables pthread_join). */
    current_task()->clear_child_tid = tidptr;
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

/* ======================================================================
 * sys_nanosleep (SYS_nanosleep = 101)
 * ====================================================================== */
#include <lume/wait.h>
#include <lume/kprintf.h>
#include <lume/timer.h>

struct linux_timespec {
    int64 tv_sec;
    int64 tv_nsec;
};

static void nanosleep_wakeup(TimerList* t) {
    TaskControlBlock* task = static_cast<TaskControlBlock*>(t->data);
    task->state = TaskState::Runnable;
    sched_enqueue(task);
}

int64 sys_nanosleep(uint64 req_ptr, uint64 rem_ptr, uint64, uint64, uint64, uint64) {
    if (req_ptr == 0) return -EINVAL;

    linux_timespec req;
    if (copy_from_user(&req, req_ptr, sizeof(req)) != 0) {
        return -EFAULT;
    }

    uint64 target = *(volatile uint64*)&g_jiffies + (req.tv_sec * 100) + (req.tv_nsec / 10000000);
    
    TaskControlBlock* curr = current_task();
    curr->state = TaskState::Sleeping;
    
    TimerList t;
    t.init(nanosleep_wakeup);
    t.expires = target;
    t.data = curr;
    
    add_timer(&t);
    
    if (*(volatile uint64*)&g_jiffies < target) {
        schedule();
    } else {
        curr->state = TaskState::Running;
    }
    
    
    del_timer(&t);

    return 0;
}
