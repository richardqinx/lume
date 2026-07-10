/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef LIBFDT_ENV_H
#define LIBFDT_ENV_H

/*
 * Kernel-side adapter for the standalone libfdt sources in
 * scripts/dtc/libfdt/.  libfdt's *.c files start with
 *   #include "libfdt_env.h"
 * and expect this header to provide:
 *   - byte-swap helpers       (cpu_to_fdt16/32/64, fdt16/32/64_to_cpu)
 *   - fdt16/32/64_t typedefs  (just plain uint types — endianness is
 *                              handled in the helpers above)
 *   - string / mem helpers    (memcpy, memmove, memcmp, strlen, strcmp,
 *                              strchr, strnlen, ...)
 *   - INT_MAX, UINT32_MAX     (libfdt bounds-checks props with these)
 *   - size_t / uintptr_t      (everywhere)
 *
 * LumeOS-native: no Linux <linux/...> includes.  Provides the surface
 * libfdt needs and nothing else.
 */

#include <lume/types.h>		/* uint16_t / uint32_t / uint64_t / size_t */
#include <lume/limits.h>	/* INT_MAX */
#include <string.h>		/* libc-shim memcpy / memcmp / strlen ... */

/* libfdt uses these names; both come from <lume/limits.h>. */
#define INT32_MAX	2147483647
#define UINT32_MAX	4294967295U

/* libfdt's "FDT word" types — opaque big-endian-stored u16/u32/u64.
 * The byte-swap helpers below are the only access path. */
typedef uint16_t	fdt16_t;
typedef uint32_t	fdt32_t;
typedef uint64_t	fdt64_t;

/*
 * Endianness helpers.  FDT (Device Tree Blob) is big-endian by spec.
 * LumeOS runs on RISC-V (little-endian) and x86 (little-endian); we
 * unconditionally byte-swap.
 *
 * Open-coded shifts rather than __builtin_bswapN — on RISC-V without
 * the Zbb extension, gcc lowers __builtin_bswap32 to a libgcc call
 * (__bswapsi2 / __bswapdi2) which isn't present in a freestanding
 * kernel link.  Mirrors Linux's scripts/dtc/libfdt/libfdt_env.h
 * which uses ___constant_swab32-style explicit shifts. */
static inline uint16_t __lumefdt_bswap16(uint16_t x)
{
    return (uint16_t)((x << 8) | (x >> 8));
}
static inline uint32_t __lumefdt_bswap32(uint32_t x)
{
    return  ((x & 0x000000FFu) << 24) |
            ((x & 0x0000FF00u) <<  8) |
            ((x & 0x00FF0000u) >>  8) |
            ((x & 0xFF000000u) >> 24);
}
static inline uint64_t __lumefdt_bswap64(uint64_t x)
{
    return  ((x & 0x00000000000000FFull) << 56) |
            ((x & 0x000000000000FF00ull) << 40) |
            ((x & 0x0000000000FF0000ull) << 24) |
            ((x & 0x00000000FF000000ull) <<  8) |
            ((x & 0x000000FF00000000ull) >>  8) |
            ((x & 0x0000FF0000000000ull) >> 24) |
            ((x & 0x00FF000000000000ull) >> 40) |
            ((x & 0xFF00000000000000ull) >> 56);
}

#define fdt16_to_cpu(x)		__lumefdt_bswap16((uint16_t)(x))
#define cpu_to_fdt16(x)		((fdt16_t)__lumefdt_bswap16((uint16_t)(x)))
#define fdt32_to_cpu(x)		__lumefdt_bswap32((uint32_t)(x))
#define cpu_to_fdt32(x)		((fdt32_t)__lumefdt_bswap32((uint32_t)(x)))
#define fdt64_to_cpu(x)		__lumefdt_bswap64((uint64_t)(x))
#define cpu_to_fdt64(x)		((fdt64_t)__lumefdt_bswap64((uint64_t)(x)))

#endif /* LIBFDT_ENV_H */
