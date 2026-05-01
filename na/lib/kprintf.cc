/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * kprintf.cc — Kernel formatted output
 *
 * Uses mpaland/printf's vsnprintf_ as the core formatting engine.
 * All kernel output ultimately goes through this module.
 *
 * Architecture:
 *   vsnprintf_()  ← pure formatting, writes to buffer
 *       ↓
 *   kprintf()     ← format + emit to UART via early_putc
 *   kvprintf()    ← va_list variant
 *   ksnprintf()   ← format into caller's buffer
 */

#include <lume/kprintf.h>
#include <lume/console.h>
#include "printf.h"

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

    /* Emit to console */
    for (int i = 0; i < len && buf[i] != '\0'; ++i) {
        early_putc(buf[i]);
    }
    return len;
}

extern "C" int kvprintf(const char* fmt, va_list va)
{
    char buf[256];
    int len = vsnprintf_(buf, sizeof(buf), fmt, va);

    for (int i = 0; i < len && buf[i] != '\0'; ++i) {
        early_putc(buf[i]);
    }
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
