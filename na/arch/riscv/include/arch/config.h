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
 *   0xFFFFFFD0_00000000  (320)  Vmemmap (Page array)
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
 * KASLR Layout Structure (Phase A: Unified KASLR State)
 *
 * This struct holds all KASLR results: the random seed, derived
 * hash, selected slot, and the randomised virtual address bases.
 * It serves as the single source of truth for all KASLR decisions
 * and is filled once during boot and read-only thereafter.
 * ================================================================ */

enum class KaslrSeedSource : uint8 {
    kFdt = 0,       /* Loaded from FDT /random node */
    kHardware = 1,  /* From hardware RNG (e.g., RDRAND) */
    kCycle = 2,     /* Fallback: CPU cycle counter */
};

struct KaslrLayout {
    /* Seed and provenance */
    uint64 seed;             /* 64-bit random seed value */
    uint64 seed_hash;        /* Non-plaintext derived hash (splitmix64) */
    KaslrSeedSource source;  /* Seed provenance (fdt/hw/cycle) */
    
    /* Randomisation parameters */
    uint64 slot;             /* Slot index: [0, 63] */
    uint64 slide_bytes;      /* Byte offset: slot * 1GB */
    
    /* Build-time policy */
    uint32 policy_id;        /* CONFIG_KASLR_POLICY_ID at build time */
    
    /* Randomised base addresses (post-KASLR) */
    uint64 direct_map_base;  /* Direct map VA (kDirectMapBaseDefault + slide) */
    uint64 vmemmap_base;     /* Vmemmap VA (kVmemmapBaseDefault + slide) */
    
    /* Validation flags (for debug logging) */
    bool canonical_ok;       /* All VA ranges passed canonical check */
    bool overlap_ok;         /* No overlaps detected between regions */
};

/* ================================================================
 * KASLR entry point
 *
 * Must be called AFTER random_early_init() and BEFORE vmm_init().
 * Fills g_kaslr_layout with randomised bases and self-check results.
 * When CONFIG_KASLR is disabled this is a no-op.
 * ================================================================ */
extern KaslrLayout g_kaslr_layout;

void kaslr_init();

/* Helper to query the KASLR layout safely */
static inline const KaslrLayout& kaslr_layout_get() {
    return g_kaslr_layout;
}

} // namespace arch
