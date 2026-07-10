/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _LUME_COMPILER_H
#define _LUME_COMPILER_H

/*
 * Minimal compiler primitives used across LumeOS.
 *
 * Provides only what current code actually references:
 *   - READ_ONCE / WRITE_ONCE   memory access opacity for concurrent code
 *                              (rbtree.h, rbtree_augmented.h)
 *   - likely / unlikely        branch hints for hot/cold paths
 *
 * Implementation mirrors Linux's semantics — same surface, same effect —
 * without pulling in Linux's compiler_types.h cascade (KASAN/KCSAN/KMSAN
 * sanitizer attribute machinery, BTF type tags, hardened-usercopy hooks).
 * LumeOS doesn't build with those sanitizers, so the simpler form is
 * sufficient and keeps the dependency graph flat.
 */

/* Branch prediction hints */
#define likely(x)       __builtin_expect(!!(x), 1)
#define unlikely(x)     __builtin_expect(!!(x), 0)

/* Compile-time barrier — prevent the compiler from reordering memory
 * accesses across this point.  Not a CPU fence; for CPU ordering use
 * the architecture-specific fence intrinsics. */
#define barrier()       __asm__ __volatile__("" ::: "memory")

/*
 * __always_inline — force the compiler to actually inline a function,
 * overriding -fno-inline / -Os / size heuristics.  Used by rbtree helper
 * templates whose performance depends on the call being inlined into
 * the iterating loop.
 */
#define __always_inline inline __attribute__((__always_inline__))

/*
 * READ_ONCE / WRITE_ONCE — opaque single-access memory operations.
 *
 * The volatile cast prevents the compiler from:
 *   - merging adjacent reads/writes to the same location,
 *   - splitting a load into multiple narrower loads,
 *   - hoisting reads out of a loop (or sinking writes past one).
 *
 * Used in lock-free / cross-CPU shared data paths (rbtree color writes,
 * future RCU pointers, atomic flag polls).  Does NOT imply any CPU-side
 * memory ordering — pair with smp_mb()/acquire/release for that.
 */
#define READ_ONCE(x)        (*(const volatile __typeof__(x) *)&(x))
#define WRITE_ONCE(x, val)  (*(volatile __typeof__(x) *)&(x) = (val))

#endif /* _LUME_COMPILER_H */
