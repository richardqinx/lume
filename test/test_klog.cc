/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: klog
 *
 * Tests:
 *   1. read vs read_consume semantics
 *   2. subsystem mask filtering
 *   3. ratelimit bookkeeping
 *   4. flush advances console tail when console filtering is active
 *   5. seq counter increments on writes
 */

#include <lume/selftest.h>
#include <lume/klog.h>
#include <string.h>

static void drain_klog()
{
    static char buf[512];
    while (true) {
        int n = klog_read_consume(buf, sizeof(buf));
        if (n <= 0) {
            break;
        }
    }
}

static bool test_read_peek_and_consume()
{
    drain_klog();

    klog_ex(KLOG_INFO, KLOG_SUBSYS_TEST, "klog_test_a");
    klog_ex(KLOG_INFO, KLOG_SUBSYS_TEST, "klog_test_b");

    KlogStats s0;
    klog_stats(&s0);

    char buf[1024];
    int n = klog_read(buf, sizeof(buf) - 1);
    if (n <= 0) {
        return false;
    }
    buf[n] = '\0';
    if (!strstr(buf, "klog_test_a") || !strstr(buf, "klog_test_b")) {
        return false;
    }

    KlogStats s1;
    klog_stats(&s1);
    if (s1.tail != s0.tail) {
        return false;
    }

    int n2 = klog_read_consume(buf, sizeof(buf) - 1);
    if (n2 <= 0) {
        return false;
    }
    buf[n2] = '\0';
    if (!strstr(buf, "klog_test_a") || !strstr(buf, "klog_test_b")) {
        return false;
    }

    KlogStats s2;
    klog_stats(&s2);
    return s2.tail != s0.tail;
}

static bool test_subsys_mask()
{
    drain_klog();

    const uint64 all_mask = (1ULL << KLOG_SUBSYS_MAX) - 1;
    klog_set_subsys_mask(1ULL << KLOG_SUBSYS_TEST);

    klog_ex(KLOG_INFO, KLOG_SUBSYS_TEST, "klog_subsys_ok");
    klog_ex(KLOG_INFO, KLOG_SUBSYS_GENERIC, "klog_subsys_drop");

    char buf[1024];
    int n = klog_read_consume(buf, sizeof(buf) - 1);
    klog_set_subsys_mask(all_mask);

    if (n <= 0) {
        return false;
    }
    buf[n] = '\0';
    return strstr(buf, "klog_subsys_ok") && !strstr(buf, "klog_subsys_drop");
}

static bool test_ratelimit()
{
    KlogRateLimit rl = {};
    rl.interval = 100;
    rl.burst = 2;

    bool a = klog_ratelimit(&rl, 10);
    bool b = klog_ratelimit(&rl, 20);
    bool c = klog_ratelimit(&rl, 30);

    if (!a || !b || c) {
        return false;
    }
    if (rl.printed != 2 || rl.suppressed != 1) {
        return false;
    }

    bool d = klog_ratelimit(&rl, 200);
    if (!d) {
        return false;
    }
    return rl.printed == 1 && rl.suppressed == 0;
}

static bool test_flush_advances_console_tail()
{
    drain_klog();

    klog_set_level(KLOG_ERR);
    klog_ex(KLOG_INFO, KLOG_SUBSYS_TEST, "klog_flush_msg");

    KlogStats s1;
    klog_stats(&s1);
    if (s1.console_tail == s1.head) {
        klog_set_level(static_cast<KlogLevel>(KLOG_DEFAULT_LEVEL));
        return false;
    }

    klog_flush();

    KlogStats s2;
    klog_stats(&s2);

    klog_set_level(static_cast<KlogLevel>(KLOG_DEFAULT_LEVEL));
    return s2.console_tail == s2.head;
}

static bool test_seq_increments()
{
    drain_klog();

    KlogStats s0;
    klog_stats(&s0);

    klog_ex(KLOG_INFO, KLOG_SUBSYS_TEST, "klog_seq_1");
    klog_ex(KLOG_INFO, KLOG_SUBSYS_TEST, "klog_seq_2");

    KlogStats s1;
    klog_stats(&s1);

    return s1.seq >= s0.seq + 2;
}

void selftest_klog()
{
    st_begin("klog: read vs read_consume");
    ST_ASSERT(test_read_peek_and_consume());
    st_pass();

    st_begin("klog: subsys mask filters");
    ST_ASSERT(test_subsys_mask());
    st_pass();

    st_begin("klog: ratelimit bookkeeping");
    ST_ASSERT(test_ratelimit());
    st_pass();

    st_begin("klog: flush advances console tail");
    ST_ASSERT(test_flush_advances_console_tail());
    st_pass();

    st_begin("klog: seq increments on write");
    ST_ASSERT(test_seq_increments());
    st_pass();
}
