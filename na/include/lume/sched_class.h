/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Scheduler Class Interface (Linux-style)
 *
 * Each scheduling algorithm implements a sched_class and is chained
 * in priority order. The scheduler core walks the chain to select
 * the next runnable task.
 */

#include <lume/types.h>

struct RunQueue;
struct TaskControlBlock;

struct SchedClass {
    const char* name;
    const SchedClass* next;  // Linked list order: higher priority first

    void (*init_rq)(RunQueue* rq);

    void (*enqueue_task)(RunQueue* rq, TaskControlBlock* task);
    void (*dequeue_task)(RunQueue* rq, TaskControlBlock* task);
    TaskControlBlock* (*pick_next_task)(RunQueue* rq);
    void (*put_prev_task)(RunQueue* rq, TaskControlBlock* task);

    void (*task_tick)(RunQueue* rq, TaskControlBlock* curr);
    void (*yield_task)(RunQueue* rq, TaskControlBlock* curr);
};

extern const SchedClass g_sched_class_o1;
extern const SchedClass g_sched_class_idle;
