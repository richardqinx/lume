/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/selftest.h>
#include <lume/waitqueue.h>
#include <lume/task.h>
#include <lume/sched.h>

static WaitQueue g_test_wq;
static volatile bool g_thread_woken = false;
static volatile bool g_thread_started = false;
static volatile int g_wake_count = 0;

extern TaskControlBlock* kthread_create(const char* name, void (*entry)(void*), void* arg, uint8 priority);

static void waitqueue_test_thread(void*)
{
    g_thread_started = true;
    g_test_wq.sleep();
    g_thread_woken = true;

    extern void task_exit(int code);
    task_exit(0);
}

static void waitqueue_test_thread_all(void*)
{
    g_test_wq.sleep();
    __sync_fetch_and_add(&g_wake_count, 1);

    extern void task_exit(int code);
    task_exit(0);
}

void selftest_waitqueue()
{
    st_begin("waitqueue: sleep and wake_one");
    
    g_test_wq.init("test_wq");
    g_thread_started = false;
    g_thread_woken = false;
    
    TaskControlBlock* child = kthread_create("test_wq_child", waitqueue_test_thread, nullptr, 0);
    ST_ASSERT(child != nullptr);
    
    sched_yield();
    
    ST_ASSERT(g_thread_started == true);
    ST_ASSERT(g_thread_woken == false);
    ST_ASSERT(!g_test_wq.is_empty());
    
    kprintf("[test_wq] waking child\n");
    bool woken = g_test_wq.wake_one();
    ST_ASSERT(woken == true);
    ST_ASSERT(g_test_wq.is_empty());
    
    kprintf("[test_wq] yielding to child again\n");
    sched_yield();
    kprintf("[test_wq] returned from yield 2\n");
    
    ST_ASSERT(g_thread_woken == true);
    
    st_pass();

    st_begin("waitqueue: wake_all");
    g_wake_count = 0;
    for (int i = 0; i < 3; i++) {
        kthread_create("test_wq_all", waitqueue_test_thread_all, nullptr, 0);
    }
    
    /* Give all 3 threads a chance to start and sleep */
    kprintf("[test_wq] yielding 1 for wake_all\n");
    sched_yield();
    sched_yield();
    sched_yield();

    ST_ASSERT(!g_test_wq.is_empty());

    int woken_count = g_test_wq.wake_all();

    ST_ASSERT_EQ(woken_count, 3);
    ST_ASSERT(g_test_wq.is_empty());
    
    /* Give all 3 threads a chance to wake up and run */
    sched_yield();
    sched_yield();
    sched_yield();
    
    ST_ASSERT_EQ(g_wake_count, 3);
    st_pass();
}
