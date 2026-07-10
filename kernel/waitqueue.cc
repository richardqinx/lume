/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * WaitQueue — blocking synchronization implementation
 *
 * Two-phase wait protocol:
 *
 *   prepare_to_wait():  task → Sleeping, link into queue
 *   [caller checks condition — if still false, calls schedule()]
 *   finish_wait():      remove from queue, restore Runnable
 *
 * Legacy sleep() wraps the two-phase pattern for simple callers.
 *
 * wake_one()/wake_all(): dequeue waiters → Runnable, sched_enqueue()
 *
 * The internal spinlock protects the wait list only.
 * schedule() is called AFTER releasing all spinlocks to avoid
 * holding a lock across a context switch.
 */

#include <lume/waitqueue.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/kprintf.h>
#include <arch/cpu.h>

/* ------------------------------------------------------------------ */
/*  Two-phase wait API                                                 */
/* ------------------------------------------------------------------ */

void WaitQueue::prepare_to_wait(TaskControlBlock* task, TaskState new_state)
{
    LockGuard guard(lock_);

    /* Set state BEFORE linking — this is the key to preventing lost wakeups.
     * If wake_one fires between now and schedule(), it will set state back
     * to Runnable, and schedule() will see Runnable and not block. */
    task->state = new_state;

    /* Only add to queue if not already linked (idempotent) */
    if (task->run_link.next == &task->run_link) {
        /* Link into wait queue tail */
        list_node* node = &task->run_link;
        node->prev = head_.prev;
        node->next = &head_;
        head_.prev->next = node;
        head_.prev = node;
    }
}

void WaitQueue::finish_wait(TaskControlBlock* task)
{
    LockGuard guard(lock_);

    /* Remove from wait queue if still linked */
    if (task->run_link.next != &task->run_link) {
        list_node* node = &task->run_link;
        node->prev->next = node->next;
        node->next->prev = node->prev;
        node->init();
    }

    /* Ensure task is Runnable (it may have been woken by wake_one/wake_all
     * already, or it may never have slept if the condition was true). */
    if (task->state == TaskState::Sleeping) {
        task->state = TaskState::Runnable;
    }
}

/* ------------------------------------------------------------------ */
/*  Legacy convenience API                                             */
/* ------------------------------------------------------------------ */

void WaitQueue::sleep(Spinlock* external_lock)
{
    TaskControlBlock* curr = current_task();
    if (!curr) {
        if (external_lock) external_lock->release();
        return;
    }

    /* Phase 1: add to queue, mark Sleeping */
    prepare_to_wait(curr, TaskState::Sleeping);

    /* Release external lock AFTER we are on the queue (critical ordering) */
    if (external_lock) {
        external_lock->release();
    }

    /* Phase 2: context switch away — will return here when woken */
    schedule();

    /* Phase 3: clean up */
    finish_wait(curr);
}

/* ------------------------------------------------------------------ */
/*  Wakeup                                                             */
/* ------------------------------------------------------------------ */

bool WaitQueue::wake_one()
{
    LockGuard guard(lock_);

    if (head_.is_empty())
        return false;

    /* Dequeue the first (oldest) waiter */
    list_node* node = head_.next;
    node->prev->next = node->next;
    node->next->prev = node->prev;
    node->init();

    TaskControlBlock* task =
        list_entry<TaskControlBlock, &TaskControlBlock::run_link>(node);

    task->state = TaskState::Runnable;
    sched_enqueue(task);

    return true;
}

int WaitQueue::wake_all()
{
    LockGuard guard(lock_);

    int count = 0;
    while (!head_.is_empty()) {
        list_node* node = head_.next;
        node->prev->next = node->next;
        node->next->prev = node->prev;
        node->init();

        TaskControlBlock* task =
            list_entry<TaskControlBlock, &TaskControlBlock::run_link>(node);

        task->state = TaskState::Runnable;
        sched_enqueue(task);
        count++;
    }

    return count;
}
