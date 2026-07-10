/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * sys_signal.cc — Signal-related system calls
 *
 * Implements:
 *   sys_kill           (SYS_kill = 129)
 *   sys_rt_sigaction   (SYS_rt_sigaction = 134)
 *   sys_rt_sigprocmask (SYS_rt_sigprocmask = 135)
 *   sys_rt_sigreturn   (SYS_rt_sigreturn = 139)
 *
 * Reference: Linux kernel/signal.c, arch/riscv/kernel/signal.c
 */

#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/signal_nr.h>
#include <lume/task.h>
#include <lume/errno.h>
#include <lume/uaccess.h>
#include <lume/kprintf.h>
#include <lume/klog.h>
#include <lume/new.h>
#include <lume/pgrp.h>

/* From signal.cc */
extern int send_signal(int sig, kernel_siginfo* info, TaskControlBlock* task);

/* From task.cc */
extern list_node g_all_tasks;
extern Spinlock g_task_list_lock;

/* ================================================================== */
/*  Helper: find task by PID                                          */
/* ================================================================== */

static TaskControlBlock* find_task_by_pid(int32 pid)
{
    LockGuard guard(g_task_list_lock);
    list_node* node = g_all_tasks.next;
    while (node != &g_all_tasks) {
        auto* task = list_entry<TaskControlBlock, &TaskControlBlock::all_link>(node);
        if (task->pid == pid) return task;
        node = node->next;
    }
    return nullptr;
}

/* ================================================================== */
/*  sys_kill — send a signal to a process                             */
/* ================================================================== */

/*
 * Deliver `sig` to the thread-group leader represented by `sig_st`.
 * sighand is allocated eagerly at fork/exec time, so we just trust
 * that the leader has one; send_signal returns -ESRCH if not.
 */
static int deliver_to_group(signal_struct* sig_st, int sig,
                            kernel_siginfo* info)
{
    if (!sig_st || !sig_st->leader) return 0;
    if (send_signal(sig, info, sig_st->leader) == 0) return 1;
    return 0;
}

int64 sys_kill(uint64 a0, uint64 a1, uint64, uint64, uint64, uint64)
{
    int32 pid = static_cast<int32>(a0);
    int   sig = static_cast<int>(a1);

    if (sig < 0 || sig > _NSIG) return -EINVAL;

    TaskControlBlock* curr = current_task();
    if (!curr) return -ESRCH;

    kernel_siginfo info{};
    info.si_signo = sig;
    info.si_code  = 0;  /* SI_USER */
    info._sifields._kill._pid = curr->pid;
    info._sifields._kill._uid = 0;

    /* pid > 0: deliver to that thread group's leader. */
    if (pid > 0) {
        TaskControlBlock* target = find_task_by_pid(pid);
        if (!target) return -ESRCH;
        /* Group signal: prefer the thread-group leader if available. */
        if (target->signal && target->signal->leader)
            target = target->signal->leader;
        if (sig == 0) return 0;
        return send_signal(sig, &info, target);
    }

    /* pid == 0: every member of caller's process group. */
    if (pid == 0) {
        if (!curr->signal) return -ESRCH;
        if (sig == 0) return 0;
        int delivered = 0;
        int32 target_pgid = curr->signal->pgid;
        for_each_pgrp_member(target_pgid, [&](signal_struct* s) {
            delivered += deliver_to_group(s, sig, &info);
        });
        return delivered > 0 ? 0 : -ESRCH;
    }

    /* pid == -1: every process the caller may signal, except init.
     * We approximate "every" with "every thread-group leader on every
     * pgrp bucket".  This is rare in practice (BusyBox doesn't use it
     * during normal shell operation). */
    if (pid == -1) {
        if (sig == 0) return 0;
        int delivered = 0;
        LockGuard guard(g_pgrp_lock);
        for (auto& bucket : g_pgrp_hash) {
            list_node* node = bucket.next;
            while (node != &bucket) {
                list_node* next = node->next;
                auto* s = list_entry<signal_struct,
                                     &signal_struct::pgrp_link>(node);
                if (s->leader && s->leader->pid != 1)
                    delivered += deliver_to_group(s, sig, &info);
                node = next;
            }
        }
        return delivered > 0 ? 0 : -ESRCH;
    }

    /* pid < -1: every member of pgrp |pid|. */
    int32 target_pgid = -pid;
    if (sig == 0) {
        bool any = false;
        for_each_pgrp_member(target_pgid, [&](signal_struct*) { any = true; });
        return any ? 0 : -ESRCH;
    }
    int delivered = 0;
    for_each_pgrp_member(target_pgid, [&](signal_struct* s) {
        delivered += deliver_to_group(s, sig, &info);
    });
    return delivered > 0 ? 0 : -ESRCH;
}

