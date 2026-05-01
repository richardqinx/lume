/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Bit Operations — portable kernel bit manipulation utilities
 *
 * Provides ctz, clz, ffs, fls and related operations.
 * All implementations are manual (no __builtin_ctz) to avoid
 * generating libgcc __ctzdi2/__clzdi2 calls in freestanding.
 */

#include <lume/types.h>

namespace lume {

/* ------------------------------------------------------------------ */
/*  Count Trailing Zeros (ctz)                                        */
/*  Returns the number of trailing 0-bits in val.                     */
/*  Precondition: val != 0 (undefined if val == 0).                   */
/* ------------------------------------------------------------------ */

static inline int ctz32(uint32 val)
{
    int n = 0;
    if (!(val & 0x0000FFFFU)) { n += 16; val >>= 16; }
    if (!(val & 0x000000FFU)) { n += 8;  val >>= 8;  }
    if (!(val & 0x0000000FU)) { n += 4;  val >>= 4;  }
    if (!(val & 0x00000003U)) { n += 2;  val >>= 2;  }
    if (!(val & 0x00000001U)) { n += 1;  }
    return n;
}

static inline int ctz64(uint64 val)
{
    if (static_cast<uint32>(val) != 0) {
        return ctz32(static_cast<uint32>(val));
    }
    return 32 + ctz32(static_cast<uint32>(val >> 32));
}

/* ------------------------------------------------------------------ */
/*  Count Leading Zeros (clz)                                         */
/*  Returns the number of leading 0-bits in val.                      */
/*  Precondition: val != 0 (undefined if val == 0).                   */
/* ------------------------------------------------------------------ */

static inline int clz32(uint32 val)
{
    int n = 0;
    if (!(val & 0xFFFF0000U)) { n += 16; val <<= 16; }
    if (!(val & 0xFF000000U)) { n += 8;  val <<= 8;  }
    if (!(val & 0xF0000000U)) { n += 4;  val <<= 4;  }
    if (!(val & 0xC0000000U)) { n += 2;  val <<= 2;  }
    if (!(val & 0x80000000U)) { n += 1;  }
    return n;
}

static inline int clz64(uint64 val)
{
    if (static_cast<uint32>(val >> 32) != 0) {
        return clz32(static_cast<uint32>(val >> 32));
    }
    return 32 + clz32(static_cast<uint32>(val));
}

/* ------------------------------------------------------------------ */
/*  Find First Set (ffs) — 1-indexed, returns 0 if val == 0           */
/* ------------------------------------------------------------------ */

static inline int ffs32(uint32 val)
{
    return val ? ctz32(val) + 1 : 0;
}

static inline int ffs64(uint64 val)
{
    return val ? ctz64(val) + 1 : 0;
}

/* ------------------------------------------------------------------ */
/*  Find Last Set (fls) — 1-indexed, returns 0 if val == 0            */
/*  Returns the position of the highest set bit.                      */
/* ------------------------------------------------------------------ */

static inline int fls32(uint32 val)
{
    return val ? 32 - clz32(val) : 0;
}

static inline int fls64(uint64 val)
{
    return val ? 64 - clz64(val) : 0;
}

/* ------------------------------------------------------------------ */
/*  Order (log2) — returns floor(log2(val)), val must be > 0          */
/* ------------------------------------------------------------------ */

static inline int ilog2_32(uint32 val)
{
    return fls32(val) - 1;
}

static inline int ilog2_64(uint64 val)
{
    return fls64(val) - 1;
}

/* ------------------------------------------------------------------ */
/*  Power-of-two test                                                 */
/* ------------------------------------------------------------------ */

static inline bool is_power_of_2(uint64 val)
{
    return val != 0 && (val & (val - 1)) == 0;
}

} /* namespace lume */
