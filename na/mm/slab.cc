/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * slab.cc — SLUB allocator implementation
 *
 * Key design points:
 *   - Free object list is embedded in the objects themselves (first 8 bytes).
 *   - Per-page metadata lives in Frame.slab (cache, obj_count, freelist).
 *   - Per-CPU "active page" avoids lock contention on the fast path.
 *   - partial_ list protected by per-KmemCache Spinlock.
 *   - PMM calls happen outside the lock to avoid lock ordering issues.
 *
 * Address note: the kernel may be running at physical addresses via
 * identity mapping (before vmm_init).  We handle PA/VA carefully:
 * PMM gives us Frame*, frame_to_pa() gives PA, and we access page
 * contents via pa_to_va() (higher-half VA, always mapped).
 *
 * Reference: docs/specs/slab.md
 */

#include "slab.h"
#include <lume/pmm.h>
#include <lume/addr.h>
#include <lume/panic.h>
#include <lume/new.h>
#include <arch/cpu.h>

/* ------------------------------------------------------------------ */
/*  Helpers                                                           */
/* ------------------------------------------------------------------ */

/*
 * Convert a Frame* to the usable virtual address of the page's contents.
 * Uses the higher-half mapping which is always active.
 */
static inline void* frame_to_page_va(Frame* f)
{
    return reinterpret_cast<void*>(pa_to_va(frame_to_pa(f)));
}

/* Round up x to the next multiple of align (align must be power of 2) */
static inline uint32 align_up(uint32 x, uint32 align)
{
    return (x + align - 1) & ~(align - 1);
}

/* ------------------------------------------------------------------ */
/*  Global size-class caches                                          */
/* ------------------------------------------------------------------ */

KmemCache g_size_caches[kNumSizeClasses];

/* ------------------------------------------------------------------ */
/*  KmemCache::init                                                   */
/* ------------------------------------------------------------------ */

void KmemCache::init(const char* name, uint32 obj_size, uint32 obj_align)
{
    name_ = name;
    obj_align_ = (obj_align < 8) ? 8 : obj_align; // minimum 8 for freelist ptr
    obj_size_ = align_up((obj_size < 8) ? 8 : obj_size, obj_align_);
    objs_per_slab_ = kPageSize / obj_size_;

    lock_.init(name);
    partial_.init();

    for (int i = 0; i < kMaxCpus; i++)
        cpu_slab_[i].active = nullptr;
}

/* ------------------------------------------------------------------ */
/*  KmemCache::new_slab — allocate and format a fresh slab page       */
/* ------------------------------------------------------------------ */

Frame* KmemCache::new_slab()
{
    Frame* f = pmm_alloc_frame();
    if (!f)
        return nullptr;

    f->state = FrameState::Slab;
    f->slab.cache = this;
    f->slab.obj_count = 0;

    /* Build the embedded free list across all object slots */
    uint8* base = static_cast<uint8*>(frame_to_page_va(f));
    void* head = nullptr;

    /* Chain objects from last to first so freelist order = low addr first */
    for (int i = static_cast<int>(objs_per_slab_) - 1; i >= 0; i--) {
        void* obj = base + i * obj_size_;
        *reinterpret_cast<void**>(obj) = head;
        head = obj;
    }
    f->slab.freelist = head;

    return f;
}

/* ------------------------------------------------------------------ */
/*  Partial list management (lock must be held)                       */
/* ------------------------------------------------------------------ */

Frame* KmemCache::get_partial()
{
    /*
     * Phase 1 simplification: no partial list tracking.
     * The slow path always allocates a fresh page from PMM.
     * Full pages stay alive (Frame.slab.cache is valid for kfree).
     * Empty pages are returned to PMM immediately.
     *
     * TODO: add list_node to Frame.slab and implement partial tracking
     * to avoid wasting partially-filled pages.
     */
    (void)partial_;
    return nullptr;
}

void KmemCache::put_partial(Frame* f)
{
    (void)f;
}

void KmemCache::remove_partial(Frame* f)
{
    (void)f;
}

/* ------------------------------------------------------------------ */
/*  KmemCache::alloc                                                  */
/* ------------------------------------------------------------------ */

void* KmemCache::alloc()
{
    bool was_on = arch::cpu::intr_enabled();
    arch::cpu::intr_off();

    uint64 cpu = arch::cpu::id();
    Frame* active = cpu_slab_[cpu].active;

    /* Fast path: pop from active page's freelist */
    if (active && active->slab.freelist) {
        void* obj = active->slab.freelist;
        active->slab.freelist = *reinterpret_cast<void**>(obj);
        active->slab.obj_count++;
        if (was_on) arch::cpu::intr_on();
        return obj;
    }

    /* Slow path: need a new active page */

    /* If current active is full, detach it (it stays as Slab state,
     * cache pointer still valid for kfree to find it) */
    if (active && !active->slab.freelist) {
        cpu_slab_[cpu].active = nullptr;
    }

    if (was_on) arch::cpu::intr_on();

    /* Try to get a partial page or allocate a fresh one.
     * PMM call happens without any lock held. */
    Frame* new_page = new_slab();
    if (!new_page)
        return nullptr;

    /* Install as new active page */
    was_on = arch::cpu::intr_enabled();
    arch::cpu::intr_off();

    /* Another interrupt handler might have set a new active while we
     * were allocating. If so, put ours aside (simplified: just use ours). */
    cpu_slab_[cpu].active = new_page;

    void* obj = new_page->slab.freelist;
    new_page->slab.freelist = *reinterpret_cast<void**>(obj);
    new_page->slab.obj_count++;

    if (was_on) arch::cpu::intr_on();
    return obj;
}

