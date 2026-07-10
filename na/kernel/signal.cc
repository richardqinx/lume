/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Signal Delivery — Queue, Dequeue, Default Actions, and do_signal
 *
 * Implements the core signal infrastructure:
 *   - send_signal(): enqueue a signal to a task's pending set
 *   - force_sig_fault(): fault-induced signal (trap handler API)
 *   - do_signal(): called on return-to-user, delivers pending signals
 *   - next_signal(): dequeue the highest-priority deliverable signal
 *
 * Signal frame construction (arch-specific) is in arch/riscv/signal.cc.
 *
 * Reference: Linux kernel/signal.c
 */

#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/signal_nr.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/wait.h>
#include <lume/console.h>
#include <lume/kprintf.h>
#include <lume/klog.h>
#include <lume/new.h>
#include <lume/errno.h>
#include <arch/trapframe.h>

/* Forward declaration: arch-specific signal frame setup */
int setup_signal_frame(arch::TrapFrame* tf, int signo,
                       kernel_sigaction* ka, kernel_siginfo* info);

/* ================================================================== */
/*  sighand_struct lifecycle (refcount-shared, Linux copy_sighand)    */
/* ================================================================== */

sighand_struct* alloc_sighand()
{
    auto* sh = new sighand_struct;
    if (sh) sh->init();
    return sh;
}

sighand_struct* copy_sighand(sighand_struct* parent)
{
    /* Linux: kernel/fork.c:copy_sighand() when !CLONE_SIGHAND copies
     * the action table verbatim so the child inherits dispositions
     * without sharing future modifications. */
    if (!parent) return alloc_sighand();
    auto* sh = new sighand_struct;
    if (!sh) return nullptr;
    sh->init();
    LockGuard guard(parent->siglock);
    for (int i = 0; i < _NSIG; i++) sh->action[i] = parent->action[i];
    return sh;
}

void get_sighand(sighand_struct* sh)
{
    if (!sh) return;
    LockGuard guard(sh->siglock);
    sh->refcount++;
}

void put_sighand(sighand_struct* sh)
{
    if (!sh) return;
    uint32 remaining;
    {
        LockGuard guard(sh->siglock);
        remaining = --sh->refcount;
    }
    if (remaining == 0) delete sh;
}

/* ================================================================== */
/*  next_signal — find lowest-numbered deliverable signal             */
/* ================================================================== */

/* Manual count-trailing-zeros (no libgcc __ctzdi2 dependency) */
static inline int sig_ctz64(uint64 x)
{
    if (x == 0) return 64;
    int n = 0;
    if ((x & 0xFFFFFFFF) == 0) { n += 32; x >>= 32; }
    if ((x & 0x0000FFFF) == 0) { n += 16; x >>= 16; }
    if ((x & 0x000000FF) == 0) { n +=  8; x >>=  8; }
    if ((x & 0x0000000F) == 0) { n +=  4; x >>=  4; }
    if ((x & 0x00000003) == 0) { n +=  2; x >>=  2; }
    if ((x & 0x00000001) == 0) { n +=  1; }
    return n;
}

static int next_signal(sigpending* pending, const sigset_t* mask)
{
    /* Standard signals: check bitmap & ~blocked */
    for (int i = 0; i < _NSIG_WORDS; i++) {
        uint64 bits = pending->signal.sig[i] & ~mask->sig[i];
        if (bits != 0) {
            int sig = i * 64 + sig_ctz64(bits) + 1;
            return sig;
        }
    }
    return 0;
}

/* ================================================================== */
/*  dequeue_signal — remove a signal from the pending set             */
/* ================================================================== */

/*
 * Dequeue the next deliverable signal.  MUST be called with
 * task->sighand->siglock held.  Mirrors Linux's __dequeue_signal()
 * (kernel/signal.c) which requires the same lock.
 */
static int dequeue_signal_locked(TaskControlBlock* task, kernel_siginfo* info)
{
    int sig = next_signal(&task->pending, &task->blocked);
    if (sig == 0) return 0;

    /* Clear the bitmap bit */
    task->pending.signal.del(sig);

    /* Search the queue for a matching sigqueue entry */
    list_node* node = task->pending.list.next;
    while (node != &task->pending.list) {
        auto* q = list_entry<sigqueue, &sigqueue::list>(node);
        if (q->info.si_signo == sig) {
            /* Remove from queue */
            node->prev->next = node->next;
            node->next->prev = node->prev;
            if (info) *info = q->info;
            delete q;
            return sig;
        }
        node = node->next;
    }

    /* No queued entry — fill in minimal info */
    if (info) {
        info->si_signo = sig;
        info->si_errno = 0;
        info->si_code  = 0;  /* SI_USER */
    }
    return sig;
}

/* ================================================================== */
/*  send_signal — enqueue a signal to a task                          */
/* ================================================================== */

