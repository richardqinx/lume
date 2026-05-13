/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * memblock.cc — Boot-time physical memory allocator
 *
 * Simple region tracker: one memory region (from FDT) plus an array
 * of reserved regions.  Allocation searches for gaps between reserved
 * regions.  All operations are O(n_reserved), which is fine for the
 * ~20 allocations that happen during early boot.
 *
 * Reference: inspired by Linux kernel's mm/memblock.c
 */

#include <lume/memblock.h>
#include <lume/fdt.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/addr.h>

extern "C" char _stext[], _kernel_end[];

/* ------------------------------------------------------------------ */
/*  Module state                                                       */
/* ------------------------------------------------------------------ */

static struct {
    uint64 mem_base;
    uint64 mem_size;

    struct {
        uint64 base;
        uint64 size;
    } reserved[kMemblockMaxRegions];
    int    reserved_count;
    bool   active;
} g_mb;

/* ------------------------------------------------------------------ */
/*  Internal helpers                                                    */
/* ------------------------------------------------------------------ */

/* Insert a reserved region, keeping the array sorted by base. */
static void insert_reserved(uint64 base, uint64 size)
{
    if (g_mb.reserved_count >= kMemblockMaxRegions) {
        kernel_panic("memblock: too many reserved regions");
    }

    int i = g_mb.reserved_count;
    while (i > 0 && g_mb.reserved[i - 1].base > base) {
        g_mb.reserved[i] = g_mb.reserved[i - 1];
        i--;
    }
    g_mb.reserved[i] = {base, size};
    g_mb.reserved_count++;
}

/* Check if [base, base+size) overlaps any reserved region. */
static bool overlaps_reserved(uint64 base, uint64 size)
{
    uint64 end = base + size;
    for (int i = 0; i < g_mb.reserved_count; i++) {
        uint64 rb = g_mb.reserved[i].base;
        uint64 re = rb + g_mb.reserved[i].size;
        if (base < re && end > rb) {
            return true;
        }
    }
    return false;
}

/* Find the end of the first reserved region that covers `addr`. */
static uint64 reserved_end_covering(uint64 addr)
{
    for (int i = 0; i < g_mb.reserved_count; i++) {
        uint64 rb = g_mb.reserved[i].base;
        uint64 re = rb + g_mb.reserved[i].size;
        if (addr >= rb && addr < re) {
            return re;
        }
    }
    return addr;
}

/* ------------------------------------------------------------------ */
/*  Public API                                                         */
/* ------------------------------------------------------------------ */

void memblock_init(uint64 fdt_paddr)
{
    (void)fdt_paddr;

    /* 1. Get memory layout from FDT */
    uint64 mem_base = 0;
    uint64 mem_size = 0;
    fdt_early_get_mem_info(&mem_base, &mem_size);
    if (mem_size == 0) {
        kernel_panic("memblock_init: FDT reports zero memory");
    }

    g_mb.mem_base = mem_base;
    g_mb.mem_size = mem_size;
    g_mb.reserved_count = 0;
    g_mb.active = true;

    /* 2. Reserve firmware region [mem_base, kernel_start).
     *    OpenSBI occupies the first 2MB of RAM on RISC-V virt. */
    uint64 ks_pa = boot_va_to_pa(virt_addr(
        reinterpret_cast<uint64>(_stext))).raw;
    if (ks_pa > mem_base) {
        memblock_reserve(mem_base, ks_pa - mem_base);
    }

    /* 3. Reserve kernel image [_stext, _kernel_end) */
    uint64 ke_pa = boot_va_to_pa(virt_addr(
        reinterpret_cast<uint64>(_kernel_end))).raw;
    memblock_reserve(ks_pa, ke_pa - ks_pa);

    kprintf("[memblock] RAM [0x%llx, 0x%llx) = %llu MB\n",
            mem_base, mem_base + mem_size, mem_size / (1024 * 1024));
    kprintf("[memblock] kernel reserved [0x%llx, 0x%llx)\n", ks_pa, ke_pa);
}

void memblock_reserve(uint64 base, uint64 size)
{
    uint64 aligned_base = page_align_down(base);
    uint64 aligned_end  = page_align_up(base + size);
    insert_reserved(aligned_base, aligned_end - aligned_base);
}

uint64 memblock_alloc_top(uint64 size, uint64 align)
{
    uint64 mem_end = g_mb.mem_base + g_mb.mem_size;

    /* Search from top of RAM downward */
    uint64 end   = page_align_down(mem_end);
    uint64 start = (end - size) & ~(align - 1);

    while (start >= g_mb.mem_base && start + size <= mem_end) {
        if (!overlaps_reserved(start, size)) {
            memblock_reserve(start, size);
            return start;
        }
        if (start < align) {
            break;
        }
        start -= align;
    }

    kernel_panic("memblock_alloc_top: out of memory");
    return 0;
}

uint64 memblock_alloc(uint64 size, uint64 align)
{
    uint64 mem_end = g_mb.mem_base + g_mb.mem_size;
    uint64 start   = page_align_up(g_mb.mem_base);

    while (start + size <= mem_end) {
        start = (start + align - 1) & ~(align - 1);
        if (start + size > mem_end) {
            break;
        }

        if (!overlaps_reserved(start, size)) {
            memblock_reserve(start, size);
            return start;
        }

        /* Skip past the overlapping reserved region */
        uint64 skip = reserved_end_covering(start);
        if (skip <= start) {
            start += align;
        } else {
            start = skip;
        }
    }

    kernel_panic("memblock_alloc: out of memory");
    return 0;
}

uint64 memblock_get_mem_base() { return g_mb.mem_base; }
uint64 memblock_get_mem_size() { return g_mb.mem_size; }

bool memblock_is_active() { return g_mb.active; }
void memblock_retire()    { g_mb.active = false; }

void memblock_for_each_free(void (*cb)(uint64 base, uint64 size, void* ctx),
                            void* ctx)
{
    uint64 pos     = g_mb.mem_base;
    uint64 mem_end = g_mb.mem_base + g_mb.mem_size;

    for (int i = 0; i < g_mb.reserved_count && pos < mem_end; i++) {
        uint64 rb = g_mb.reserved[i].base;
        if (rb < pos) {
            /* Overlapping/adjacent — skip */
            uint64 re = g_mb.reserved[i].base + g_mb.reserved[i].size;
            if (re > pos) {
                pos = re;
            }
            continue;
        }
        if (rb > pos) {
            /* Free gap [pos, rb) */
            cb(pos, rb - pos, ctx);
        }
        pos = g_mb.reserved[i].base + g_mb.reserved[i].size;
    }

    /* Trailing free region after last reserved */
    if (pos < mem_end) {
        cb(pos, mem_end - pos, ctx);
    }
}
