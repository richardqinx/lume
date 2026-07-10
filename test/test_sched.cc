/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot self-tests for the Scheduler subsystem.
 *
 * Tests RunQueue bitmap operations, priority selection,
 * round-robin ordering, current_task(), and time slice policy.
 */

#include <lume/types.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/sched_class.h>
#include <lume/config.h>
#include <lume/selftest.h>
#include <lume/pmm.h>
#include <lume/addr.h>
#include <lume/new.h>
#include <kernel/sched_internal.h>

/* ========================================================================
 * Helper: create a minimal test TCB (no real kernel stack, just metadata)
 * ======================================================================== */

static TaskControlBlock g_test_tcbs[8];

static TaskControlBlock* make_test_tcb(int index, const char* name,
                                        uint8 priority, uint8 cpu)
{
    TaskControlBlock* t = &g_test_tcbs[index];
    t->context = {};
    t->wait_chld.init("test_wq");
    t->name = name;
    t->priority = priority;
    t->cpu_id = cpu;
    t->pid = 100 + index;
    t->tgid = 100 + index;
    t->state = TaskState::Runnable;
    t->time_slice = priority_to_timeslice(priority);
    t->run_link.init();
    t->all_link.init();
    t->children.init();
    t->sibling.init();
    t->mm = nullptr;
    t->trapframe = nullptr;
    t->kstack_pa = 0;
    t->kstack_va = 0;
    t->flags = TF_KTHREAD;
    t->sched_class = &g_sched_class_o1;
    t->sched_entity = &t->run_link;
    return t;
}

/* ========================================================================
 * Test cases
 * ======================================================================== */

static bool test_current_task()
{
    /* After sched_init, current_task() should be the BSP boot TCB */
    TaskControlBlock* curr = current_task();
    return curr != nullptr && curr->state == TaskState::Running;
}

static bool test_priority_to_timeslice()
{
    /* Higher priority (lower number) should get longer time slice */
    int32 ts_high = priority_to_timeslice(0);
    int32 ts_mid  = priority_to_timeslice(15);
    int32 ts_low  = priority_to_timeslice(31);

    return ts_high > ts_mid && ts_mid > ts_low && ts_low >= 1;
}

static bool test_o1_pick_next_priority()
{
    RunQueue rq;
    rq.init(0);
    g_sched_class_o1.init_rq(&rq);

    TaskControlBlock* t_lo = make_test_tcb(0, "test_p5", 5, 0);
    TaskControlBlock* t_hi = make_test_tcb(1, "test_p2", 2, 0);

    g_sched_class_o1.enqueue_task(&rq, t_lo);
    g_sched_class_o1.enqueue_task(&rq, t_hi);

    TaskControlBlock* next = g_sched_class_o1.pick_next_task(&rq);
    return next == t_hi;
}

static bool test_o1_fifo_order()
{
    RunQueue rq;
    rq.init(0);
    g_sched_class_o1.init_rq(&rq);

    TaskControlBlock* t0 = make_test_tcb(0, "test_q0", 10, 0);
    TaskControlBlock* t1 = make_test_tcb(1, "test_q1", 10, 0);
    TaskControlBlock* t2 = make_test_tcb(2, "test_q2", 10, 0);

    g_sched_class_o1.enqueue_task(&rq, t0);
    g_sched_class_o1.enqueue_task(&rq, t1);
    g_sched_class_o1.enqueue_task(&rq, t2);

    TaskControlBlock* next = g_sched_class_o1.pick_next_task(&rq);
    if (next != t0) return false;
    g_sched_class_o1.dequeue_task(&rq, t0);

    next = g_sched_class_o1.pick_next_task(&rq);
    if (next != t1) return false;
    g_sched_class_o1.dequeue_task(&rq, t1);

    next = g_sched_class_o1.pick_next_task(&rq);
    if (next != t2) return false;

    return true;
}

