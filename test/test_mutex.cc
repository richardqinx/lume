/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_mutex — self-tests for the Mutex sleeping lock.
 *
 * Coverage:
 *   - basic lock/unlock single-thread
 *   - try_lock when free and when held
 *   - mutual exclusion across kthreads (no lost increments)
 *   - FIFO wake order (A acquires, B/C queue; release lets B in then C)
 */

#include <lume/selftest.h>
#include <lume/mutex.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/kprintf.h>

extern TaskControlBlock* kthread_create(const char* name,
                                        void (*entry)(void*), void* arg,
                                        uint8 priority);
extern void task_exit(int code);

/* ------------------------------------------------------------------ */
/*  Test 1: basic lock/unlock                                         */
/* ------------------------------------------------------------------ */

static void test_basic()
{
    st_begin("mutex: basic lock/unlock");

    Mutex m;
    m.init("test_basic");

    ST_ASSERT(!m.is_locked());
    m.lock();
    ST_ASSERT(m.is_locked());
    ST_ASSERT(m.is_owned_by_current());
    m.unlock();
    ST_ASSERT(!m.is_locked());

    st_pass();
}

/* ------------------------------------------------------------------ */
/*  Test 2: try_lock                                                  */
/* ------------------------------------------------------------------ */

static void test_trylock()
{
    st_begin("mutex: try_lock");

    Mutex m;
    m.init("test_trylock");

    ST_ASSERT(m.try_lock() == true);
    ST_ASSERT(m.is_locked());

    /* A second try_lock from the same task: since owner == current,
     * we still return false (try_lock is non-recursive). */
    ST_ASSERT(m.try_lock() == false);

    m.unlock();
    ST_ASSERT(!m.is_locked());
    ST_ASSERT(m.try_lock() == true);
    m.unlock();

    st_pass();
}

/* ------------------------------------------------------------------ */
/*  Test 3: mutual exclusion across kthreads                          */
/* ------------------------------------------------------------------ */

static Mutex             g_mut;
static volatile int32    g_counter = 0;
static volatile int32    g_done    = 0;
static constexpr int32   kIters    = 200;

static void mutex_worker(void*)
{
    for (int i = 0; i < kIters; i++) {
        g_mut.lock();
        int32 v = g_counter;
        /* Yield inside the critical section to expose missing mutex.
         * If the mutex were broken we'd see lost increments. */
        sched_yield();
        g_counter = v + 1;
        g_mut.unlock();
    }
    __sync_fetch_and_add(&g_done, 1);
    task_exit(0);
}

static void test_mutual_exclusion()
{
    st_begin("mutex: mutual exclusion (2 workers)");

    g_mut.init("test_mutex_mx");
    g_counter = 0;
    g_done    = 0;

    kthread_create("mut_w1", mutex_worker, nullptr, 0);
    kthread_create("mut_w2", mutex_worker, nullptr, 0);

    /* Spin-yield until both workers finish. */
    while (g_done < 2) {
        sched_yield();
    }

    ST_ASSERT_EQ(g_counter, 2 * kIters);
    ST_ASSERT(!g_mut.is_locked());

    st_pass();
}

/* ------------------------------------------------------------------ */
/*  Test 4: FIFO wake order                                           */
/* ------------------------------------------------------------------ */

static Mutex             g_fifo_mut;
static volatile int32    g_fifo_seq   = 0;     // monotonically increases
static volatile int32    g_fifo_order[3];      // order each worker observed
static volatile int32    g_fifo_done  = 0;

static void fifo_worker(void* arg)
{
    int slot = static_cast<int>(reinterpret_cast<uint64>(arg));
    g_fifo_mut.lock();
    g_fifo_order[slot] = __sync_fetch_and_add(&g_fifo_seq, 1);
    g_fifo_mut.unlock();
    __sync_fetch_and_add(&g_fifo_done, 1);
    task_exit(0);
}

static void test_fifo_order()
{
    st_begin("mutex: FIFO wake order (3 waiters)");

    g_fifo_mut.init("test_mutex_fifo");
    g_fifo_seq  = 0;
    g_fifo_done = 0;
    g_fifo_order[0] = g_fifo_order[1] = g_fifo_order[2] = -1;

    /* Main grabs the lock first so workers will queue up behind. */
    g_fifo_mut.lock();

    /* Spawn workers in deterministic order. After each create() yield
     * once so the new thread reaches mutex.lock() and enqueues itself
     * before we spawn the next one. */
    kthread_create("fifo_A", fifo_worker, reinterpret_cast<void*>(0), 0);
    sched_yield();
    kthread_create("fifo_B", fifo_worker, reinterpret_cast<void*>(1), 0);
    sched_yield();
    kthread_create("fifo_C", fifo_worker, reinterpret_cast<void*>(2), 0);
    sched_yield();

    /* Release: A should fire next, then B, then C. */
    g_fifo_mut.unlock();

    while (g_fifo_done < 3) {
        sched_yield();
    }

    ST_ASSERT_EQ(g_fifo_order[0], 0);
    ST_ASSERT_EQ(g_fifo_order[1], 1);
    ST_ASSERT_EQ(g_fifo_order[2], 2);

    st_pass();
}

/* ------------------------------------------------------------------ */
/*  Entry                                                             */
/* ------------------------------------------------------------------ */

void selftest_mutex()
{
    test_basic();
    test_trylock();
    test_mutual_exclusion();
    test_fifo_order();
}
