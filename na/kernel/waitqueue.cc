/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * WaitQueue — blocking synchronization implementation
 *
 * sleep():    current task → Sleeping, link into queue, schedule()
 * wake_one(): dequeue head task → Runnable, sched_enqueue()
 *
 * The internal spinlock protects the wait list only.
 * schedule() is called AFTER releasing the spinlock to avoid
 * holding a lock across a context switch.
 */

#include <lume/waitqueue.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/kprintf.h>
#include <arch/cpu.h>

void WaitQueue::sleep(Spinlock* external_lock)
{
    TaskControlBlock* curr = current_task();
    if (!curr) {
        if (external_lock) external_lock->release();
        return;
    }

    {
        LockGuard guard(lock_);

        /* Mark task as sleeping */
        curr->state = TaskState::Sleeping;

        /* Remove from RunQueue (sched_dequeue acquires its own lock) */
        /* We do NOT call sched_dequeue here because schedule() handles
         * the put_prev_task logic when state != Running. */

        /* Link into wait queue tail */
        list_node* node = &curr->run_link;
        node->prev = head_.prev;
        node->next = &head_;
        head_.prev->next = node;
        head_.prev = node;
    }

    if (external_lock) {
        external_lock->release();
    }

    /* Context switch away — will return here when woken */
    schedule();
}

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
