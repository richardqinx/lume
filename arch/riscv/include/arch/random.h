/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

namespace arch {

/*
 * Get a random 64-bit value from the hardware TRNG.
 * Returns true if supported and successful, false otherwise.
 */
bool get_hw_random(uint64& value);

/*
 * Get the current high-resolution hardware cycle counter.
 * Used as an entropy fallback (Jitter/Timer).
 */
inline uint64 get_cycles()
{
    uint64 cycles;
    __asm__ volatile("rdcycle %0" : "=r"(cycles));
    return cycles;
}

} // namespace arch
