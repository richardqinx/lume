/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * pmm.cc — Physical Memory Manager implementation
 *
 * Buddy allocator with Per-CPU single-page caches (PCP).
 *
 * Initialization sequence (called by BSP in single-core period):
 *   1. Query FDT for physical memory base and size.
 *   2. Carve out space for the frame_map array at the start of free memory
 *      (immediately after _kernel_end, page-aligned).
 *   3. Initialize all Frame descriptors as Free.
 *   4. Feed free frames into the buddy system at the highest possible order.
 *
 * The frame_map is a flat array indexed by physical page frame number (PFN).
 * PFN = (pa - mem_base) / PAGE_SIZE.  This keeps address conversion O(1).
 *
 * Reference: docs/specs/pmm.md
 */

#include <lume/pmm.h>
#include <lume/addr.h>
#include <lume/config.h>
#include <lume/fdt.h>
#include <lume/new.h>
#include <lume/panic.h>
#include <lume/types.h>
#include <arch/cpu.h>
#include <kernel/sync/spinlock.h>

/* ------------------------------------------------------------------ */
/*  Linker symbols                                                    */
/* ------------------------------------------------------------------ */

extern "C" char _kernel_end[];

/* ------------------------------------------------------------------ */
/*  Per-CPU page cache                                                */
/* ------------------------------------------------------------------ */

struct PerCpuCache {
    list_node free_list;   // Single-frame free list
    uint32 count;          // Number of cached frames
};

/* ------------------------------------------------------------------ */
/*  Module-private state                                              */
/* ------------------------------------------------------------------ */

static Spinlock        g_pmm_lock;
static list_node       g_free_areas[kMaxOrder];   // Buddy free lists [0..10]
static PerCpuCache     g_pcp[kMaxCpus];

static Frame*          g_frame_map = nullptr;      // Flat array of Frame descriptors
static uint64          g_mem_base  = 0;            // Physical memory base (from FDT)
static uint64          g_mem_size  = 0;            // Total physical memory size
static uint64          g_num_frames = 0;           // Total managed frames

/* ------------------------------------------------------------------ */
/*  Address conversion helpers                                        */
/* ------------------------------------------------------------------ */

/*
 * Physical Frame Number: index into the frame_map array.
 * PFN = (pa - g_mem_base) / kPageSize
 */
static inline uint64 pa_to_frame_index(uint64 pa)
{
    return (pa - g_mem_base) / kPageSize;
}

static inline uint64 frame_index_to_pa(uint64 idx)
{
    return g_mem_base + idx * kPageSize;
}

uint64 frame_to_pa(const Frame* frame)
{
    uint64 idx = static_cast<uint64>(frame - g_frame_map);
    if (frame < g_frame_map || idx >= g_num_frames)
        kernel_panic("frame_to_pa: frame outside frame_map bounds");
    return frame_index_to_pa(idx);
}

Frame* pa_to_frame(uint64 pa)
{
    uint64 idx = pa_to_frame_index(pa);
    return &g_frame_map[idx];
}

uint64 frame_to_va(const Frame* frame)
{
    return pa_to_va(frame_to_pa(frame));
}

/* ------------------------------------------------------------------ */
/*  Buddy system internals (caller must hold g_pmm_lock)              */
/* ------------------------------------------------------------------ */

/*
 * Find a frame's buddy at a given order.
 * Buddy PFN = PFN ^ (1 << order).
 */
static inline Frame* buddy_of(Frame* frame, uint8 order)
{
    uint64 pfn = static_cast<uint64>(frame - g_frame_map);
    uint64 buddy_pfn = pfn ^ (1ULL << order);
    if (buddy_pfn >= g_num_frames)
        return nullptr;
    return &g_frame_map[buddy_pfn];
}

/*
 * Insert a free block into the buddy free list at the given order.
 */
