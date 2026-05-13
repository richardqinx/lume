/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * memblock — Boot-time physical memory allocator
 *
 * A simple region-based allocator active from early boot until
 * the buddy system (PMM) takes over.  Inspired by Linux's memblock.
 *
 * Lifetime:
 *   1. memblock_init()       — discovers RAM via FDT, reserves kernel image
 *   2. vmm_init()            — uses memblock_alloc for page table pages & page_map
 *   3. pmm_init()            — absorbs remaining free regions into buddy
 *   4. memblock_retire()     — marks memblock inactive; all alloc via PMM
 *
 * This eliminates the need for post-init pointer relocation when
 * rebinding page_map to a VMEMMAP virtual address.
 */

#include <lume/types.h>

inline constexpr int kMemblockMaxRegions = 128;

/* Initialize memblock: scan FDT for RAM, reserve kernel image + firmware. */
void memblock_init(uint64 fdt_paddr);

/* Mark a physical range as reserved (will not be handed to buddy). */
void memblock_reserve(uint64 base, uint64 size);

/* Allocate `size` bytes aligned to `align` from top of free memory.
 * Returns PA, or 0 on failure. Used for page_map. */
uint64 memblock_alloc_top(uint64 size, uint64 align);

/* Allocate `size` bytes aligned to `align` from bottom of free memory.
 * Returns PA, or 0 on failure.  Used for page table pages. */
uint64 memblock_alloc(uint64 size, uint64 align);

/* Query memory layout (same info as FDT). */
uint64 memblock_get_mem_base();
uint64 memblock_get_mem_size();

/* Is memblock still the active allocator? */
bool memblock_is_active();

/* Mark memblock as retired (PMM takes over). */
void memblock_retire();

/* Iterate all free (unreserved) regions in ascending order.
 * Used by pmm_init() to feed free pages into the buddy system. */
void memblock_for_each_free(void (*cb)(uint64 base, uint64 size, void* ctx),
                            void* ctx);
