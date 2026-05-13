/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * O(1) Priority Bitmap Scheduling Class
 */

#include <lume/sched.h>
#include <lume/sched_class.h>
#include <lume/task.h>
#include <lume/bitops.h>
#include <kernel/sched_internal.h>

static void o1_init_rq(RunQueue* rq)
{
    rq->o1().init();
}

static void o1_enqueue_task(RunQueue* rq, TaskControlBlock* task)
{
    rq->o1().enqueue(task);
    rq->inc_running();
}

static void o1_dequeue_task(RunQueue* rq, TaskControlBlock* task)
{
    rq->o1().dequeue(task);
    rq->dec_running();
}

static TaskControlBlock* o1_pick_next_task(RunQueue* rq)
{
    return rq->o1().pick_next();
}

static void o1_put_prev_task(RunQueue* /*rq*/, TaskControlBlock* /*task*/) {}

int32 priority_to_timeslice(uint8 priority)
{
    int32 ts = 20 - static_cast<int32>(priority) * 19 / 31;
    if (ts < 1) ts = 1;
    return ts;
}

static void o1_task_tick(RunQueue* rq, TaskControlBlock* curr)
{
    if (curr == rq->idle())
        return;

    curr->time_slice--;
    if (curr->time_slice <= 0) {
        curr->time_slice = priority_to_timeslice(curr->priority);
        rq->set_need_resched(true);
    }
}

static void o1_yield_task(RunQueue* rq, TaskControlBlock* curr)
{
    if (curr == rq->idle())
        return;

    curr->time_slice = 0;
    rq->set_need_resched(true);
}

const SchedClass g_sched_class_o1 = {
    .name = "o1",
    .next = &g_sched_class_idle,
    .init_rq = o1_init_rq,
    .enqueue_task = o1_enqueue_task,
    .dequeue_task = o1_dequeue_task,
    .pick_next_task = o1_pick_next_task,
    .put_prev_task = o1_put_prev_task,
    .task_tick = o1_task_tick,
    .yield_task = o1_yield_task,
};