static void buddy_list_add(Frame* frame, uint8 order)
{
    frame->state = FrameState::Free;
    frame->order = order;
    list_node* head = &g_free_areas[order];
    list_node* node = &frame->free.free_link;
    node->next = head->next;
    node->prev = head;
    head->next->prev = node;
    head->next = node;
}

/*
 * Remove a block from whatever buddy free list it is on.
 */
static void buddy_list_del(Frame* frame)
{
    list_node* node = &frame->free.free_link;
    node->prev->next = node->next;
    node->next->prev = node->prev;
    node->next = node;
    node->prev = node;
}

/*
 * Allocate a block of 2^order contiguous frames from the buddy system.
 * Splits higher-order blocks if no exact match is available.
 * Returns nullptr if no memory available.
 */
static Frame* buddy_alloc(uint8 order)
{
    for (int cur = order; cur < kMaxOrder; cur++) {
        list_node* head = &g_free_areas[cur];
        if (head->next == head)
            continue; // Empty at this order

        // Pop the first block from this order's free list
        list_node* node = head->next;
        // Compute Frame* from the free_link member offset
        Frame* frame = reinterpret_cast<Frame*>(
            reinterpret_cast<uintptr>(node) -
            __builtin_offsetof(Frame, free.free_link));
        buddy_list_del(frame);

        // Split down to the requested order
        while (cur > order) {
            cur--;
            // The upper half becomes a free buddy
            Frame* split = &g_frame_map[(frame - g_frame_map) + (1ULL << cur)];
            buddy_list_add(split, static_cast<uint8>(cur));
        }

        frame->state = FrameState::Allocated;
        frame->order = order;
        frame->refcount.store(1, __ATOMIC_RELAXED);
        return frame;
    }
    return nullptr;
}

/*
 * Return a block of 2^order frames to the buddy system.
 * Coalesces with its buddy recursively up to kMaxOrder-1.
 */
static void buddy_free(Frame* frame, uint8 order)
{
    uint64 pfn = static_cast<uint64>(frame - g_frame_map);

    while (order < kMaxOrder - 1) {
        Frame* buddy = buddy_of(frame, order);
        if (!buddy)
            break;
        // Buddy must be free AND at the same order to coalesce
        if (buddy->state != FrameState::Free || buddy->order != order)
            break;

        // Remove buddy from its free list and merge
        buddy_list_del(buddy);

        // The merged block starts at the lower PFN
        uint64 buddy_pfn = static_cast<uint64>(buddy - g_frame_map);
        if (buddy_pfn < pfn) {
            frame = buddy;
            pfn = buddy_pfn;
        }
        order++;
    }

    buddy_list_add(frame, order);
}

/* ------------------------------------------------------------------ */
/*  Per-CPU cache operations (interrupts must be disabled by caller)   */
/* ------------------------------------------------------------------ */

/*
 * Refill the PCP from the global buddy system.
 * Acquires g_pmm_lock internally.
 */
static void refill_pcp(PerCpuCache* pcp)
{
    LockGuard guard(g_pmm_lock);
    for (int i = 0; i < kPcpBatchSize; i++) {
        Frame* f = buddy_alloc(0);
        if (!f)
            break;
        // Put onto PCP list (reuse the free_link for PCP chain)
        f->state = FrameState::PcpCached;
        list_node* node = &f->free.free_link;
        node->next = pcp->free_list.next;
        node->prev = &pcp->free_list;
        pcp->free_list.next->prev = node;
        pcp->free_list.next = node;
        pcp->count++;
    }
}

/*
 * Drain half the PCP back to the global buddy system.
 * Acquires g_pmm_lock internally.
 */
