/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * RISC-V Architecture Configuration
 *
 * These constants define the architecture-specific memory layout.
 * Each arch/ implementation must provide this header with the same symbols.
 *
 * KASLR: At boot, kaslr_init() randomises g_direct_map_base and
 * g_vmemmap_base.  All MI code must read these runtime variables
 * (via pa_to_va / vmm helpers) rather than the static defaults.
 */

#include <lume/types.h>

namespace arch {

/* ================================================================
 * Default (compile-time) virtual addresses
 *
 * SV39 gives a 512GB virtual address space.
 * Higher-half layout (defaults before KASLR):
 *
 *   0xFFFFFFC0_00000000  (256)  Direct map (PA+offset)
 *   0xFFFFFFD0_00000000  (320)  Vmemmap (Frame array)
 *
 * The 64GB gap between them is the KASLR slide range.
 * ================================================================ */
inline constexpr uint64 kDirectMapBaseDefault = 0xFFFFFFC000000000ULL;
inline constexpr uint64 kVmemmapBaseDefault   = 0xFFFFFFD000000000ULL;

/* Physical memory base (where RAM starts on RISC-V virt platform) */
inline constexpr uint64 kPhysBase = 0x80000000ULL;

/* ================================================================
 * Runtime (post-KASLR) virtual addresses
 *
 * These start equal to the defaults above.  If CONFIG_KASLR is
 * enabled, kaslr_init() adds a random, 1GB-aligned offset
 * to each, sliding both regions upward in VA space.
 * ================================================================ */
extern uint64 g_direct_map_base;
extern uint64 g_vmemmap_base;

/* ================================================================
 * KASLR entry point
 *
 * Must be called AFTER random_early_init() and BEFORE vmm_init().
 * When CONFIG_KASLR is disabled this is a no-op.
 * ================================================================ */
void kaslr_init();

} // namespace arch
