/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Page — Physical page descriptor
 *
 * Each Page describes one 4KB physical page. A flat array of Page
 * structs (page_map) covers all physical memory discovered via FDT.
 *
 * Memory layout is compressed using a union: only one of free/slab
 * metadata is valid at a time, determined by `state`. The refcount
 * field is independent of the union to support COW sharing.
 *
 * Reference: docs/specs/pmm.md §3.1
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/atomic.h>

/* Forward declaration — defined in slab module (Phase 2) */
class KmemCache;

enum class PageState : uint8 {
    Free,       // In Buddy free list
    PcpCached,  // In Per-CPU cache (invisible to buddy coalescing)
    Allocated,  // Handed out to Slab / VMM / user
    Slab,       // Backing a Slab cache
};

struct Page {
    /*
     * Reference count (atomic).
     * Starts at 1 on allocation. Incremented by fork() for COW pages.
     * When decremented to 0, the page is returned to the free pool.
     */
    lume::atomic<uint32> refcount;

    PageState state;  // Current usage state
    uint8 order;      // Buddy order (0–10, i.e. 4KB–4MB)

    union {
        /* Valid when state == Free */
        struct {
            list_node free_link;  // Link into Buddy or PCP free list
        } free;

        /* Valid when state == Slab */
        struct {
            KmemCache* cache;     // Owning slab cache
            uint32 obj_count;     // Number of allocated objects on this page
            void* freelist;       // Head of in-page free object linked list
        } slab;

        /* state == Allocated: no extra metadata (yet) */
    };
};