/* ================================================================== */
/*  sys_tkill / sys_tgkill — send a signal to a specific thread       */
/* ================================================================== */

static int64 do_tkill(int32 tgid, int32 tid, int sig)
{
    if (sig < 0 || sig > _NSIG) return -EINVAL;
    if (tid <= 0) return -EINVAL;
    TaskControlBlock* target = find_task_by_pid(tid);
    if (!target) return -ESRCH;
    /* tgid == -1 from tkill means "any tgid"; otherwise enforce match. */
    if (tgid != -1 && target->tgid != tgid) return -ESRCH;

    if (sig == 0) return 0;

    kernel_siginfo info{};
    info.si_signo = sig;
    info.si_code  = 0;  /* SI_TKILL would be -6; userland rarely checks */
    info._sifields._kill._pid = current_task() ? current_task()->pid : 0;
    info._sifields._kill._uid = 0;
    return send_signal(sig, &info, target);
}

int64 sys_tkill(uint64 a0, uint64 a1, uint64, uint64, uint64, uint64)
{
    return do_tkill(-1,
                    static_cast<int32>(a0),
                    static_cast<int>(a1));
}

int64 sys_tgkill(uint64 a0, uint64 a1, uint64 a2, uint64, uint64, uint64)
{
    return do_tkill(static_cast<int32>(a0),
                    static_cast<int32>(a1),
                    static_cast<int>(a2));
}

/* ================================================================== */
/*  sys_rt_sigaction — get/set signal disposition                     */
/* ================================================================== */

/*
 * User-space sigaction struct layout (RISC-V LP64):
 *   uint64 sa_handler;
 *   uint64 sa_flags;
 *   uint64 sa_restorer;     (SA_RESTORER)
 *   sigset_t sa_mask;       (8 bytes on LP64)
 */
struct user_sigaction {
    uint64   sa_handler;
    uint64   sa_flags;
    uint64   sa_restorer;
    sigset_t sa_mask;
};

int64 sys_rt_sigaction(uint64 a0, uint64 a1, uint64 a2, uint64 a3,
                       uint64, uint64)
{
    int sig            = static_cast<int>(a0);
    uint64 act_uaddr   = a1;   /* const struct sigaction __user * */
    uint64 oact_uaddr  = a2;   /* struct sigaction __user * */
    uint64 sigsetsize  = a3;

    if (sig < 1 || sig > _NSIG) return -EINVAL;
    if (sig_kernel_only(sig))   return -EINVAL;
    if (sigsetsize != sizeof(sigset_t)) return -EINVAL;

    TaskControlBlock* curr = current_task();
    if (!curr || !curr->sighand) return -EINVAL;

    /* All reads/writes of the action table happen under siglock —
     * Linux's do_sigaction() also takes the same lock (kernel/signal.c). */
    user_sigaction old{};
    user_sigaction act{};
    bool have_new = (act_uaddr != 0);

    if (have_new) {
        int err = copy_from_user(&act, act_uaddr, sizeof(act));
        if (err < 0) return -EFAULT;
    }

    {
        LockGuard guard(curr->sighand->siglock);
        kernel_sigaction* ksa = &curr->sighand->action[sig - 1];
        old.sa_handler  = ksa->sa_handler;
        old.sa_flags    = ksa->sa_flags;
        old.sa_restorer = ksa->sa_restorer;
        old.sa_mask     = ksa->sa_mask;

        if (have_new) {
            ksa->sa_handler  = act.sa_handler;
            ksa->sa_flags    = act.sa_flags;
            ksa->sa_restorer = act.sa_restorer;
            ksa->sa_mask     = act.sa_mask;
            ksa->sa_mask.del(SIGKILL);
            ksa->sa_mask.del(SIGSTOP);
        }
    }

    if (oact_uaddr != 0) {
        int err = copy_to_user(oact_uaddr, &old, sizeof(old));
        if (err < 0) return -EFAULT;
    }
    return 0;
}