static bool test_o1_nr_running()
{
    RunQueue rq;
    rq.init(0);
    g_sched_class_o1.init_rq(&rq);

    TaskControlBlock* t0 = make_test_tcb(0, "test_n0", 8, 0);
    TaskControlBlock* t1 = make_test_tcb(1, "test_n1", 9, 0);

    if (rq.nr_running() != 0 || rq.o1().nr_running() != 0) return false;

    g_sched_class_o1.enqueue_task(&rq, t0);
    if (rq.nr_running() != 1 || rq.o1().nr_running() != 1) return false;

    g_sched_class_o1.enqueue_task(&rq, t1);
    if (rq.nr_running() != 2 || rq.o1().nr_running() != 2) return false;

    g_sched_class_o1.dequeue_task(&rq, t0);
    if (rq.nr_running() != 1 || rq.o1().nr_running() != 1) return false;

    g_sched_class_o1.dequeue_task(&rq, t1);
    return rq.nr_running() == 0 && rq.o1().nr_running() == 0;
}

static bool test_o1_pick_next_empty()
{
    RunQueue rq;
    rq.init(0);
    g_sched_class_o1.init_rq(&rq);

    return g_sched_class_o1.pick_next_task(&rq) == nullptr;
}

static bool test_priority_to_timeslice_bounds()
{
    /* Boundary values */
    int32 ts0  = priority_to_timeslice(0);
    int32 ts31 = priority_to_timeslice(31);

    return ts0 == 20 && ts31 >= 1;
}

static bool test_enqueue_dequeue()
{
    /* Create a test task and enqueue/dequeue it */
    TaskControlBlock* t = make_test_tcb(0, "test_ed", 10, 0);

    sched_enqueue(t);
    if (t->state != TaskState::Runnable) return false;

    sched_dequeue(t);
    /* After dequeue, run_link should be self-pointing */
    return t->run_link.next == &t->run_link;
}

static bool test_multiple_enqueue_dequeue()
{
    /* Enqueue 3 tasks at different priorities, dequeue all */
    TaskControlBlock* t0 = make_test_tcb(0, "test_m0", 5, 0);
    TaskControlBlock* t1 = make_test_tcb(1, "test_m1", 10, 0);
    TaskControlBlock* t2 = make_test_tcb(2, "test_m2", 20, 0);

    sched_enqueue(t0);
    sched_enqueue(t1);
    sched_enqueue(t2);

    sched_dequeue(t0);
    sched_dequeue(t1);
    sched_dequeue(t2);

    return t0->run_link.is_empty() &&
           t1->run_link.is_empty() &&
           t2->run_link.is_empty();
}

static bool test_current_task_name()
{
    TaskControlBlock* curr = current_task();
    if (!curr || !curr->name) return false;

    /* BSP boot TCB should be named "kernel_main" */
    const char* expected = "kernel_main";
    const char* actual = curr->name;
    while (*expected && *actual) {
        if (*expected != *actual) return false;
        expected++;
        actual++;
    }
    return *expected == *actual;
}

/* ========================================================================
 * Test runner
 * ======================================================================== */

void selftest_sched()
{
    st_begin("sched: current_task is valid after init");
    ST_ASSERT(test_current_task());
    st_pass();

    st_begin("sched: current_task name is kernel_main");
    ST_ASSERT(test_current_task_name());
    st_pass();

    st_begin("sched: priority_to_timeslice ordering");
    ST_ASSERT(test_priority_to_timeslice());
    st_pass();

    st_begin("sched: priority_to_timeslice bounds");
    ST_ASSERT(test_priority_to_timeslice_bounds());
    st_pass();

    st_begin("sched: enqueue/dequeue round-trip");
    ST_ASSERT(test_enqueue_dequeue());
    st_pass();

    st_begin("sched: multiple enqueue/dequeue");
    ST_ASSERT(test_multiple_enqueue_dequeue());
    st_pass();

    st_begin("sched: o1 pick_next priority");
    ST_ASSERT(test_o1_pick_next_priority());
    st_pass();

    st_begin("sched: o1 FIFO order");
    ST_ASSERT(test_o1_fifo_order());
    st_pass();

    st_begin("sched: o1 nr_running accounting");
    ST_ASSERT(test_o1_nr_running());
    st_pass();

    st_begin("sched: o1 pick_next empty");
    ST_ASSERT(test_o1_pick_next_empty());
    st_pass();
}