static void drain_pcp(PerCpuCache* pcp)
{
    LockGuard guard(g_pmm_lock);
    int to_drain = pcp->count / 2;
    for (int i = 0; i < to_drain; i++) {
        list_node* head = &pcp->free_list;
        if (head->next == head)
            break;
        list_node* node = head->next;
        // Unlink from PCP
        node->prev->next = node->next;
        node->next->prev = node->prev;
        pcp->count--;

        Frame* f = reinterpret_cast<Frame*>(
            reinterpret_cast<uintptr>(node) -
            __builtin_offsetof(Frame, free.free_link));
        buddy_free(f, 0);
    }
}

/* ------------------------------------------------------------------ */
/*  Public API: single-frame (fast path via PCP)                      */
/* ------------------------------------------------------------------ */

Frame* pmm_alloc_frame()
{
    /*
     * Disable interrupts to prevent reentry on the same CPU
     * (e.g. timer IRQ handler calling pmm_alloc_frame while we
     * are mid-way through manipulating the PCP list).
     */
    bool was_on = arch::cpu::intr_enabled();
    arch::cpu::intr_off();

    uint64 cpu = arch::cpu::id();
    PerCpuCache* pcp = &g_pcp[cpu];

    if (pcp->count == 0)
        refill_pcp(pcp);

    Frame* frame = nullptr;
    if (pcp->count > 0) {
        list_node* node = pcp->free_list.next;
        // Unlink
        node->prev->next = node->next;
        node->next->prev = node->prev;
        pcp->count--;

        frame = reinterpret_cast<Frame*>(
            reinterpret_cast<uintptr>(node) -
            __builtin_offsetof(Frame, free.free_link));

        // Validate the frame is within the frame_map bounds
        if (frame < g_frame_map || frame >= g_frame_map + g_num_frames) {
            kernel_panic("pmm_alloc_frame: PCP returned out-of-bounds frame");
        }

        frame->state = FrameState::Allocated;
        frame->order = 0;
        frame->refcount.store(1, __ATOMIC_RELAXED);
    }

    if (was_on)
        arch::cpu::intr_on();
    return frame;
}

void pmm_free_frame(Frame* frame)
{
    if (!frame)
        kernel_panic("pmm_free_frame: null frame");

    bool was_on = arch::cpu::intr_enabled();
    arch::cpu::intr_off();

    uint64 cpu = arch::cpu::id();
    PerCpuCache* pcp = &g_pcp[cpu];

    // Push onto PCP
    frame->state = FrameState::PcpCached;
    frame->order = 0;
    list_node* node = &frame->free.free_link;
    node->next = pcp->free_list.next;
    node->prev = &pcp->free_list;
    pcp->free_list.next->prev = node;
    pcp->free_list.next = node;
    pcp->count++;

    // Drain if over high watermark
    if (pcp->count >= kPcpHighWatermark)
        drain_pcp(pcp);

    if (was_on)
        arch::cpu::intr_on();
}

/* ------------------------------------------------------------------ */
/*  Public API: multi-frame (slow path, direct buddy)                 */
/* ------------------------------------------------------------------ */

Frame* pmm_alloc_frames(uint8 order)
{
    if (order >= kMaxOrder)
        return nullptr;
    LockGuard guard(g_pmm_lock);
    return buddy_alloc(order);
}

void pmm_free_frames(Frame* frame, uint8 order)
{
    if (!frame)
        kernel_panic("pmm_free_frames: null frame");
    if (order >= kMaxOrder)
        kernel_panic("pmm_free_frames: order out of range");
    LockGuard guard(g_pmm_lock);
    buddy_free(frame, order);
}

/* ------------------------------------------------------------------ */
/*  Public API: reference counting                                    */
/* ------------------------------------------------------------------ */

void frame_incref(Frame* frame)
{
    frame->refcount.fetch_add(1);
}

void frame_decref(Frame* frame)
{
    uint32 old = frame->refcount.fetch_sub(1);
    if (old == 1) {
        // Refcount dropped to 0 — return to pool based on originally allocated order
        if (frame->order == 0)
            pmm_free_frame(frame);
        else
            pmm_free_frames(frame, frame->order);
    }
}

