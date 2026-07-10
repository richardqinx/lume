/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _LUME_TYPES_H
#define _LUME_TYPES_H

/*
 * LumeOS Base Type Definitions
 *
 * Three naming layers coexist so that source files imported from
 * upstream projects (Linux kernel, libfdt) compile unchanged:
 *
 *   LumeOS native               uint8 / int8 / ... / uint64 / int64
 *   Linux kernel short names    u8   / s8   / ... / u64   / s64
 *   POSIX / C99 (with _t)       uint8_t / ... / uint64_t / intptr_t
 *
 * All three resolve to the same underlying compiler builtin, so they
 * are binary-compatible.
 *
 * Declared with C `typedef` (not C++ `using`) so this header may be
 * included from .c sources — required for libfdt shims and the
 * arch/riscv/kernel/pi/ subsystem, which are pure C imports from
 * Linux.  C++ accepts `typedef` syntax identically.
 */

/* ===== LumeOS native names ===== */
typedef unsigned char       uint8;
typedef unsigned short      uint16;
typedef unsigned int        uint32;
typedef unsigned long long  uint64;

typedef signed char         int8;
typedef signed short        int16;
typedef signed int          int32;
typedef signed long long    int64;

typedef __SIZE_TYPE__       size_t;
typedef __PTRDIFF_TYPE__    ptrdiff_t;
typedef int64               ssize_t;
typedef uint64              uintptr;

/* ===== Linux kernel short names ===== */
typedef uint8  u8;   typedef int8   s8;
typedef uint16 u16;  typedef int16  s16;
typedef uint32 u32;  typedef int32  s32;
typedef uint64 u64;  typedef int64  s64;

/* ===== POSIX / C99 aliases =====
 * Guarded so a later #include <stdint.h> from libc-shim during musl
 * userspace builds is a no-op rather than a redefinition error. */
#ifndef _STDINT_H
# define _STDINT_H
typedef uint8       uint8_t;
typedef uint16      uint16_t;
typedef uint32      uint32_t;
typedef uint64      uint64_t;
typedef int8        int8_t;
typedef int16       int16_t;
typedef int32       int32_t;
typedef int64       int64_t;
typedef uintptr     uintptr_t;
typedef int64       intptr_t;
#endif

/* ===== Linux domain typedefs needed by RISC-V boot path ===== */
typedef uint64 phys_addr_t;

/* ===== libfdt on-wire types (big-endian).  Real byte-swap helpers
 *       live in <lume/libfdt_env.h>. ===== */
typedef uint16 fdt16_t;
typedef uint32 fdt32_t;
typedef uint64 fdt64_t;

#ifndef offsetof
# define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
#endif

#endif /* _LUME_TYPES_H */
