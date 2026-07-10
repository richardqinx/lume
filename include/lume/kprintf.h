/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Kernel Formatted Output — kprintf
 *
 * Provides printf-style formatted output for the kernel.
 * Built on top of stb_sprintf for full format string support
 * without any libc dependency.
 *
 * Output is synchronous and directed to the console (UART).
 * Safe to call from any context (interrupt or process).
 *
 * Usage:
 *   kprintf("Hello %s, addr=0x%lx\n", name, addr);
 */

#include <stdarg.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Formatted print to console (like printf). */
__attribute__((format(printf, 1, 2)))
int kprintf(const char* fmt, ...);

/* Formatted print with va_list. */
int kvprintf(const char* fmt, va_list va);

/* Formatted snprintf into buffer. */
__attribute__((format(printf, 3, 4)))
int ksnprintf(char* buf, int count, const char* fmt, ...);

#ifdef __cplusplus
}
#endif