/* ------------------------------------------------------------------ */
/*  Initialization                                                    */
/* ------------------------------------------------------------------ */

/*
 * Helper: zero out a range of bytes.  We cannot use memset here
 * because lib/string may not be linked yet.
 */
static void zero_range(void* start, uint64 bytes)
{
    uint8* p = static_cast<uint8*>(start);
    for (uint64 i = 0; i < bytes; i++)
        p[i] = 0;
}

void pmm_init()
{
    /* 1. Query FDT for physical memory layout */
    uint64 mem_base = 0, mem_size = 0;
    fdt_early_get_mem_info(&mem_base, &mem_size);

    if (mem_size == 0)
        kernel_panic("pmm_init: FDT reports zero memory");

    g_mem_base = mem_base;
    g_mem_size = mem_size;

    uint64 mem_end = mem_base + mem_size;
    g_num_frames = mem_size / kPageSize;

    /*
     * 2. Place the frame_map array.
     *
     * The frame_map lives right after the kernel image (_kernel_end),
     * page-aligned.  We compute its size and mark that region as used.
     *
     * _kernel_end is a virtual address; convert to physical for arithmetic,
     * then back to virtual for the actual pointer.
     */
    /*
     * _kernel_end is linked at a virtual address (0xFFFFFFC0...),
     * but if the kernel is still running via identity mapping (before
     * vmm_init removes it), PC-relative `la` resolves to the physical
     * address instead.  Detect which case we're in.
     */
    uint64 kernel_end_raw = reinterpret_cast<uint64>(_kernel_end);
    uint64 kernel_end_pa = ensure_pa(kernel_end_raw);
    uint64 frame_map_pa = (kernel_end_pa + kPageSize - 1) & ~(kPageSize - 1);
    uint64 frame_map_bytes = g_num_frames * sizeof(Frame);
    uint64 frame_map_end_pa = (frame_map_pa + frame_map_bytes + kPageSize - 1)
                              & ~(kPageSize - 1);

    if (frame_map_end_pa > mem_end)
        kernel_panic("pmm_init: not enough memory for frame_map");

    g_frame_map = reinterpret_cast<Frame*>(pa_to_va(frame_map_pa));

    /* 3. Zero out the entire frame_map */
    zero_range(g_frame_map, frame_map_bytes);

    /* 4. Initialize buddy free list heads */
    g_pmm_lock.init("pmm");
    for (int i = 0; i < kMaxOrder; i++)
        g_free_areas[i].init();

    /* 5. Initialize PCP list heads */
    for (int i = 0; i < kMaxCpus; i++) {
        g_pcp[i].free_list.init();
        g_pcp[i].count = 0;
    }

    /*
     * 6. Feed all free pages into the buddy system.
     *
     * Pages before frame_map_end (kernel + frame_map) are reserved.
     * We iterate from the first free page to the end of memory,
     * inserting at the highest possible order for efficiency.
     */
    uint64 free_start_pfn = pa_to_frame_index(frame_map_end_pa);
    uint64 end_pfn = g_num_frames;

    uint64 pfn = free_start_pfn;
    while (pfn < end_pfn) {
        // Find the largest order block that is naturally aligned at this PFN
        uint8 order = 0;
        for (int o = kMaxOrder - 1; o >= 0; o--) {
            uint64 block_size = 1ULL << o;
            if ((pfn & (block_size - 1)) == 0 && pfn + block_size <= end_pfn) {
                order = static_cast<uint8>(o);
                break;
            }
        }

        Frame* f = &g_frame_map[pfn];
        f->state = FrameState::Free;
        f->order = order;
        f->refcount.store(0, __ATOMIC_RELAXED);
        f->free.free_link.init();
        buddy_list_add(f, order);

        pfn += (1ULL << order);
    }
}

uint64 pmm_get_mem_base() { return g_mem_base; }
uint64 pmm_get_mem_size() { return g_mem_size; }
