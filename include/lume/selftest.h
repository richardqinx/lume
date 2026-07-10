/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Boot Self-Test Framework
 *
 * Minimal assertion-based test harness that runs during kernel_main()
 * after all subsystems are initialized.  Each test is a void function
 * that calls ST_ASSERT / ST_ASSERT_EQ macros.  On failure, prints
 * the failing expression and panics.
 *
 * Usage:
 *   void selftest_pmm();   // defined in test/test_pmm.cc
 *   void selftest_slab();  // defined in test/test_slab.cc
 *
 * All self-tests run only on BSP in single-core mode.
 */

#include <lume/types.h>
#include <lume/klog.h>
#include <lume/kprintf.h>

#define ST_ASSERT(cond) \
    do { \
        if (!(cond)) { \
            kprintf("[FAIL] %s:%d: assertion failed: %s\n", \
                    __FILE__, __LINE__, #cond); \
            kernel_panic("selftest failed", #cond); \
        } \
    } while (0)

#define ST_ASSERT_EQ(a, b) \
    do { \
        auto _a = (a); auto _b = (b); \
        if (_a != _b) { \
            kprintf("[FAIL] %s:%d: %s != %s (0x%llx != 0x%llx)\n", \
                    __FILE__, __LINE__, #a, #b, \
                    (uint64)(uintptr)(_a), (uint64)(uintptr)(_b)); \
            kernel_panic("selftest failed", #a " != " #b); \
        } \
    } while (0)

#define ST_ASSERT_NE(a, b) \
    do { \
        auto _a = (a); auto _b = (b); \
        if (_a == _b) { \
            kprintf("[FAIL] %s:%d: %s == %s (both 0x%llx)\n", \
                    __FILE__, __LINE__, #a, #b, \
                    (uint64)(uintptr)(_a)); \
            kernel_panic("selftest failed", #a " == " #b); \
        } \
    } while (0)

/* Announce a test suite beginning/end */
inline void st_begin(const char* name)
{
    kprintf("[test] %s ... ", name);
}

inline void st_pass()
{
    kprintf("PASS\n");
}
