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
#include <lume/addr_types.h>
#include <lume/config.h>

/* Buddy system constants */
inline constexpr int kMaxOrder = CONFIG_MAX_ORDER;  // Orders 0..(N-1)

/* Per-CPU cache dynamic parameters (calculated in pmm_init) */
extern uint32 g_pcp_high_watermark;
extern uint32 g_pcp_batch_size;

/* ================================================================== */
/*  Public free-function API                                          */
/* ================================================================== */

/*
 * Initialize the PMM.  Called by BSP after vmm_init() + memblock.
 * frame_map is already mapped at VMEMMAP VA by vmm_init.
 * Populates buddy lists from memblock's free regions, then retires memblock.
 * Panics on failure.
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
PhysAddr frame_to_pa(const Frame* frame);

// Convert a physical address to its Frame*.
Frame* pa_to_frame(PhysAddr pa);

// Convert a Frame* to a kernel virtual address.
VirtAddr frame_to_va(const Frame* frame);

// Query PMM memory range (for VMM kernel mapping)
PhysAddr pmm_get_mem_base();
uint64 pmm_get_mem_size();
