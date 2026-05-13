/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * pmm.cc — Physical Memory Manager implementation
 *
 * Buddy allocator with Per-CPU single-page caches (PCP).
 *
 * Initialization sequence (called by BSP in single-core period):
 *   1. memblock + vmm_init allocate and map the page_map at VMEMMAP.
 *   2. Zero and mark all Page descriptors reserved by default.
 *   3. Carve free regions from memblock into the buddy system.
 *
 * The page_map is a flat array indexed by physical page frame number (PFN).
 * PFN = (pa - mem_base) / PAGE_SIZE.  This keeps address conversion O(1).
 *
 * Reference: docs/specs/pmm.md
 */

#include <arch/config.h>
#include <arch/cpu.h>
#include <kernel/sync/spinlock.h>
#include <lume/addr.h>
#include <lume/config.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/memblock.h>
#include <lume/new.h>
#include <lume/pmm.h>
#include <lume/types.h>
#include <lume/vmm.h>

/* ------------------------------------------------------------------ */
/*  Per-CPU page cache                                                */
/* ------------------------------------------------------------------ */

struct PerCpuCache {
  list_node free_list; // Single-page free list
  uint32 count;        // Number of cached pages
};

/* ------------------------------------------------------------------ */
/*  Module-private state                                              */
/* ------------------------------------------------------------------ */

static Spinlock g_pmm_lock;
static list_node g_free_areas[kMaxOrder]; // Buddy free lists [0..10]
static PerCpuCache g_pcp[kMaxCpus];

static Page *g_page_map = nullptr; // Flat array of Page descriptors
static uint64 g_page_map_pa = 0;   // Physical base of page_map storage
static uint64 g_page_map_bytes = 0; // Byte size of page_map storage
static uint64 g_mem_base = 0;        // Physical memory base (from FDT)
static uint64 g_mem_size = 0;        // Total physical memory size
static uint64 g_num_pages = 0;       // Total managed pages

uint32 g_pcp_high_watermark = 0;
uint32 g_pcp_batch_size = 0;

/* ------------------------------------------------------------------ */
/*  Address conversion helpers                                        */
/* ------------------------------------------------------------------ */

/*
 * Physical Page Number: index into the page_map array.
 * PFN = (pa - g_mem_base) / kPageSize
 */
static inline uint64 pa_to_page_index(uint64 pa) {
  if (pa < g_mem_base || pa >= g_mem_base + g_num_pages * kPageSize)
    kernel_panic("pa_to_page: physical address outside managed range");
  return (pa - g_mem_base) / kPageSize;
}

static inline uint64 page_index_to_pa(uint64 idx) {
  if (idx >= g_num_pages)
    kernel_panic("page_to_pa: page index outside managed range");
  return g_mem_base + idx * kPageSize;
}

PhysAddr page_to_pa(const Page *page) {
  uintptr base = reinterpret_cast<uintptr>(g_page_map);
  uintptr addr = reinterpret_cast<uintptr>(page);
  uintptr end = base + g_num_pages * sizeof(Page);

  if (addr < base || addr >= end)
    kernel_panic("page_to_pa: page outside page_map bounds");

  uint64 idx = (addr - base) / sizeof(Page);
  return phys_addr(page_index_to_pa(idx));
}

Page *pa_to_page(PhysAddr pa) {
  uint64 idx = pa_to_page_index(pa.raw);
  return &g_page_map[idx];
}

VirtAddr page_to_va(const Page *page) {
  return pa_to_va(page_to_pa(page));
}

/* ------------------------------------------------------------------ */
/*  Buddy system internals (caller must hold g_pmm_lock)              */
/* ------------------------------------------------------------------ */

/*
 * Find a page's buddy at a given order.
 * Buddy PFN = PFN ^ (1 << order).
 */
static inline Page *buddy_of(Page *page, uint8 order) {
  uint64 pfn = static_cast<uint64>(page - g_page_map);
  uint64 buddy_pfn = pfn ^ (1ULL << order);
  if (buddy_pfn >= g_num_pages)
    return nullptr;
  return &g_page_map[buddy_pfn];
}

