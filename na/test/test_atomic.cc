/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: lume::atomic<T>
 *
 * Tests:
 *   1. Default construction (zero-initialized)
 *   2. Explicit construction
 *   3. store / load round-trip with different memory orders
 *   4. exchange returns old value
 *   5. fetch_add / fetch_sub arithmetic
 *   6. compare_exchange success and failure paths
 */

#include <lume/selftest.h>
#include <lume/atomic.h>

void selftest_atomic() {
    st_begin("atomic: default construction is zero");
    {
        lume::atomic<uint32> a;
        ST_ASSERT_EQ(a.load(), 0U);
    }
    st_pass();

    st_begin("atomic: explicit construction");
    {
        lume::atomic<uint64> a(42);
        ST_ASSERT_EQ(a.load(), 42ULL);
    }
    st_pass();

    st_begin("atomic: store/load round-trip");
    {
        lume::atomic<uint32> a;
        a.store(0xDEAD, __ATOMIC_RELEASE);
        ST_ASSERT_EQ(a.load(__ATOMIC_ACQUIRE), 0xDEADU);

        a.store(0, __ATOMIC_SEQ_CST);
        ST_ASSERT_EQ(a.load(__ATOMIC_SEQ_CST), 0U);
    }
    st_pass();

    st_begin("atomic: exchange returns old value");
    {
        lume::atomic<uint32> a(10);
        uint32 old = a.exchange(20);
        ST_ASSERT_EQ(old, 10U);
        ST_ASSERT_EQ(a.load(), 20U);
    }
    st_pass();

    st_begin("atomic: fetch_add / fetch_sub");
    {
        lume::atomic<uint32> a(100);

        uint32 old = a.fetch_add(5);
        ST_ASSERT_EQ(old, 100U);
        ST_ASSERT_EQ(a.load(), 105U);

        old = a.fetch_sub(10);
        ST_ASSERT_EQ(old, 105U);
        ST_ASSERT_EQ(a.load(), 95U);

        // Underflow wraps (unsigned)
        lume::atomic<uint32> b(0);
        old = b.fetch_sub(1);
        ST_ASSERT_EQ(old, 0U);
        ST_ASSERT_EQ(b.load(), 0xFFFFFFFFU);
    }
    st_pass();

    st_begin("atomic: compare_exchange success and failure");
    {
        lume::atomic<uint32> a(42);

        // Success path: expected matches, swap happens
        uint32 expected = 42;
        bool ok = a.compare_exchange(expected, 99);
        ST_ASSERT(ok);
        ST_ASSERT_EQ(a.load(), 99U);
        ST_ASSERT_EQ(expected, 42U);  // expected unchanged on success

        // Failure path: expected doesn't match, expected gets updated
        expected = 0;  // wrong
        ok = a.compare_exchange(expected, 200);
        ST_ASSERT(!ok);
        ST_ASSERT_EQ(a.load(), 99U);       // value unchanged
        ST_ASSERT_EQ(expected, 99U);        // expected updated to actual value
    }
    st_pass();

    st_begin("atomic: 64-bit fetch_add correctness");
    {
        lume::atomic<uint64> a(0xFFFFFFFF00000000ULL);
        uint64 old = a.fetch_add(1);
        ST_ASSERT_EQ(old, 0xFFFFFFFF00000000ULL);
        ST_ASSERT_EQ(a.load(), 0xFFFFFFFF00000001ULL);
    }
    st_pass();
}
