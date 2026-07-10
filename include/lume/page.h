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
 * metadata is valid at a time, determined by `type`.
 *
 * Fields:
 *   refcount  — lifecycle reference count (atomic). Page cannot be
 *               freed while refcount > 0.
 *   mapcount  — PTE mapping count (atomic). Number of page table
 *               entries pointing to this page. Used by COW and
 *               future reclaim.
 *   flags     — page state bits (PG_*). Also serves as a bit-lock
 *               via PG_LOCKED for short critical sections.
 *   type      — discriminant for the union (Free/Slab/Anon/File).
 *   mapping   — pointer to reverse-mapping context. For anonymous
 *               pages, points to AnonVma (low bit set). For file
 *               pages, points to FileMapping (low bit clear).
 *   index     — page offset within the mapping object.
 *
 * Reference: docs/specs/pmm.md §3.1
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/atomic.h>

/* Forward declarations */
class KmemCache;

/* ================================================================== */
/*  Page type discriminant                                            */
/* ================================================================== */

enum class PageType : uint8 {
    Free,       // In Buddy free list
    PcpCached,  // In Per-CPU cache (invisible to buddy coalescing)
    Allocated,  // Handed out but not yet typed (PMM default)
    Slab,       // Backing a Slab cache
    Anon,       // Anonymous user page
    File,       // File-backed page (page cache)
};

/* ================================================================== */
/*  Page flags (stored as atomic uint32)                              */
/* ================================================================== */

inline constexpr uint32 kPgLocked     = (1U << 0);  // Bit-lock for short critical sections
inline constexpr uint32 kPgReferenced = (1U << 1);  // Accessed since last check
inline constexpr uint32 kPgDirty      = (1U << 2);  // Modified, needs writeback
inline constexpr uint32 kPgWriteback  = (1U << 3);  // IO writeback in progress
inline constexpr uint32 kPgLru        = (1U << 4);  // On an LRU list
inline constexpr uint32 kPgMapped     = (1U << 5);  // Has at least one PTE mapping
inline constexpr uint32 kPgSwapcache  = (1U << 6);  // In swap cache (future)
inline constexpr uint32 kPgCow        = (1U << 7);  // Involved in COW sharing

/* ================================================================== */
/*  Page descriptor                                                   */
/* ================================================================== */

struct Page {
    /* --- Counts (atomic, lock-free) --- */
    lume::atomic<uint32> refcount;   // Lifecycle ref: 0 = reclaimable
    lume::atomic<uint32> mapcount;   // PTE mapping count: 0 = no user mapping

    /* --- State --- */
    lume::atomic<uint32> flags;      // PG_* bits (also serves as bit-lock)
    PageType type;                   // Discriminant for union
    uint8 order;                     // Buddy order (0–10, i.e. 4KB–4MB)

    /* --- Reverse mapping --- */
    void* mapping;                   // AnonVma* (low bit set) or FileMapping*
    uint64 index;                    // Page offset within mapping object

    /* --- LRU (future) --- */
    list_node lru;                   // LRU list linkage (for reclaim)

    /* --- Subsystem-specific metadata --- */
    union {
        /* Valid when type == Free */
        struct {
            list_node free_link;     // Link into Buddy or PCP free list
        } free;

        /* Valid when type == Slab */
        struct {
            KmemCache* cache;        // Owning slab cache
            uint32 obj_count;        // Number of allocated objects on this page
            void* freelist;          // Head of in-page free object linked list
        } slab;

        /* type == Anon / File: no extra union metadata (rmap via mapping) */
    };
};

/* ================================================================== */
/*  Page bit-lock (lightweight, no sleep, used for rmap critical       */
/*  sections and short metadata updates)                              */
/* ================================================================== */

inline bool page_trylock(Page* page)
{
    uint32 old = page->flags.fetch_or(kPgLocked);
    return (old & kPgLocked) == 0;
}

inline void page_lock(Page* page)
{
    while (!page_trylock(page)) {
        /* spin — acceptable for short critical sections only */
    }
}

inline void page_unlock(Page* page)
{
    page->flags.fetch_and(~kPgLocked);
}

/* ================================================================== */
/*  Mapping pointer helpers (Linux convention: low bit = anon)        */
/* ================================================================== */

inline bool page_is_anon(const Page* page)
{
    return (reinterpret_cast<uint64>(page->mapping) & 1ULL) != 0;
}

inline void* page_mapping_raw(const Page* page)
{
    return reinterpret_cast<void*>(
        reinterpret_cast<uint64>(page->mapping) & ~1ULL);
}

inline void page_set_anon_mapping(Page* page, void* anon_vma)
{
    page->mapping = reinterpret_cast<void*>(
        reinterpret_cast<uint64>(anon_vma) | 1ULL);
}

inline void page_set_file_mapping(Page* page, void* file_mapping)
{
    page->mapping = file_mapping;
}