/*
 * Insert a free block into the buddy free list at the given order.
 */
static void buddy_list_add(Page *page, uint8 order) {
  page->state = PageState::Free;
  page->order = order;
  list_node *head = &g_free_areas[order];
  list_node *node = &page->free.free_link;
  node->next = head->next;
  node->prev = head;
  head->next->prev = node;
  head->next = node;
}

/*
 * Remove a block from whatever buddy free list it is on.
 */
static void buddy_list_del(Page *page) {
  list_node *node = &page->free.free_link;
  node->prev->next = node->next;
  node->next->prev = node->prev;
  node->next = node;
  node->prev = node;
}

/*
 * Allocate a block of 2^order contiguous pages from the buddy system.
 * Splits higher-order blocks if no exact match is available.
 * Returns nullptr if no memory available.
 */
static Page *buddy_alloc(uint8 order) {
  for (int cur = order; cur < kMaxOrder; cur++) {
    list_node *head = &g_free_areas[cur];
    if (head->next == head)
      continue; // Empty at this order

    // Pop the first block from this order's free list
    list_node *node = head->next;
    // Compute Page* from the free_link member offset
    Page *page =
      reinterpret_cast<Page *>(reinterpret_cast<uintptr>(node) -
                    __builtin_offsetof(Page, free.free_link));
    buddy_list_del(page);

    // Split down to the requested order
    while (cur > order) {
      cur--;
      // The upper half becomes a free buddy
      Page *split = &g_page_map[(page - g_page_map) + (1ULL << cur)];
      buddy_list_add(split, static_cast<uint8>(cur));
    }

    page->state = PageState::Allocated;
    page->order = order;
    page->refcount.store(1, __ATOMIC_RELAXED);
    return page;
  }
  return nullptr;
}

/*
 * Return a block of 2^order pages to the buddy system.
 * Coalesces with its buddy recursively up to kMaxOrder-1.
 */
static void buddy_free(Page *page, uint8 order) {
  uint64 pfn = static_cast<uint64>(page - g_page_map);

  while (order < kMaxOrder - 1) {
    Page *buddy = buddy_of(page, order);
    if (!buddy)
      break;
    // Buddy must be free AND at the same order to coalesce
    if (buddy->state != PageState::Free || buddy->order != order)
      break;

    // Remove buddy from its free list and merge
    buddy_list_del(buddy);

    // The merged block starts at the lower PFN
    uint64 buddy_pfn = static_cast<uint64>(buddy - g_page_map);
    if (buddy_pfn < pfn) {
      page = buddy;
      pfn = buddy_pfn;
    }
    order++;
  }

  buddy_list_add(page, order);
}

/* ------------------------------------------------------------------ */
/*  Per-CPU cache operations (interrupts must be disabled by caller)   */
/* ------------------------------------------------------------------ */

/*
 * Refill the PCP from the global buddy system.
 * Acquires g_pmm_lock internally.
 */