/*
 * Drop a queued sigqueue entry with the given signo from `task`.
 *
 * MUST be called with task->sighand->siglock held — Linux's
 * flush_sigqueue_mask() has the same precondition (kernel/signal.c).
 */
static bool discard_pending_locked(TaskControlBlock* task, int signo)
{
    bool any = false;
    list_node* node = task->pending.list.next;
    while (node != &task->pending.list) {
        list_node* nxt = node->next;
        auto* q = list_entry<sigqueue, &sigqueue::list>(node);
        if (q->info.si_signo == signo) {
            node->prev->next = node->next;
            node->next->prev = node->prev;
            delete q;
            any = true;
        }
        node = nxt;
    }
    task->pending.signal.del(signo);
    return any;
}

static inline bool is_stop_sig(int sig)
{
    return sig == SIGSTOP || sig == SIGTSTP ||
           sig == SIGTTIN || sig == SIGTTOU;
}

/*
 * send_signal — queue a signal to a task.
 *
 * Acquires task->sighand->siglock for the full update (bitmap, queue,
 * stop/cont side-effects, scheduler wake).  Mirrors Linux's
 * __send_signal_locked() which also requires this lock (see
 * kernel/signal.c:1048 lockdep_assert_held).
 *
 * Returns 0 on success or a negative errno.
 */
int send_signal(int sig, kernel_siginfo* info, TaskControlBlock* task)
{
    if (sig < 1 || sig > _NSIG) return -EINVAL;
    if (!task) return -ESRCH;
    if (!task->sighand) return -ESRCH;  /* eager-alloc invariant; tasks
                                          * without sighand can't receive
                                          * signals (idle / early kthreads) */

    LockGuard guard(task->sighand->siglock);

    /*
     * Linux's prepare_signal(): a stop signal cancels any pending
     * SIGCONT and vice versa, so the most recent decision wins.
     */
    if (is_stop_sig(sig)) {
        discard_pending_locked(task, SIGCONT);
    } else if (sig == SIGCONT) {
        discard_pending_locked(task, SIGSTOP);
        discard_pending_locked(task, SIGTSTP);
        discard_pending_locked(task, SIGTTIN);
        discard_pending_locked(task, SIGTTOU);

        /* SIGCONT's resume effect happens atomically with delivery. */
        if (task->state == TaskState::Stopped) {
            task->state = TaskState::Runnable;
            task->notify_continued = true;
            task->stopped_code = 0;
            sched_enqueue(task);
            if (task->parent) task->parent->wait_chld.wake_all();
        }
    }

    /* Already pending? For standard signals, just mark the bitmap */
    if (sig < SIGRTMIN && task->pending.signal.has(sig))
        return 0;

    /* Enqueue a sigqueue entry */
    auto* q = new sigqueue;
    if (!q) {
        /* Can't allocate — just set the bitmap (signal still delivered) */
        task->pending.signal.add(sig);
        return 0;
    }

    q->list.init();
    if (info) {
        q->info = *info;
    } else {
        q->info.si_signo = sig;
        q->info.si_errno = 0;
        q->info.si_code  = 0;  /* SI_USER */
    }
    q->info.si_signo = sig;  /* ensure consistent */

    /* Add to tail of queue */
    list_node* head = &task->pending.list;
    q->list.prev = head->prev;
    q->list.next = head;
    head->prev->next = &q->list;
    head->prev = &q->list;

    /* Set bitmap */
    task->pending.signal.add(sig);

    /* Wake the task if it's sleeping in an interruptible wait. */
    if (task->state == TaskState::Sleeping) {
        task->state = TaskState::Runnable;
        sched_enqueue(task);
    }

    /* SIGKILL must run even if the target is Stopped. */
    if (sig == SIGKILL && task->state == TaskState::Stopped) {
        task->state = TaskState::Runnable;
        task->stopped_code = 0;
        sched_enqueue(task);
    }

    return 0;
}

/* ================================================================== */
/*  force_sig_fault — trap handler API                                */
/* ================================================================== */

void force_sig_fault(int signo, int code, uint64 addr)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return;

    /* Kernel threads cannot handle signals — kill immediately */
    if (curr->flags & TF_KTHREAD) {
        pr_err("signal: kernel thread %s received signal %d\n",
               curr->name ? curr->name : "(noname)", signo);
        task_kill_current(signo);
        return;
    }

    /* Sighand must already exist for user-mode tasks (allocated at
     * fork / kernel_execve time).  If it's somehow missing, the only
     * safe action is to terminate. */
    if (!curr->sighand) {
        pr_err("signal: pid %d has no sighand, killing\n", curr->pid);
        task_kill_current(signo);
        return;
    }

    kernel_siginfo info{};
    info.si_signo = signo;
    info.si_code  = code;
    info._sifields._sigfault._addr = addr;

    /* Force: bypass blocked mask for fatal signals (lock to keep
     * blocked-mask updates consistent with sigprocmask). */
    {
        LockGuard guard(curr->sighand->siglock);
        curr->blocked.del(signo);
    }

    send_signal(signo, &info, curr);
}

