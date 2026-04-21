/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: Spinlock
 *
 * Tests:
 *   1. Basic acquire/release
 *   2. LockGuard RAII acquire/release
 *   3. Nested locking (two different locks)
 *   4. Interrupt state preservation across lock/unlock
 *   5. is_held_by_current_cpu correctness
 *
 * Note: We cannot test multi-core contention in BSP-only self-test.
 * That requires AP participation (future Phase 2 test).
 */

#include <lume/selftest.h>
#include <kernel/sync/spinlock.h>
#include <kernel/sync/cpu_state.h>
#include <arch/cpu.h>

void selftest_spinlock()
{
    st_begin("spinlock: basic acquire/release");
    {
        Spinlock lock;
        lock.init("test_basic");

        ST_ASSERT(!lock.is_held_by_current_cpu());

        lock.acquire();
        ST_ASSERT(lock.is_held_by_current_cpu());

        lock.release();
        ST_ASSERT(!lock.is_held_by_current_cpu());
    }
    st_pass();

    st_begin("spinlock: LockGuard RAII");
    {
        Spinlock lock;
        lock.init("test_guard");

        {
            LockGuard guard(lock);
            ST_ASSERT(lock.is_held_by_current_cpu());
        }
        // After scope exit, lock should be released
        ST_ASSERT(!lock.is_held_by_current_cpu());
    }
    st_pass();

    st_begin("spinlock: nested locking (two locks)");
    {
        Spinlock lock_a, lock_b;
        lock_a.init("test_nest_a");
        lock_b.init("test_nest_b");

        lock_a.acquire();
        ST_ASSERT(lock_a.is_held_by_current_cpu());

        lock_b.acquire();
        ST_ASSERT(lock_b.is_held_by_current_cpu());

        lock_b.release();
        ST_ASSERT(!lock_b.is_held_by_current_cpu());
        ST_ASSERT(lock_a.is_held_by_current_cpu());  // A still held

        lock_a.release();
        ST_ASSERT(!lock_a.is_held_by_current_cpu());
    }
    st_pass();

    st_begin("spinlock: interrupt state preservation");
    {
        Spinlock lock;
        lock.init("test_intr");

        // Interrupts are currently off (BSP init period), but let's
        // verify the lock doesn't corrupt the state.
        bool before = arch::cpu::intr_enabled();

        lock.acquire();
        // Inside lock, interrupts must be disabled
        ST_ASSERT(!arch::cpu::intr_enabled());
        lock.release();

        // After release, interrupt state should be restored
        ST_ASSERT_EQ(arch::cpu::intr_enabled(), before);
    }
    st_pass();
    st_begin("spinlock: deep nesting tracking (> 2)");
    {
        Spinlock l1, l2, l3;
        l1.init("l1");
        l2.init("l2");
        l3.init("l3");
        
        bool before = arch::cpu::intr_enabled();
        
        l1.acquire();
        l2.acquire();
        l3.acquire();
        
        ST_ASSERT(!arch::cpu::intr_enabled());
        
        l3.release();
        ST_ASSERT(!arch::cpu::intr_enabled());
        
        l2.release();
        ST_ASSERT(!arch::cpu::intr_enabled());
        
        l1.release();
        ST_ASSERT_EQ(arch::cpu::intr_enabled(), before);
    }
    st_pass();

    st_begin("spinlock: interrupt leak detection logic (lock_depth metadata)");
    {
        Spinlock l;
        l.init("l");
        
        auto& state = sync::g_cpu_sync_states[arch::cpu::id()];
        int initial_depth = state.lock_depth;
        
        l.acquire();
        // The lock depth should strictly increase
        ST_ASSERT_EQ(state.lock_depth, initial_depth + 1);
        l.release();
        
        ST_ASSERT_EQ(state.lock_depth, initial_depth);
    }
    st_pass();
}
