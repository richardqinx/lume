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
#include <lume/panic.h>

extern "C" void early_puts(const char* s);

/* Print a decimal number (minimal, no printf available) */
inline void st_print_num(uint64 n)
{
    if (n == 0) { early_puts("0"); return; }
    char buf[21];
    int i = 20;
    buf[i] = '\0';
    while (n > 0 && i > 0) {
        buf[--i] = '0' + static_cast<char>(n % 10);
        n /= 10;
    }
    early_puts(&buf[i]);
}

inline void st_print_hex(uint64 n)
{
    early_puts("0x");
    char buf[17];
    int i = 16;
    buf[i] = '\0';
    if (n == 0) { early_puts("0"); return; }
    while (n > 0 && i > 0) {
        int d = static_cast<int>(n & 0xF);
        buf[--i] = (d < 10) ? ('0' + d) : ('a' + d - 10);
        n >>= 4;
    }
    early_puts(&buf[i]);
}

#define ST_ASSERT(cond) \
    do { \
        if (!(cond)) { \
            early_puts("[FAIL] "); \
            early_puts(__FILE__); \
            early_puts(":"); \
            st_print_num(__LINE__); \
            early_puts(": assertion failed: " #cond "\n"); \
            kernel_panic("selftest failed", #cond); \
        } \
    } while (0)

#define ST_ASSERT_EQ(a, b) \
    do { \
        auto _a = (a); auto _b = (b); \
        if (_a != _b) { \
            early_puts("[FAIL] "); \
            early_puts(__FILE__); \
            early_puts(":"); \
            st_print_num(__LINE__); \
            early_puts(": " #a " != " #b " ("); \
            st_print_hex((uint64)(uintptr)(_a)); \
            early_puts(" != "); \
            st_print_hex((uint64)(uintptr)(_b)); \
            early_puts(")\n"); \
            kernel_panic("selftest failed", #a " != " #b); \
        } \
    } while (0)

#define ST_ASSERT_NE(a, b) \
    do { \
        auto _a = (a); auto _b = (b); \
        if (_a == _b) { \
            early_puts("[FAIL] "); \
            early_puts(__FILE__); \
            early_puts(":"); \
            st_print_num(__LINE__); \
            early_puts(": " #a " == " #b " (both "); \
            st_print_hex((uint64)(uintptr)(_a)); \
            early_puts(")\n"); \
            kernel_panic("selftest failed", #a " == " #b); \
        } \
    } while (0)

/* Announce a test suite beginning/end */
inline void st_begin(const char* name)
{
    early_puts("[test] ");
    early_puts(name);
    early_puts(" ... ");
}

inline void st_pass()
{
    early_puts("PASS\n");
}