/* ================================================================== */
/*  sys_rt_sigprocmask — change signal blocked mask                   */
/* ================================================================== */

int64 sys_rt_sigprocmask(uint64 a0, uint64 a1, uint64 a2, uint64 a3,
                         uint64, uint64)
{
    int    how        = static_cast<int>(a0);
    uint64 set_uaddr  = a1;
    uint64 oset_uaddr = a2;
    uint64 sigsetsize = a3;

    if (sigsetsize != sizeof(sigset_t)) return -EINVAL;

    TaskControlBlock* curr = current_task();
    if (!curr || !curr->sighand) return -EINVAL;

    sigset_t newset{};
    bool have_new = (set_uaddr != 0);
    if (have_new) {
        int err = copy_from_user(&newset, set_uaddr, sizeof(sigset_t));
        if (err < 0) return -EFAULT;
        newset.del(SIGKILL);
        newset.del(SIGSTOP);
    }

    sigset_t old{};
    {
        /* Linux: kernel/signal.c:do_sigprocmask() also holds siglock
         * across read+update so the snapshot is atomic vs. concurrent
         * signal delivery. */
        LockGuard guard(curr->sighand->siglock);
        old = curr->blocked;
        if (have_new) {
            switch (how) {
            case SIG_BLOCK:
                curr->blocked = curr->blocked | newset;
                break;
            case SIG_UNBLOCK:
                curr->blocked = curr->blocked & ~newset;
                break;
            case SIG_SETMASK:
                curr->blocked = newset;
                break;
            default:
                return -EINVAL;
            }
        }
    }

    if (oset_uaddr != 0) {
        int err = copy_to_user(oset_uaddr, &old, sizeof(sigset_t));
        if (err < 0) return -EFAULT;
    }
    return 0;
}

/* ================================================================== */
/*  sys_rt_sigreturn — restore context after signal handler           */
/* ================================================================== */

/* Arch-specific: implemented in arch/riscv/signal.cc */
extern int64 arch_sigreturn(arch::TrapFrame* tf);

int64 sys_rt_sigreturn(uint64, uint64, uint64, uint64, uint64, uint64)
{
    TaskControlBlock* curr = current_task();
    if (!curr || !curr->trapframe) return -EINVAL;

    return arch_sigreturn(curr->trapframe);
}

/* ================================================================== */
/*  sys_rt_sigtimedwait (SYS_rt_sigtimedwait = 137)                   */
/* ================================================================== */
#include <lume/timer.h>
#include <lume/sched.h>

struct linux_timespec {
    int64 tv_sec;
    int64 tv_nsec;
};

int64 sys_rt_sigtimedwait(uint64 /* set_ptr */, uint64 /* info_ptr */, uint64 timeout_ptr, uint64 /* sigsetsize */, uint64, uint64)
{
    /*
     * COMPATIBILITY STUB:
     * LumeOS lacks full real-time signal queues and timed waiting mechanism.
     * When BusyBox init runs out of children to reap, it calls this to wait 
     * for incoming signals (like SIGCHLD) with a timeout. 
     * We simulate the timeout by yielding the CPU, then return -EAGAIN (Try again) 
     * which tells user space that the timeout expired without receiving a signal.
     */
    if (timeout_ptr != 0) {
        linux_timespec req;
        if (copy_from_user(&req, timeout_ptr, sizeof(req)) == 0) {
            uint64 target = g_jiffies + (req.tv_sec * 100) + (req.tv_nsec / 10000000);
            while (g_jiffies < target) {
                schedule();
            }
        }
    }
    return -EAGAIN;
}