static void refill_pcp(PerCpuCache *pcp) {
  LockGuard guard(g_pmm_lock);
  for (uint32 i = 0; i < g_pcp_batch_size; i++) {
    Page *page = buddy_alloc(0);
    if (!page)
      break;
    // Put onto PCP list (reuse the free_link for PCP chain)
    page->state = PageState::PcpCached;
    list_node *node = &page->free.free_link;
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
static void drain_pcp(PerCpuCache *pcp) {
  LockGuard guard(g_pmm_lock);
  int to_drain = pcp->count / 2;
  for (int i = 0; i < to_drain; i++) {
    list_node *head = &pcp->free_list;
    if (head->next == head)
      break;
    list_node *node = head->next;
    // Unlink from PCP
    node->prev->next = node->next;
    node->next->prev = node->prev;
    pcp->count--;

    Page *page =
        reinterpret_cast<Page *>(reinterpret_cast<uintptr>(node) -
                                  __builtin_offsetof(Page, free.free_link));
    buddy_free(page, 0);
  }
}

/* ------------------------------------------------------------------ */
/*  Public API: single-page (fast path via PCP)                       */
/* ------------------------------------------------------------------ */

Page *pmm_alloc_page() {
  /*
   * Disable interrupts to prevent reentry on the same CPU
   * (e.g. timer IRQ handler calling pmm_alloc_page while we
   * are mid-way through manipulating the PCP list).
   */
  bool was_on = arch::cpu::intr_enabled();
  arch::cpu::intr_off();

  uint64 cpu = arch::cpu::id();
  PerCpuCache *pcp = &g_pcp[cpu];

  if (pcp->count == 0)
    refill_pcp(pcp);

  Page *page = nullptr;
  if (pcp->count > 0) {
    list_node *node = pcp->free_list.next;
    // Unlink
    node->prev->next = node->next;
    node->next->prev = node->prev;
    pcp->count--;

    page =
      reinterpret_cast<Page *>(reinterpret_cast<uintptr>(node) -
                    __builtin_offsetof(Page, free.free_link));

    // Validate the page is within the page_map bounds
    if (page < g_page_map || page >= g_page_map + g_num_pages) {
      kernel_panic("pmm_alloc_page: PCP returned out-of-bounds page");
    }

    page->state = PageState::Allocated;
    page->order = 0;
    page->refcount.store(1, __ATOMIC_RELAXED);
  }

  if (was_on)
    arch::cpu::intr_on();
  return page;
}

void pmm_free_page(Page *page) {
  if (!page)
    kernel_panic("pmm_free_page: null page");

  bool was_on = arch::cpu::intr_enabled();
  arch::cpu::intr_off();

  uint64 cpu = arch::cpu::id();
  PerCpuCache *pcp = &g_pcp[cpu];

  // Push onto PCP
  page->state = PageState::PcpCached;
  page->order = 0;
  list_node *node = &page->free.free_link;
  node->next = pcp->free_list.next;
  node->prev = &pcp->free_list;
  pcp->free_list.next->prev = node;
  pcp->free_list.next = node;
  pcp->count++;

  // Drain if over high watermark
  if (pcp->count >= g_pcp_high_watermark)
    drain_pcp(pcp);

  if (was_on)
    arch::cpu::intr_on();
}

/* ------------------------------------------------------------------ */
/*  Public API: multi-page (slow path, direct buddy)                  */
/* ------------------------------------------------------------------ */

Page *pmm_alloc_pages(uint8 order) {
  if (order >= kMaxOrder)
    return nullptr;
  LockGuard guard(g_pmm_lock);
  return buddy_alloc(order);
}

void pmm_free_pages(Page *page, uint8 order) {
  if (!page)
    kernel_panic("pmm_free_pages: null page");
  if (order >= kMaxOrder)
    kernel_panic("pmm_free_pages: order out of range");
  LockGuard guard(g_pmm_lock);
  buddy_free(page, order);
}

/* ------------------------------------------------------------------ */
/*  Public API: reference counting                                    */
/* ------------------------------------------------------------------ */

void page_incref(Page *page) { page->refcount.fetch_add(1); }

void page_decref(Page *page) {
  uint32 old = page->refcount.fetch_sub(1);
  if (old == 1) {
    // Refcount dropped to 0 — return to pool based on originally allocated
    // order
    if (page->order == 0)
      pmm_free_page(page);
    else
      pmm_free_pages(page, page->order);
  }
}

/* ------------------------------------------------------------------ */
/*  Initialization                                                    */
/* ------------------------------------------------------------------ */

/*
 * Helper: zero out a range of bytes.  We cannot use memset here
 * because lib/string may not be linked yet.
 */
static void zero_range(void *start, uint64 bytes) {
  uint8 *p = static_cast<uint8 *>(start);
  for (uint64 i = 0; i < bytes; i++)
    p[i] = 0;
}

void pmm_init() {
  /* 1. Get memory layout from memblock (already scanned FDT) */
  g_mem_base = memblock_get_mem_base();
  g_mem_size = memblock_get_mem_size();
  g_num_pages = vmm_get_num_pages();

  if (g_mem_size == 0) {
    kernel_panic("pmm_init: memblock reports zero memory");
  }

  /* 2. PCP parameters */
  uint32 calc_batch = static_cast<uint32>(g_num_pages / (kMaxCpus * 1024));
  g_pcp_batch_size = (calc_batch > 16) ? calc_batch : 16;
  g_pcp_high_watermark = g_pcp_batch_size * 2;

  /* 3. page_map was allocated by vmm_init at vmemmap VA.
   *    No relocation needed — page_map starts life at the right VA. */
  g_page_map_pa = vmm_get_page_map_pa();
  g_page_map_bytes = vmm_get_page_map_size();
  g_page_map = reinterpret_cast<Page *>(arch::g_vmemmap_base);

  /* 4. Zero out the entire page_map */
  zero_range(g_page_map, g_page_map_bytes);

  /* 4b. Default every page descriptor to reserved/non-free. */
  for (uint64 i = 0; i < g_num_pages; i++) {
    Page *page = &g_page_map[i];
    page->refcount.store(0, __ATOMIC_RELAXED);
    page->state = PageState::Allocated;
    page->order = 0;
    page->free.free_link.init();
  }

  /* 5. Initialize buddy free list heads */
  g_pmm_lock.init("pmm");
  for (int i = 0; i < kMaxOrder; i++) {
    g_free_areas[i].init();
  }

  /* 6. Initialize PCP list heads */
  for (int i = 0; i < kMaxCpus; i++) {
    g_pcp[i].free_list.init();
    g_pcp[i].count = 0;
  }

  /* 7. Feed free regions from memblock into the buddy system.
   *    memblock knows about all reserved regions (firmware, kernel,
  *    page table pages, page_map). Everything else is free. */
  struct FeedCtx {
    uint64 total_pages;
  };
  FeedCtx ctx{0};

  memblock_for_each_free(
      [](uint64 base, uint64 size, void *arg) {
        auto *c = static_cast<FeedCtx *>(arg);
        uint64 start_pfn = (base - memblock_get_mem_base()) / kPageSize;
        uint64 end_pfn = start_pfn + size / kPageSize;

        /* Access page_map via the extern g_page_map (already at vmemmap VA) */
        extern Page *g_page_map;
        extern list_node g_free_areas[];

        uint64 pfn = start_pfn;
        while (pfn < end_pfn) {
          uint8 order = 0;
          for (int o = kMaxOrder - 1; o >= 0; o--) {
            uint64 block_size = 1ULL << o;
            if ((pfn & (block_size - 1)) == 0 && pfn + block_size <= end_pfn) {
              order = static_cast<uint8>(o);
              break;
            }
          }

          Page *page = &g_page_map[pfn];
          page->state = PageState::Free;
          page->order = order;
          page->refcount.store(0, __ATOMIC_RELAXED);
          page->free.free_link.init();

          /* Inline buddy_list_add since we're inside a lambda */
          list_node *head = &g_free_areas[order];
          list_node *node = &page->free.free_link;
          node->next = head->next;
          node->prev = head;
          head->next->prev = node;
          head->next = node;

          pfn += (1ULL << order);
          c->total_pages += (1ULL << order);
        }
      },
      &ctx);

  kprintf("[pmm] buddy: %llu free pages (%llu MB)\n", ctx.total_pages,
          (ctx.total_pages * kPageSize) / (1024 * 1024));

  /* 8. Retire memblock — all future allocations go through PMM */
  memblock_retire();
}

PhysAddr pmm_get_mem_base() { return phys_addr(g_mem_base); }
uint64 pmm_get_mem_size() { return g_mem_size; }
