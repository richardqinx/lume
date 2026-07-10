/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Mutex — Linux-style sleeping mutex (no PI).
 *
 * Implementation notes (mirroring kernel/locking/mutex.c, simplified):
 *
 *  - Fast path (uncontended): wait_lock_ -> see owner_==null -> claim -> unlock.
 *  - Slow path (contended): enqueue MutexWaiter on stack, sleep, race for
 *    ownership after each wake. unlock() wakes only the head waiter.
 *  - No optimistic spin, no handoff anti-starvation, no interruptible wait.
 *    These belong to follow-up work (see mutex.md §5).
 *
 * Reference: docs/specs/mutex.md
 */

#include <lume/mutex.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/klog.h>
#include <arch/cpu.h>

namespace {

struct MutexWaiter {
    list_node          link;
    TaskControlBlock*  task;
};

} // namespace

/* ------------------------------------------------------------------ */
/*  init                                                              */
/* ------------------------------------------------------------------ */

void Mutex::init(const char* name)
{
    owner_ = nullptr;
    name_  = name;
    wait_lock_.init(name != nullptr ? name : "mutex");
    wait_list_.init();
}

/* ------------------------------------------------------------------ */
/*  try_lock — non-blocking, safe from any context                    */
/* ------------------------------------------------------------------ */

bool Mutex::try_lock()
{
    LockGuard g(wait_lock_);
    if (owner_ != nullptr) {
        return false;
    }
    owner_ = current_task();
    return true;
}

/* ------------------------------------------------------------------ */
/*  lock — blocking, must be called in schedulable context            */
/* ------------------------------------------------------------------ */

void Mutex::lock()
{
    TaskControlBlock* curr = current_task();

    if (curr == nullptr) {
        kernel_panic("Mutex::lock: no current task");
    }
    if (curr->preempt_count > 0) {
        kernel_panic("Mutex::lock: preemption disabled (holding spinlock?)");
    }

    wait_lock_.acquire();

    if (owner_ == nullptr) {
        owner_ = curr;
        wait_lock_.release();
        return;
    }

    if (owner_ == curr) {
        wait_lock_.release();
        kernel_panic("Mutex::lock: recursive acquire by same task");
    }

    /* Slow path: enqueue ourselves and sleep until we are head + lock free. */
    MutexWaiter waiter;
    waiter.link.init();
    waiter.task = curr;
    list_add_tail(&waiter.link, &wait_list_);

    for (;;) {
        /* Set state inside wait_lock_ so unlock-side sees a coherent view:
         * either we are on the list AND Sleeping (will be woken), or we
         * already took ownership above (not in this loop). */
        curr->state = TaskState::Sleeping;
        wait_lock_.release();

        schedule();

        wait_lock_.acquire();

        if (owner_ == nullptr && wait_list_.next == &waiter.link) {
            owner_ = curr;
            list_del_init(&waiter.link);
            wait_lock_.release();
            return;
        }
        /* Spurious wake / lost race — keep waiting. */
    }
}

/* ------------------------------------------------------------------ */
/*  unlock                                                            */
/* ------------------------------------------------------------------ */

void Mutex::unlock()
{
    TaskControlBlock* curr = current_task();

    wait_lock_.acquire();

    if (owner_ != curr) {
        wait_lock_.release();
        kernel_panic("Mutex::unlock: not the owner");
    }

    owner_ = nullptr;

    if (!wait_list_.is_empty()) {
        list_node*   first  = wait_list_.next;
        MutexWaiter* w      = list_entry<MutexWaiter, &MutexWaiter::link>(first);
        TaskControlBlock* victim = w->task;

        /* Race-tolerant wake: only enqueue if still sleeping. If the
         * waiter is already Runnable (e.g. it was already woken by a
         * timer-driven schedule reentry and didn't yet retry the lock),
         * sched_enqueue would double-link it. */
        if (victim->state == TaskState::Sleeping) {
            victim->state = TaskState::Runnable;
            sched_enqueue(victim);
        }
    }

    wait_lock_.release();
}

/* ------------------------------------------------------------------ */
/*  Debug accessors                                                   */
/* ------------------------------------------------------------------ */

bool Mutex::is_owned_by_current() const
{
    return owner_ == current_task();
}
