/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * RISC-V Architecture Configuration
 *
 * These constants define the architecture-specific memory layout.
 * Each arch/ implementation must provide this header with the same symbols.
 */

#include <lume/types.h>

namespace arch {

/* Kernel virtual address offset (higher-half base).
 * SV39: top of 39-bit VA space. VA = PA + kVAOffset. */
inline constexpr uint64 kVAOffset = 0xFFFFFFC000000000ULL;

/* Physical memory base (where RAM starts on RISC-V virt platform) */
inline constexpr uint64 kPhysBase = 0x80000000ULL;

}  // namespace arch
