/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * SLUB Allocator — module-private header
 *
 * SLUB = Simple List of Unfull Blocks.
 * Metadata lives in Page descriptors (no per-page Slab header).
 * Free object list is embedded inside the objects themselves.
 * Per-CPU "active page" eliminates lock contention on the fast path.
 *
 * Reference: docs/specs/slab.md
 */

#include <lume/types.h>
#include <lume/config.h>
#include <lume/page.h>
#include <lume/list.h>
#include <kernel/sync/spinlock.h>

/* Size classes: 8, 16, 32, 64, 128, 256, 512, 1024, 2048 */
inline constexpr int kNumSizeClasses = 9;
inline constexpr uint32 kSizeClasses[kNumSizeClasses] = {
    8, 16, 32, 64, 128, 256, 512, 1024, 2048
};

/* Per-CPU active slab page pointer */
struct PerCpuSlab {
    Page* active;  // Currently used slab page (nullptr if none)
};

/*
 * KmemCache — manages a pool of fixed-size objects.
 *
 * Lock contract:
 *   lock_ protects partial_ list only.
 *   Per-CPU cpu_slab_ access requires interrupts disabled.
 *   PMM calls happen outside lock_ to avoid lock ordering issues.
 */
class KmemCache {
public:
    KmemCache() = default;

    // Explicit init (Placement New / BSS pattern)
    void init(const char* name, uint32 obj_size, uint32 obj_align);

    // Allocate one object. Returns nullptr on OOM.
    void* alloc();

    // Free one object back to its owning page.
    void free(void* obj);

    const char* name() const { return name_; }
    uint32 obj_size() const { return obj_size_; }

private:
    // Get a partially-filled page from the partial list (lock must be held)
    Page* get_partial();

    // Put a page onto the partial list (lock must be held)
    void put_partial(Page* page);

    // Remove a page from the partial list (lock must be held)
    void remove_partial(Page* page);

    // Allocate a new page from PMM and format it as a slab
    Page* new_slab();

    Spinlock lock_;                  // Protects partial_ only
    list_node partial_;              // Partially-filled slab pages

    PerCpuSlab cpu_slab_[kMaxCpus];  // Per-CPU active page

    const char* name_ = "uninit";
    uint32 obj_size_  = 0;           // Aligned object size (bytes)
    uint32 obj_align_ = 0;           // Alignment requirement
    uint32 objs_per_slab_ = 0;      // Objects per 4KB page
};

/* Global size-class caches */
extern KmemCache g_size_caches[kNumSizeClasses];
