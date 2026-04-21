/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * vmm.cc — Virtual Memory Manager (Phase 1: Kernel Page Table)
 *
 * Builds a fine-grained kernel page table (4KB pages, precise
 * permissions per section), activates it, and retires the early_pgdir
 * identity mapping from entry.S.
 *
 * This module is machine-independent (MI).  All architecture-specific
 * page table manipulation goes through the pmap:: namespace.
 *
 * Reference: docs/specs/vmm.md
 */

#include <lume/types.h>
#include <lume/addr.h>
#include <lume/pmm.h>
#include <lume/panic.h>
#include <lume/fdt.h>
#include <lume/vmm.h>
#include <arch/pmap.h>
#include <arch/mmu.h>

/* Linker-exported section boundaries (virtual addresses) */
extern "C" char _stext[], _etext[];
extern "C" char _srodata[], _erodata[];
extern "C" char _sdata[], _edata[];
extern "C" char _sbss[], _ebss[];
extern "C" char _kernel_end[];

/* Global kernel page table root PA */
static uint64 g_kernel_pgtbl = 0;

/* Convert a linker symbol to PA. Handles both VA and PA cases. */
static inline uint64 sym_to_pa(const void *sym)
{
    return ensure_pa(reinterpret_cast<uint64>(sym));
}

/* Map a PA range into the kernel page table with given permissions.
 * All addresses must be page-aligned. Panics on failure. */
static void map_range(uint64 root, uint64 pa_start, uint64 pa_end, uint64 perm)
{
    for (uint64 pa = pa_start; pa < pa_end; pa += kPageSize) {
        uint64 va = pa_to_va(pa);
        int ret = pmap::map(root, va, pa, perm | pmap::PTE_G);
        if (ret != 0)
            kernel_panic("vmm_init: pmap::map failed");
    }
}



void vmm_init()
{
    /* 1. Allocate new root page table */
    uint64 root = pmap::create();
    if (!root)
        kernel_panic("vmm_init: failed to create root page table");

    /* 2. Compute PA boundaries of each kernel section */
    uint64 text_start  = page_align_down(sym_to_pa(_stext));
    uint64 text_end    = page_align_up(sym_to_pa(_etext));
    uint64 ro_start    = page_align_down(sym_to_pa(_srodata));
    uint64 ro_end      = page_align_up(sym_to_pa(_erodata));
    uint64 data_start  = page_align_down(sym_to_pa(_sdata));
    uint64 bss_end     = page_align_up(sym_to_pa(_ebss));

    /* Memory extent from PMM */
    uint64 mem_base = pmm_get_mem_base();
    uint64 mem_end  = mem_base + pmm_get_mem_size();

    /* 3. Map kernel .text (RX) */
    map_range(root, text_start, text_end,
              pmap::PTE_R | pmap::PTE_X);

    /* 4. Map .rodata (R) */
    map_range(root, ro_start, ro_end,
              pmap::PTE_R);

    /* 5. Map .data + .bss (RW) */
    map_range(root, data_start, bss_end,
              pmap::PTE_R | pmap::PTE_W);

    /* 6. Map remaining physical memory after kernel (RW)
     * This covers frame_map, slab objects, and all free pages. */
    uint64 after_kernel = page_align_up(sym_to_pa(_kernel_end));
    if (after_kernel < mem_end) {
        map_range(root, after_kernel, mem_end,
                  pmap::PTE_R | pmap::PTE_W);
    }
    /* 7. MMIO regions will be mapped later via vmm_map_kernel_mmio by architecture/drivers */

    /* 8. Activate the new page table */
    pmap::activate(root);

    g_kernel_pgtbl = root;
}

void vmm_init_ap()
{
    /* AP just switches to the kernel page table built by BSP */
    if (!g_kernel_pgtbl)
        kernel_panic("vmm_init_ap: kernel page table not ready");
    pmap::activate(g_kernel_pgtbl);
}

void vmm_map_kernel_mmio(uint64 pa, uint64 size)
{
    if (!g_kernel_pgtbl)
        kernel_panic("vmm_map_kernel_mmio: kernel page table not ready");
    
    uint64 aligned_pa = page_align_down(pa);
    uint64 aligned_size = page_align_up(pa + size) - aligned_pa;
    
    map_range(g_kernel_pgtbl, aligned_pa, aligned_pa + aligned_size,
              pmap::PTE_R | pmap::PTE_W | pmap::PTE_G);
    arch::mmu::flush_tlb_all();
}



