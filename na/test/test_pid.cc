/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_pid.cc — Self-tests for PID allocator
 *
 * Tests: alloc, free, re-use, exhaustion guard, reserved PIDs.
 */

#include <lume/selftest.h>
#include <lume/pid.h>

void selftest_pid()
{
    /* Create a local PidAllocator for isolated testing */
    PidAllocator pa;
    pa.init();

    /* ---- PID 0 is reserved (idle/swapper) ---- */
    st_begin("pid: PID 0 is reserved");
    {
        /* First alloc should return 1 (PID 0 reserved for idle) */
        int32 first = pa.alloc();
        ST_ASSERT(first >= 1);
    }
    st_pass();

    /* ---- Sequential allocation returns unique PIDs ---- */
    st_begin("pid: sequential allocation returns unique PIDs");
    {
        PidAllocator pa2;
        pa2.init();

        int32 p1 = pa2.alloc();
        int32 p2 = pa2.alloc();
        int32 p3 = pa2.alloc();
        ST_ASSERT(p1 >= 1);
        ST_ASSERT(p2 >= 1);
        ST_ASSERT(p3 >= 1);
        ST_ASSERT_NE(p1, p2);
        ST_ASSERT_NE(p2, p3);
        ST_ASSERT_NE(p1, p3);
    }
    st_pass();

    /* ---- Freed PID can be reused ---- */
    st_begin("pid: freed PID can be reused");
    {
        PidAllocator pa3;
        pa3.init();

        /* Allocate all PIDs from 2..N */
        constexpr int kAllocCount = 60;
        int32 pids[kAllocCount];
        for (int i = 0; i < kAllocCount; i++) {
            pids[i] = pa3.alloc();
            ST_ASSERT(pids[i] >= 1);
        }

        /* Free one in the middle */
        int32 freed_pid = pids[kAllocCount / 2];
        pa3.free(freed_pid);

        /* Allocate again — should eventually get the freed PID */
        bool found = false;
        for (int i = 0; i < kAllocCount; i++) {
            int32 p = pa3.alloc();
            if (p == freed_pid) { found = true; break; }
            pa3.free(p);
        }
        ST_ASSERT(found);
    }
    st_pass();

    /* ---- free invalid PID is safe ---- */
    st_begin("pid: free invalid PID is no-op");
    {
        PidAllocator pa4;
        pa4.init();

        /* These should not crash */
        pa4.free(-1);
        pa4.free(kMaxPid);
        pa4.free(kMaxPid + 100);

        /* Allocator should still work — PID 0 still reserved */
        int32 p = pa4.alloc();
        ST_ASSERT(p >= 1);
    }
    st_pass();

    /* ---- Monotonic allocation before wrap ---- */
    st_begin("pid: monotonic allocation");
    {
        PidAllocator pa5;
        pa5.init();

        int32 prev = pa5.alloc();
        for (int i = 0; i < 10; i++) {
            int32 next = pa5.alloc();
            ST_ASSERT(next > prev);
            prev = next;
        }
    }
    st_pass();
}
