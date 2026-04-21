/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Physical Memory Manager (PMM) — Buddy System + Per-CPU Cache
 *
 * Manages all physical page frames discovered via FDT.  Built on a
 * power-of-two buddy allocator for multi-page requests, with a
 * Per-CPU single-page cache (PCP) to reduce lock contention on the
 * hot single-frame alloc/free path.
 *
 * Concurrency model:
 *   - PCP operations run with interrupts disabled (same-CPU safety).
 *   - Global buddy operations are protected by a single Spinlock.
 *   - Reference counts use __atomic builtins (lock-free).
 *
 * Reference: docs/specs/pmm.md
 */

#include <lume/types.h>
#include <lume/frame.h>

/* Buddy system constants */
inline constexpr int kMaxOrder = 11;           // Orders 0..10 → 4KB..4MB
inline constexpr int kPcpHighWatermark = 64;   // Max frames cached per CPU
inline constexpr int kPcpBatchSize = 32;       // Frames moved per refill/drain

/* ================================================================== */
/*  Public free-function API                                          */
/* ================================================================== */

/*
 * Initialize the PMM.  Called by BSP after fdt_init().
 * Discovers memory via FDT, places frame_map, and populates buddy lists.
 * Panics on failure (no memory, bad FDT, etc.).
 */
void pmm_init();

/* --- Single-frame fast path (uses PCP) --- */

// Allocate one 4KB frame.  Returns nullptr on OOM.
Frame* pmm_alloc_frame();

// Free one 4KB frame.
void pmm_free_frame(Frame* frame);

/* --- Multi-frame slow path (direct buddy) --- */

// Allocate 2^order contiguous frames.  Returns nullptr on OOM.
Frame* pmm_alloc_frames(uint8 order);

// Free 2^order contiguous frames.
void pmm_free_frames(Frame* frame, uint8 order);

/* --- Reference counting (atomic, lock-free) --- */

void frame_incref(Frame* frame);
void frame_decref(Frame* frame);

/* --- Address conversion --- */

// Convert a Frame* to its physical address.
uint64 frame_to_pa(const Frame* frame);

// Convert a physical address to its Frame*.
Frame* pa_to_frame(uint64 pa);

// Convert a Frame* to a kernel virtual address.
uint64 frame_to_va(const Frame* frame);

// Query PMM memory range (for VMM kernel mapping)
uint64 pmm_get_mem_base();
uint64 pmm_get_mem_size();
