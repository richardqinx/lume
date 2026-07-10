/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _LUME_LIMITS_H
#define _LUME_LIMITS_H

/*
 * Numeric limit constants — minimal subset needed by LumeOS kernel code.
 *
 * Values match the standard <limits.h> on all 64-bit LP64 targets, which
 * is the only ABI LumeOS supports.  Defined as plain integer literals so
 * this header is usable from C, C++, and assembly without dragging in
 * the toolchain's <limits.h> (which on hosted builds references libc
 * internals we don't link against).
 */

/* Signed/unsigned char */
#define SCHAR_MIN       (-128)
#define SCHAR_MAX       127
#define UCHAR_MAX       255
#define CHAR_MIN        SCHAR_MIN
#define CHAR_MAX        SCHAR_MAX

/* Short */
#define SHRT_MIN        (-32768)
#define SHRT_MAX        32767
#define USHRT_MAX       65535

/* Int */
#define INT_MIN         (-INT_MAX - 1)
#define INT_MAX         2147483647
#define UINT_MAX        4294967295U

/* Long (LP64: 64-bit) */
#define LONG_MIN        (-LONG_MAX - 1L)
#define LONG_MAX        9223372036854775807L
#define ULONG_MAX       18446744073709551615UL

/* Long long */
#define LLONG_MIN       (-LLONG_MAX - 1LL)
#define LLONG_MAX       9223372036854775807LL
#define ULLONG_MAX      18446744073709551615ULL

/* size_t (LP64) */
#define SIZE_MAX        ULONG_MAX
#define SSIZE_MAX       LONG_MAX

#endif /* _LUME_LIMITS_H */
