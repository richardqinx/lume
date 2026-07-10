/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * kprintf.cc — Kernel formatted output
 *
 * Uses mpaland/printf's vsnprintf_ as the core formatting engine.
 *
 * Architecture:
 *   vsnprintf_()  ← pure formatting, writes to buffer
 *       ↓
 *   kprintf()     ← format + emit via console_write_all()
 *   kvprintf()    ← va_list variant
 *   ksnprintf()   ← format into caller's buffer
 *
 * Output path:
 *   Pre-registration:  console_write_all() → early_putc() fallback
 *   Post-registration: console_write_all() → struct console chain
 */

#include <lume/kprintf.h>
#include <lume/console.h>
#include <lume/atomic.h>
#include <arch/cpu.h>
#include "printf.h"

/* ------------------------------------------------------------------ */
/*  Console spinlock (raw, no scheduler dependency — safe in panic)    */
/* ------------------------------------------------------------------ */

static lume::atomic<uint32> g_console_lock{0};

static inline void console_lock_acquire()
{
    while (g_console_lock.exchange(1, __ATOMIC_ACQUIRE) != 0) {
        /* spin */
    }
}

static inline void console_lock_release()
{
    g_console_lock.store(0, __ATOMIC_RELEASE);
}

/* ------------------------------------------------------------------ */
/*  _putchar: required by mpaland/printf for printf_() / vprintf_()   */
/* ------------------------------------------------------------------ */

void _putchar(char character)
{
    early_putc(character);
}

/* ------------------------------------------------------------------ */
/*  Public API                                                        */
/* ------------------------------------------------------------------ */

extern "C" int kprintf(const char* fmt, ...)
{
    char buf[256];
    va_list va;
    va_start(va, fmt);
    int len = vsnprintf_(buf, sizeof(buf), fmt, va);
    va_end(va);

    /* Emit to console under lock */
    console_lock_acquire();
    console_write_all(buf, len);
    console_lock_release();
    return len;
}

extern "C" int kvprintf(const char* fmt, va_list va)
{
    char buf[256];
    int len = vsnprintf_(buf, sizeof(buf), fmt, va);

    console_lock_acquire();
    console_write_all(buf, len);
    console_lock_release();
    return len;
}

extern "C" int ksnprintf(char* buf, int count, const char* fmt, ...)
{
    va_list va;
    va_start(va, fmt);
    int ret = vsnprintf_(buf, (size_t)count, fmt, va);
    va_end(va);
    return ret;
}
