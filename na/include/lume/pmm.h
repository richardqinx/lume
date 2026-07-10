/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Physical Memory Manager (PMM) — Buddy System + Per-CPU Cache
 *
 * Manages all physical pages discovered via FDT. Built on a
 * power-of-two buddy allocator for multi-page requests, with a
 * Per-CPU single-page cache (PCP) to reduce lock contention on the
 * hot single-page alloc/free path.
 *
 * Concurrency model:
 *   - PCP operations run with interrupts disabled (same-CPU safety).
 *   - Global buddy operations are protected by a single Spinlock.
 *   - Reference counts use __atomic builtins (lock-free).
 *
 * Reference: docs/specs/pmm.md
 */

#include <lume/types.h>
#include <lume/page.h>
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
 * page_map is already mapped at VMEMMAP VA by vmm_init.
 * Populates buddy lists from memblock's free regions, then retires memblock.
 * Panics on failure.
 */
void pmm_init();

/* --- Single-page fast path (uses PCP) --- */

// Allocate one 4KB page. Returns nullptr on OOM.
Page* pmm_alloc_page();

// Free one 4KB page.
void pmm_free_page(Page* page);

/* --- Multi-page slow path (direct buddy) --- */

// Allocate 2^order contiguous pages. Returns nullptr on OOM.
Page* pmm_alloc_pages(uint8 order);

// Free 2^order contiguous pages.
void pmm_free_pages(Page* page, uint8 order);

/* --- Reference counting (atomic, lock-free) --- */

void page_incref(Page* page);
void page_decref(Page* page);

/* --- Map counting (atomic, lock-free) --- */

inline void page_inc_mapcount(Page* page) {
    page->mapcount.fetch_add(1);
}

inline uint32 page_dec_mapcount(Page* page) {
    return page->mapcount.fetch_sub(1) - 1;  // Returns new value
}

inline uint32 page_mapcount(const Page* page) {
    return page->mapcount.load(__ATOMIC_RELAXED);
}

/* --- Address conversion --- */

// Convert a Page* to its physical address.
PhysAddr page_to_pa(const Page* page);

// Convert a physical address to its Page*.
Page* pa_to_page(PhysAddr pa);

// Convert a Page* to a kernel virtual address.
VirtAddr page_to_va(const Page* page);

/* --- PFN (Page Frame Number) abstraction --- */
/*
 * PFN is the fundamental unit for PA↔Page conversion.
 * PA↔PFN converters already exist in addr.h (pa_to_pfn / pfn_to_pa).
 * When sparse vmemmap lands, only pfn_to_page/page_to_pfn
 * need to change — no callers are affected.
 */

// Convert PFN to Page*. PFN = pa / PAGE_SIZE.
Page* pfn_to_page(uint64 pfn);

// Convert Page* to PFN.
uint64 page_to_pfn(const Page* page);

// Query PMM memory range (for VMM kernel mapping)
PhysAddr pmm_get_mem_base();
uint64 pmm_get_mem_size();
