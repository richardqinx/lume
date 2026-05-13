/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * WaitQueue — blocking synchronization primitive
 *
 * A thread calls wq.sleep() to block itself until another thread
 * (or interrupt handler) calls wq.wake_one() or wq.wake_all().
 *
 * Implementation: intrusive doubly-linked list of sleeping tasks,
 * protected by an internal spinlock.
 *
 * Reference: docs/specs/scheduler.md, docs/specs/task.md §5
 */

#include <lume/types.h>
#include <lume/list.h>
#include <kernel/sync/spinlock.h>

struct TaskControlBlock;

class WaitQueue {
public:
    void init(const char* name = "wq") {
        head_.init();
        lock_.init(name);
    }

    /* Block the current task on this queue.
     * If external_lock is provided, it is released AFTER the task is
     * added to the wait queue but BEFORE schedule() is called,
     * to avoid lost wakeups.
     * Returns after wake_one/wake_all unblocks this task. */
    void sleep(Spinlock* external_lock = nullptr);

    /* Wake the first (oldest) sleeping task. Returns true if a task was woken. */
    bool wake_one();

    /* Wake all sleeping tasks. Returns the number of tasks woken. */
    int wake_all();

    /* Check if any tasks are waiting. */
    bool is_empty() const { return head_.is_empty(); }

private:
    list_node head_;
    Spinlock lock_;
};