/* ================================================================== */
/*  signal_pending — check if unblocked signals are pending            */
/* ================================================================== */

bool signal_pending(TaskControlBlock* task)
{
    /* Advisory check (matches Linux's recalc_sigpending() usage):
     * callers re-validate under siglock before acting.  The bitmap is
     * a uint64 word; a torn read can only produce false-positives or
     * false-negatives transiently, never a corrupt pointer. */
    if (!task) return false;
    sigset_t unblocked = task->pending.signal & ~task->blocked;
    return !unblocked.is_empty();
}

/* ================================================================== */
/*  do_signal — called before returning to user mode                  */
/* ================================================================== */

void do_signal(arch::TrapFrame* tf)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return;

    /* Kernel threads never deliver signals via frames */
    if (curr->flags & TF_KTHREAD) return;

    /* No sighand means no signal infrastructure for this task */
    if (!curr->sighand) return;

    while (true) {
        kernel_siginfo info{};
        kernel_sigaction ka_copy;
        int sig;

        /*
         * Take siglock for dequeue + action snapshot.  Action processing
         * (default actions like SIG_ACT_TERM, or constructing a signal
         * frame for a user handler) is done OUTSIDE the lock — it can
         * touch user memory and even call schedule().  This matches
         * Linux's get_signal() loop in kernel/signal.c: it takes
         * siglock around dequeue_signal+ka_copy, drops it before
         * dispatching, and re-acquires next iteration.
         */
        {
            LockGuard guard(curr->sighand->siglock);
            sig = dequeue_signal_locked(curr, &info);
            if (sig == 0) break;
            ka_copy = curr->sighand->action[sig - 1];
        }
        kernel_sigaction* ka = &ka_copy;

        /* SIG_IGN: discard */
        if (ka->sa_handler == SIG_IGN && !sig_kernel_only(sig))
            continue;

        /* SIG_DFL: apply default action */
        if (ka->sa_handler == SIG_DFL) {
            SigDefaultAction act = sig_default_action(sig);
            switch (act) {
            case SIG_ACT_IGN:
                continue;
            case SIG_ACT_TERM:
            case SIG_ACT_CORE:
                pr_debug_s(KLOG_SUBSYS_SIGNAL,
                           "signal: pid %d killed by signal %d\n",
                           curr->pid, sig);
                task_kill_current(sig);
                return;  /* never reached */
            case SIG_ACT_STOP: {
                /*
                 * Enter Stopped state.  Record the encoded wstatus so
                 * the parent's wait4(WUNTRACED) can observe and report.
                 * The schedule() below does NOT re-enqueue Stopped
                 * tasks — when SIGCONT eventually arrives, send_signal
                 * flips us back to Runnable and re-enqueues.
                 */
                curr->stopped_code = W_STOPCODE(sig);
                curr->state = TaskState::Stopped;
                if (curr->parent)
                    curr->parent->wait_chld.wake_all();
                pr_debug_s(KLOG_SUBSYS_SIGNAL,
                           "signal: pid %d stopped by sig %d\n",
                           curr->pid, sig);
                schedule();
                /*
                 * Resumed (either by SIGCONT or SIGKILL).  Loop back to
                 * deliver any remaining pending signals before returning
                 * to user mode.
                 */
                continue;
            }
            case SIG_ACT_CONT:
                /* SIGCONT's resume side-effect already happened in
                 * send_signal().  The only thing left at handler time
                 * is to consume the signal (no-op for SIG_DFL). */
                continue;
            }
        }

        /* User handler: construct signal frame */
        pr_debug_s(KLOG_SUBSYS_SIGNAL,
                   "signal: pid %d delivering sig %d handler=%llx\n",
                   curr->pid, sig, reinterpret_cast<uint64>(ka->sa_handler));
        int ret = setup_signal_frame(tf, sig, ka, &info);
        if (ret < 0) {
            pr_err("signal: failed to set up frame for sig %d\n", sig);
            task_kill_current(sig);
            return;
        }

        /* Post-delivery bookkeeping under siglock — both the per-task
         * blocked mask and the shared action table (SA_RESETHAND) are
         * touched, so we must hold the same lock the senders use. */
        {
            LockGuard guard(curr->sighand->siglock);
            if (!(ka->sa_flags & SA_NODEFER)) curr->blocked.add(sig);
            curr->blocked = curr->blocked | ka->sa_mask;
            if (ka->sa_flags & SA_RESETHAND) {
                curr->sighand->action[sig - 1].sa_handler = SIG_DFL;
            }
        }

        /* Only deliver one signal per return-to-user */
        break;
    }
}
