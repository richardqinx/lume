/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: Physical Memory Manager (PMM)
 *
 * Tests:
 *   1. Single page alloc/free round-trip
 *   2. Page address alignment (4KB)
 *   3. No duplicate pages from consecutive allocs
 *   4. Free then re-alloc returns the same page (PCP cache)
 *   5. Multi-page (order > 0) alloc/free
 *   6. Bulk alloc stress test (alloc many, free all)
 *   7. Reference counting (incref/decref)
 *   8. page_to_pa / pa_to_page round-trip
 */

#include <lume/selftest.h>
#include <lume/pmm.h>
#include <lume/addr.h>

void selftest_pmm()
{
    st_begin("pmm: single page alloc/free");
    {
        Page* page = pmm_alloc_page();
        ST_ASSERT(page != nullptr);
        ST_ASSERT(page->state == PageState::Allocated);
        ST_ASSERT(page->order == 0);

        uint64 pa = page_to_pa(page).raw;
        ST_ASSERT_EQ(pa % kPageSize, 0ULL);  // 4KB aligned

        uint64 va = page_to_va(page).raw;
        ST_ASSERT_EQ(va, pa_to_va(phys_addr(pa)).raw);

        pmm_free_page(page);
    }
    st_pass();

    st_begin("pmm: no duplicate pages");
    {
        Page* p1 = pmm_alloc_page();
        Page* p2 = pmm_alloc_page();
        ST_ASSERT(p1 != nullptr);
        ST_ASSERT(p2 != nullptr);
        ST_ASSERT_NE(p1, p2);
        ST_ASSERT_NE(page_to_pa(p1).raw, page_to_pa(p2).raw);
        pmm_free_page(p2);
        pmm_free_page(p1);
    }
    st_pass();

    st_begin("pmm: free then re-alloc (PCP)");
    {
        Page* p1 = pmm_alloc_page();
        uint64 pa1 = page_to_pa(p1).raw;
        pmm_free_page(p1);

        // PCP should return the most recently freed page
        Page* p2 = pmm_alloc_page();
        uint64 pa2 = page_to_pa(p2).raw;
        ST_ASSERT_EQ(pa1, pa2);
        pmm_free_page(p2);
    }
    st_pass();

    st_begin("pmm: multi-page alloc (order 2 = 4 pages)");
    {
        Page* page = pmm_alloc_pages(2);
        ST_ASSERT(page != nullptr);
        ST_ASSERT(page->order == 2);

        uint64 pa = page_to_pa(page).raw;
        ST_ASSERT_EQ(pa % (kPageSize * 4), 0ULL);  // Naturally aligned

        pmm_free_pages(page, 2);
    }
    st_pass();

    st_begin("pmm: bulk alloc/free stress (256 pages)");
    {
        constexpr int N = 256;
        Page* pages[N];

        // Allocate all
        for (int i = 0; i < N; i++) {
            pages[i] = pmm_alloc_page();
            ST_ASSERT(pages[i] != nullptr);
        }

        // Verify no duplicates (spot check: consecutive pairs)
        for (int i = 1; i < N; i++) {
            ST_ASSERT_NE(pages[i], pages[i - 1]);
        }

        // Free all
        for (int i = 0; i < N; i++) {
            pmm_free_page(pages[i]);
        }
    }
    st_pass();

    st_begin("pmm: page_to_pa / pa_to_page round-trip");
    {
        Page* page = pmm_alloc_page();
        ST_ASSERT(page != nullptr);
        uint64 pa = page_to_pa(page).raw;
        Page* page2 = pa_to_page(phys_addr(pa));
        ST_ASSERT_EQ(page, page2);
        pmm_free_page(page);
    }
    st_pass();

    st_begin("pmm: refcount incref/decref");
    {
        Page* page = pmm_alloc_page();
        ST_ASSERT(page != nullptr);
        ST_ASSERT(page->refcount.load() == 1);

        page_incref(page);
        ST_ASSERT(page->refcount.load() == 2);

        page_decref(page);  // 2 -> 1, should NOT free
        ST_ASSERT(page->refcount.load() == 1);
        ST_ASSERT(page->state == PageState::Allocated);

        page_decref(page);  // 1 -> 0, should free to pool
        // After decref to 0, page is returned to pool.
        // We can't safely check page->state because it might be reused.
    }
    st_pass();
    st_begin("pmm: pmm_alloc_pages natural alignment (order-3)");
    {
        Page* page = pmm_alloc_pages(3);
        ST_ASSERT(page != nullptr);
        uint64 pa = page_to_pa(page).raw;
        ST_ASSERT_EQ(pa % (kPageSize * 8), 0ULL);
        pmm_free_pages(page, 3);
    }
    st_pass();

    st_begin("pmm: page_decref to 0 and reuse (order-0)");
    {
        Page* page = pmm_alloc_page();
        uint64 pa = page_to_pa(page).raw;
        page_decref(page); // drops 1 -> 0, freeing it
        
        // Next alloc from PCP should give back the same page
        Page* page2 = pmm_alloc_page();
        ST_ASSERT_EQ(page_to_pa(page2).raw, pa);
        pmm_free_page(page2);
    }
    st_pass();

    st_begin("pmm: page_decref to 0 on multi-page blocks (order-3)");
    {
        Page* page = pmm_alloc_pages(3);
        uint64 pa = page_to_pa(page).raw;
        page_decref(page); // Should internally route to pmm_free_pages(page, 3)
        
        // Re-allocate order-3 and see if we get it back (buddy coalescing was respected)
        Page* page2 = pmm_alloc_pages(3);
        ST_ASSERT_EQ(page_to_pa(page2).raw, pa);
        pmm_free_pages(page2, 3);
    }
    st_pass();

    st_begin("pmm: buddy split and block coalescing correctness");
    {
        // Force split: allocate order-1, free it, allocate two order-0
        Page* page_ord1 = pmm_alloc_pages(1);
        uint64 pa1 = page_to_pa(page_ord1).raw;
        pmm_free_pages(page_ord1, 1);
        
        Page* p0_a = pmm_alloc_page();
        Page* p0_b = pmm_alloc_page();
        
        // Free them to trigger coalesce
        pmm_free_page(p0_a);
        pmm_free_page(p0_b);
        
        // Allocate order-1 again to verify successful coalescing
        Page* page_ord1_again = pmm_alloc_pages(1);
        ST_ASSERT_EQ(page_to_pa(page_ord1_again).raw, pa1);
        pmm_free_pages(page_ord1_again, 1);
    }
    st_pass();

    st_begin("pmm: mixed order cross allocation");
    {
        Page* p0 = pmm_alloc_page();
        Page* p2 = pmm_alloc_pages(2);
        Page* p0b = pmm_alloc_page();
        
        ST_ASSERT(p0 != nullptr);
        ST_ASSERT(p2 != nullptr);
        ST_ASSERT(p0b != nullptr);
        ST_ASSERT_NE(page_to_pa(p0).raw, page_to_pa(p2).raw);
        
        pmm_free_page(p0);
        pmm_free_pages(p2, 2);
        pmm_free_page(p0b);
    }
    st_pass();

    st_begin("pmm: PCP drain/refill boundaries");
    {
        // kPcpHighWatermark = 64. Allocating and freeing 65 blocks triggers drain.
        Page* pages[65];
        for (int i=0; i<65; i++) pages[i] = pmm_alloc_page();
        for (int i=0; i<65; i++) pmm_free_page(pages[i]);
        
        // The system shouldn't crash and PCP logic should handle this.
        Page* verify_page = pmm_alloc_page();
        ST_ASSERT(verify_page != nullptr);
        pmm_free_page(verify_page);
    }
    st_pass();

    st_begin("pmm: OOM exhaustion stability");
    {
        Page* head = nullptr;
        // First allocate large chunks to be fast
        while (true) {
            Page* page = pmm_alloc_pages(5);
            if (!page) break;
            uint64* ptr = reinterpret_cast<uint64*>(page_to_va(page).raw);
            *ptr = reinterpret_cast<uint64>(head);
            // encode order in the second word
            *(ptr + 1) = 5;
            head = page;
        }
        // Then allocate single frames until absolute zero
        while (true) {
            Page* page = pmm_alloc_page();
            if (!page) break;
            uint64* ptr = reinterpret_cast<uint64*>(page_to_va(page).raw);
            *ptr = reinterpret_cast<uint64>(head);
            *(ptr + 1) = 0;
            head = page;
        }
        
        // We hit nullptr. System is completely exhausted.
        ST_ASSERT(pmm_alloc_page() == nullptr);
        
        // Free everything
        while (head) {
            uint64* ptr = reinterpret_cast<uint64*>(page_to_va(head).raw);
            Page* nxt = reinterpret_cast<Page*>(*ptr);
            uint64 order = *(ptr + 1);
            if (order == 5) pmm_free_pages(head, 5);
            else pmm_free_page(head);
            head = nxt;
        }
    }
    st_pass();

    st_begin("pmm: out of bounds order allocation gracefully fails");
    {
        // kMaxOrder is 11, so passing 11 or higher should safely return nullptr.
        Page* page = pmm_alloc_pages(11);
        ST_ASSERT(page == nullptr);
        page = pmm_alloc_pages(255);
        ST_ASSERT(page == nullptr);
    }
    st_pass();

    st_begin("pmm: pmm_get_mem_base / pmm_get_mem_size sanity");
    {
        uint64 base = pmm_get_mem_base().raw;
        uint64 size = pmm_get_mem_size();

        // We no longer assert on QEMU specific memory address
        // ST_ASSERT(base >= 0x80000000ULL);
        ST_ASSERT(size > 0);
        // Size must be page-aligned
        ST_ASSERT_EQ(size % kPageSize, 0ULL);
        // Base must be page-aligned
        ST_ASSERT_EQ(base % kPageSize, 0ULL);
    }
    st_pass();
}
