/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * vmm.cc — Virtual Memory Manager (Phase 1: Kernel Page Table)
 *
 * Builds a fine-grained kernel page table, activates it, and retires
 * the early_pgdir identity mapping from entry.S.
 *
 * With memblock integration, the initialization order is:
 *   memblock_init → vmm_init (allocates page_map from memblock,
 *   maps vmemmap, activates page table) → pmm_init (buddy system
 *   starts with page_map already at vmemmap VA — no relocation).
 *
 * Reference: docs/specs/vmm.md
 */

#include <arch/config.h>
#include <arch/mmu.h>
#include <arch/pmap.h>
#include <lume/addr.h>
#include <lume/console.h>
#include <lume/fdt.h>
#include <lume/page.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/memblock.h>
#include <lume/pmm.h>
#include <lume/types.h>
#include <lume/vmm.h>

/* Linker-exported section boundaries (virtual addresses) */
extern "C" char _stext[], _etext[];
extern "C" char _srodata[], _erodata[];
extern "C" char _sdata[], _edata[];
extern "C" char _sbss[], _ebss[];
extern "C" char _kernel_end[];

/* Global kernel page table root PA */
static uint64 g_kernel_pgtbl = 0;

/* VMM exports for PMM: page_map location after vmemmap mapping. */
static uint64 g_vmemmap_page_map_pa = 0;
static uint64 g_vmemmap_page_map_size = 0;
static uint64 g_vmemmap_num_pages = 0;

uint64 vmm_get_page_map_pa() { return g_vmemmap_page_map_pa; }
uint64 vmm_get_page_map_size() { return g_vmemmap_page_map_size; }
uint64 vmm_get_num_pages() { return g_vmemmap_num_pages; }

/* Convert a linker symbol to PA (kernel is executing in higher-half VA). */
static inline uint64 sym_to_pa(const void *sym) {
  return boot_va_to_pa(virt_addr(reinterpret_cast<uint64>(sym))).raw;
}

/* Map a PA range into the kernel page table via the direct map. */
static void map_range(uint64 root, uint64 pa_start, uint64 pa_end,
                      uint64 perm) {
  for (uint64 pa = pa_start; pa < pa_end; pa += kPageSize) {
    uint64 va = pa_to_va(phys_addr(pa)).raw;
    int ret = pmap::map(root, va, pa, perm | pmap::PTE_G);
    if (ret != 0) {
      kernel_panic("vmm_init: pmap::map failed");
    }
  }
}

/* Map a PA range into the kernel page table at the fixed linked VA. */
static void map_range_linked(uint64 root, uint64 pa_start, uint64 pa_end,
                             uint64 perm) {
  for (uint64 pa = pa_start; pa < pa_end; pa += kPageSize) {
    uint64 va = boot_pa_to_va(phys_addr(pa)).raw;
    int ret = pmap::map(root, va, pa, perm | pmap::PTE_G);
    if (ret != 0) {
      kernel_panic("vmm_init: pmap::map (linked) failed");
    }
  }
}

/* Map a PA range to an explicit VA base, using 2MB pages where possible. */
static void map_range_at_huge(uint64 root, uint64 va_base, uint64 pa_start,
                              uint64 pa_end, uint64 perm) {
  constexpr uint64 k2MB = 2ULL * 1024 * 1024;
  uint64 pa = pa_start;
  uint64 va = va_base;

  /* Map 2MB-aligned chunks with mega pages */
  while (pa + k2MB <= pa_end) {
    if ((va & (k2MB - 1)) == 0 && (pa & (k2MB - 1)) == 0) {
      int ret = pmap::map_2mb(root, va, pa, perm | pmap::PTE_G);
      if (ret != 0) {
        kernel_panic("vmm_init: pmap::map_2mb failed");
      }
      pa += k2MB;
      va += k2MB;
    } else {
      break;
    }
  }

  /* Map remaining 4KB tail */
  while (pa < pa_end) {
    int ret = pmap::map(root, va, pa, perm | pmap::PTE_G);
    if (ret != 0) {
      kernel_panic("vmm_init: vmemmap 4KB pmap::map failed");
    }
    pa += kPageSize;
    va += kPageSize;
  }
}

