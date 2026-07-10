/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * WaitQueue — blocking synchronization primitive
 *
 * Supports two usage patterns:
 *
 * 1. Simple (legacy): wq.sleep() — combines prepare/schedule/finish.
 *    Suitable for simple cases where no external condition is checked.
 *
 * 2. Linux-style two-phase (recommended for correctness):
 *
 *      wq.prepare_to_wait(curr, TaskState::Sleeping);
 *      if (!condition) {
 *          schedule();
 *      }
 *      wq.finish_wait(curr);
 *
 *    This pattern prevents the "lost wakeup" race: the task is already
 *    on the wait list (and marked Sleeping) BEFORE checking the condition.
 *    If a wake_one/wake_all fires between the check and schedule(), the
 *    task's state will already be set back to Runnable, and schedule()
 *    will see state == Runnable and simply re-run the task.
 *
 * Reference: docs/specs/scheduler.md, docs/specs/task.md §5
 */

#include <lume/types.h>
#include <lume/list.h>
#include <kernel/sync/spinlock.h>

struct TaskControlBlock;
enum class TaskState : uint8;

class WaitQueue {
public:
    void init(const char* name = "wq") {
        head_.init();
        lock_.init(name);
    }

    /*
     * Phase 1: Add the task to the wait queue and set its state.
     * The task is NOT yet descheduled — the caller must check the
     * condition and call schedule() if the condition is still false.
     *
     * Must be called with interrupts disabled or preemption disabled.
     */
    void prepare_to_wait(TaskControlBlock* task, TaskState new_state);

    /*
     * Phase 3: Remove the task from the wait queue (if still on it)
     * and ensure its state is Runnable. Called after schedule() returns
     * (i.e. after the task has been woken up, or if the condition was
     * true and schedule() was skipped).
     */
    void finish_wait(TaskControlBlock* task);

    /* Legacy convenience: combines prepare_to_wait + schedule + finish_wait.
     * If external_lock is provided, it is released AFTER the task is
     * added to the wait queue but BEFORE schedule() is called. */
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
