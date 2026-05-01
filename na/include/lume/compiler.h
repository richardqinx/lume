/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/**
 * compiler.h - Centralized management of compiler-specific macros and built-in wrappers.
 */

/* Memory barrier macros */
#define WRITE_ONCE(x, val) \
    do { \
        __asm__ volatile("" ::: "memory"); \
        (x) = (val); \
        __asm__ volatile("" ::: "memory"); \
    } while (0)

#define READ_ONCE(x) (*(volatile __typeof__(x) *)&(x))

#define barrier() __asm__ volatile("" ::: "memory")

/* Branch prediction hints */
#define unlikely(x) __builtin_expect(!!(x), 0)
#define likely(x)   __builtin_expect(!!(x), 1)

/* Function attributes */
#define __always_inline inline __attribute__((always_inline))