void vmm_init() {
  /* 1. Allocate new root page table (from memblock) */
  uint64 root = pmap::create();
  if (!root) {
    kernel_panic("vmm_init: failed to create root page table");
  }

  /* 2. Compute PA boundaries of each kernel section */
  uint64 text_start = page_align_down(sym_to_pa(_stext));
  uint64 text_end = page_align_up(sym_to_pa(_etext));
  uint64 ro_start = page_align_down(sym_to_pa(_srodata));
  uint64 ro_end = page_align_up(sym_to_pa(_erodata));
  uint64 data_start = page_align_down(sym_to_pa(_sdata));
  uint64 bss_end = page_align_up(sym_to_pa(_ebss));

  /* Memory extent from memblock */
  uint64 mem_base = memblock_get_mem_base();
  uint64 mem_size = memblock_get_mem_size();
  uint64 mem_end = mem_base + mem_size;

  /* 3. Map kernel image at FIXED linked VA.
   *
   * Kernel text/data are linked at the bootstrap higher-half addresses
   * (kDirectMapBaseDefault + PA). They must remain executable/readable at
   * those addresses until full kernel-image relocation is implemented.
   */
  map_range_linked(root, text_start, text_end, pmap::PTE_R | pmap::PTE_X);

  /* 4. Map .rodata (R) at fixed linked VA */
  map_range_linked(root, ro_start, ro_end, pmap::PTE_R);

  /* 5. Map .data + .bss (RW) at fixed linked VA */
  map_range_linked(root, data_start, bss_end, pmap::PTE_R | pmap::PTE_W);

  /* 6. Map remaining physical memory after kernel (RW) */
  uint64 after_kernel = page_align_up(sym_to_pa(_kernel_end));
  if (after_kernel < mem_end) {
    map_range(root, after_kernel, mem_end, pmap::PTE_R | pmap::PTE_W);
  }

  /* 7. Allocate page_map from memblock (top of RAM) and map at VMEMMAP.
   *
   * Since memblock is active (PMM not yet initialized), pmap::map
   * allocates page table pages from memblock too. page_map starts
   * life at the vmemmap VA — no relocation ever needed.
   */
  uint64 num_pages = mem_size / kPageSize;
  uint64 page_map_bytes = num_pages * sizeof(Page);
  uint64 page_map_span = page_align_up(page_map_bytes);
  uint64 page_map_pa = memblock_alloc_top(page_map_span, kPageSize);

  if (!page_map_pa) {
    kernel_panic("vmm_init: memblock failed to allocate page_map");
  }

  kprintf("[vmm] vmemmap: %llu pages, %llu KB at PA 0x%llx\n", num_pages,
          page_map_span / 1024, page_map_pa);

  /* Map page_map at vmemmap_base from KaslrLayout (randomised by KASLR), using 2MB pages where possible */
  map_range_at_huge(root, arch::kaslr_layout_get().vmemmap_base, page_map_pa,
                    page_map_pa + page_map_span, pmap::PTE_R | pmap::PTE_W);

  /* Export for pmm_init() */
  g_vmemmap_page_map_pa = page_map_pa;
  g_vmemmap_page_map_size = page_map_bytes;
  g_vmemmap_num_pages = num_pages;

  /* 8. Pre-map console MMIO before page table switch */
  g_kernel_pgtbl = root;
  console_init();

  /* 9. Activate the new page table */
  pmap::activate(root);

  /* Console MMIO access must now use runtime (KASLR) direct-map base. */
  console_use_runtime_mapping();

  kprintf("[vmm] vmm_init complete (vmemmap at 0x%llx)\n", arch::kaslr_layout_get().vmemmap_base);
}

void vmm_init_ap() {
  if (!g_kernel_pgtbl) {
    kernel_panic("vmm_init_ap: kernel page table not ready");
  }
  pmap::activate(g_kernel_pgtbl);
}

void vmm_map_kernel_mmio(uint64 pa, uint64 size) {
  if (!g_kernel_pgtbl) {
    kernel_panic("vmm_map_kernel_mmio: kernel page table not ready");
  }

  uint64 aligned_pa = page_align_down(pa);
  uint64 aligned_size = page_align_up(pa + size) - aligned_pa;

  map_range(g_kernel_pgtbl, aligned_pa, aligned_pa + aligned_size,
            pmap::PTE_R | pmap::PTE_W | pmap::PTE_G);
  arch::mmu::flush_tlb_all();
}