/* ------------------------------------------------------------------ */
/*  KmemCache::free                                                   */
/* ------------------------------------------------------------------ */

void KmemCache::free(void* obj)
{
    if (!obj)
        return;

    /* Find the Frame for this object's page */
    uint64 obj_addr = reinterpret_cast<uint64>(obj);

    /* Convert VA to PA. Like pmm.cc, handle both PA and VA cases. */
    uint64 obj_pa = ensure_pa(obj_addr);
    uint64 page_pa = obj_pa & ~(kPageSize - 1);
    Frame* f = pa_to_frame(page_pa);

    if (f->state != FrameState::Slab || f->slab.cache != this)
        kernel_panic("slab free: object does not belong to this cache");

    bool was_on = arch::cpu::intr_enabled();
    arch::cpu::intr_off();

    /* Push object back onto the page's freelist */
    *reinterpret_cast<void**>(obj) = f->slab.freelist;
    f->slab.freelist = obj;
    f->slab.obj_count--;

    /* If page is now completely empty, return it to PMM */
    if (f->slab.obj_count == 0) {
        /* If this page is our active, clear it */
        uint64 cpu = arch::cpu::id();
        if (cpu_slab_[cpu].active == f)
            cpu_slab_[cpu].active = nullptr;

        if (was_on) arch::cpu::intr_on();

        /* Return page to PMM */
        f->slab.cache = nullptr;
        f->slab.freelist = nullptr;
        pmm_free_frame(f);
        return;
    }

    if (was_on) arch::cpu::intr_on();
}

/* ------------------------------------------------------------------ */
/*  Public free-function API                                          */
/* ------------------------------------------------------------------ */

/* Find the smallest size class >= size */
static KmemCache* find_cache(uint32 size)
{
    for (int i = 0; i < kNumSizeClasses; i++) {
        if (kSizeClasses[i] >= size)
            return &g_size_caches[i];
    }
    return nullptr; // Too large for slab
}

void* kmalloc(uint32 size)
{
    if (size == 0)
        return nullptr;

    /* Large allocation: fall back to PMM directly */
    if (size > kSizeClasses[kNumSizeClasses - 1]) {
        uint8 order = 0;
        uint64 needed = (size + kPageSize - 1) / kPageSize;
        while ((1ULL << order) < needed)
            order++;
        Frame* f = pmm_alloc_frames(order);
        if (!f)
            return nullptr;
        return reinterpret_cast<void*>(pa_to_va(frame_to_pa(f)));
    }

    KmemCache* cache = find_cache(size);
    if (!cache)
        return nullptr;
    return cache->alloc();
}

void kfree(void* ptr)
{
    if (!ptr)
        return;

    uint64 addr = reinterpret_cast<uint64>(ptr);
    uint64 pa = ensure_pa(addr);
    uint64 page_pa = pa & ~(kPageSize - 1);
    Frame* f = pa_to_frame(page_pa);

    if (f->state == FrameState::Slab) {
        KmemCache* cache = f->slab.cache;
        if (!cache)
            kernel_panic("kfree: slab frame has null cache");
        cache->free(ptr);
    } else if (f->state == FrameState::Allocated) {
        /* Large allocation — return directly to PMM */
        pmm_free_frames(f, f->order);
    } else {
        kernel_panic("kfree: invalid frame state");
    }
}

/* ------------------------------------------------------------------ */
/*  C++ operator new / delete                                         */
/* ------------------------------------------------------------------ */

/* Use decltype(sizeof(0)) instead of size_t to match the compiler's
 * built-in expectation for operator new (unsigned long vs unsigned long long). */
using __sz = decltype(sizeof(0));

void* operator new(__sz size)   { return kmalloc(static_cast<uint32>(size)); }
void* operator new[](__sz size) { return kmalloc(static_cast<uint32>(size)); }

void operator delete(void* ptr) noexcept          { kfree(ptr); }
void operator delete[](void* ptr) noexcept         { kfree(ptr); }
void operator delete(void* ptr, __sz) noexcept     { kfree(ptr); }
void operator delete[](void* ptr, __sz) noexcept   { kfree(ptr); }

/* ------------------------------------------------------------------ */
/*  Initialization                                                    */
/* ------------------------------------------------------------------ */

void slab_init()
{
    for (int i = 0; i < kNumSizeClasses; i++) {
        /* Build a name string like "kmalloc-32" */
        static const char* names[kNumSizeClasses] = {
            "kmalloc-8",   "kmalloc-16",  "kmalloc-32",
            "kmalloc-64",  "kmalloc-128", "kmalloc-256",
            "kmalloc-512", "kmalloc-1024","kmalloc-2048"
        };
        g_size_caches[i].init(names[i], kSizeClasses[i], 8);
    }
}
