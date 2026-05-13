/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>
#include <lume/list.h>
#include <lume/sched.h>
#include <lume/config.h>
#include <lume/bitops.h>
#include <lume/task.h>
#include <kernel/sync/spinlock.h>

class O1RunQueue {
public:
    void init() {
        bitmap_ = 0;
        nr_running_ = 0;
        for (int p = 0; p < kNumPriorities; p++) {
            queues_[p].init();
        }
    }

    void enqueue(TaskControlBlock* task) {
        int prio = task->priority;

        list_node* head = &queues_[prio];
        task->run_link.prev = head->prev;
        task->run_link.next = head;
        head->prev->next = &task->run_link;
        head->prev = &task->run_link;

        bitmap_ |= (1U << prio);
        nr_running_++;

        task->state = TaskState::Runnable;
    }

    void dequeue(TaskControlBlock* task) {
        int prio = task->priority;

        task->run_link.prev->next = task->run_link.next;
        task->run_link.next->prev = task->run_link.prev;
        task->run_link.init();

        if (queues_[prio].is_empty()) {
            bitmap_ &= ~(1U << prio);
        }

        if (nr_running_ > 0) {
            nr_running_--;
        }
    }

    TaskControlBlock* pick_next() const {
        if (bitmap_ == 0) {
            return nullptr;
        }

        int prio = lume::ctz32(bitmap_);
        list_node* node = queues_[prio].next;
        return list_entry<TaskControlBlock, &TaskControlBlock::run_link>(node);
    }

    uint32 nr_running() const { return nr_running_; }

private:
    uint32 bitmap_ = 0;
    list_node queues_[kNumPriorities];
    uint32 nr_running_ = 0;
};

class RunQueue {
public:
    void init(uint32 cpu_id) {
        lock_.init("RunQueue");
        cpu_id_ = cpu_id;
        nr_running_ = 0;
        need_resched_ = false;
        current_ = nullptr;
        idle_ = nullptr;
    }

    Spinlock& lock() { return lock_; }

    uint32 cpu_id() const { return cpu_id_; }

    uint32 nr_running() const { return nr_running_; }
    void inc_running() { nr_running_++; }
    void dec_running() { if (nr_running_ > 0) nr_running_--; }

    bool need_resched() const { return need_resched_; }
    void set_need_resched(bool v) { need_resched_ = v; }
    void clear_need_resched() { need_resched_ = false; }

    TaskControlBlock* current() const { return current_; }
    void set_current(TaskControlBlock* task) { current_ = task; }

    TaskControlBlock* idle() const { return idle_; }
    void set_idle(TaskControlBlock* task) { idle_ = task; }

    O1RunQueue& o1() { return o1_; }
    const O1RunQueue& o1() const { return o1_; }

private:
    Spinlock lock_;
    uint32 cpu_id_ = 0;
    uint32 nr_running_ = 0;
    bool need_resched_ = false;

    TaskControlBlock* current_ = nullptr;
    TaskControlBlock* idle_ = nullptr;

    O1RunQueue o1_;
};
