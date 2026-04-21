/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: Physical Memory Manager (PMM)
 *
 * Tests:
 *   1. Single frame alloc/free round-trip
 *   2. Frame address alignment (4KB)
 *   3. No duplicate frames from consecutive allocs
 *   4. Free then re-alloc returns the same frame (PCP cache)
 *   5. Multi-frame (order > 0) alloc/free
 *   6. Bulk alloc stress test (alloc many, free all)
 *   7. Reference counting (incref/decref)
 *   8. frame_to_pa / pa_to_frame round-trip
 */

#include <lume/selftest.h>
#include <lume/pmm.h>
#include <lume/addr.h>

void selftest_pmm()
{
    st_begin("pmm: single frame alloc/free");
    {
        Frame* f = pmm_alloc_frame();
        ST_ASSERT(f != nullptr);
        ST_ASSERT(f->state == FrameState::Allocated);
        ST_ASSERT(f->order == 0);

        uint64 pa = frame_to_pa(f);
        ST_ASSERT_EQ(pa % kPageSize, 0ULL);  // 4KB aligned

        uint64 va = frame_to_va(f);
        ST_ASSERT_EQ(va, pa_to_va(pa));

        pmm_free_frame(f);
    }
    st_pass();

    st_begin("pmm: no duplicate frames");
    {
        Frame* f1 = pmm_alloc_frame();
        Frame* f2 = pmm_alloc_frame();
        ST_ASSERT(f1 != nullptr);
        ST_ASSERT(f2 != nullptr);
        ST_ASSERT_NE(f1, f2);
        ST_ASSERT_NE(frame_to_pa(f1), frame_to_pa(f2));
        pmm_free_frame(f2);
        pmm_free_frame(f1);
    }
    st_pass();

    st_begin("pmm: free then re-alloc (PCP)");
    {
        Frame* f1 = pmm_alloc_frame();
        uint64 pa1 = frame_to_pa(f1);
        pmm_free_frame(f1);

        // PCP should return the most recently freed frame
        Frame* f2 = pmm_alloc_frame();
        uint64 pa2 = frame_to_pa(f2);
        ST_ASSERT_EQ(pa1, pa2);
        pmm_free_frame(f2);
    }
    st_pass();

    st_begin("pmm: multi-frame alloc (order 2 = 4 pages)");
    {
        Frame* f = pmm_alloc_frames(2);
        ST_ASSERT(f != nullptr);
        ST_ASSERT(f->order == 2);

        uint64 pa = frame_to_pa(f);
        ST_ASSERT_EQ(pa % (kPageSize * 4), 0ULL);  // Naturally aligned

        pmm_free_frames(f, 2);
    }
    st_pass();

    st_begin("pmm: bulk alloc/free stress (256 frames)");
    {
        constexpr int N = 256;
        Frame* frames[N];

        // Allocate all
        for (int i = 0; i < N; i++) {
            frames[i] = pmm_alloc_frame();
            ST_ASSERT(frames[i] != nullptr);
        }

        // Verify no duplicates (spot check: consecutive pairs)
        for (int i = 1; i < N; i++) {
            ST_ASSERT_NE(frames[i], frames[i - 1]);
        }

        // Free all
        for (int i = 0; i < N; i++) {
            pmm_free_frame(frames[i]);
        }
    }
    st_pass();

    st_begin("pmm: frame_to_pa / pa_to_frame round-trip");
    {
        Frame* f = pmm_alloc_frame();
        ST_ASSERT(f != nullptr);
        uint64 pa = frame_to_pa(f);
        Frame* f2 = pa_to_frame(pa);
        ST_ASSERT_EQ(f, f2);
        pmm_free_frame(f);
    }
    st_pass();

    st_begin("pmm: refcount incref/decref");
    {
        Frame* f = pmm_alloc_frame();
        ST_ASSERT(f != nullptr);
        ST_ASSERT(f->refcount.load() == 1);

        frame_incref(f);
        ST_ASSERT(f->refcount.load() == 2);

        frame_decref(f);  // 2 -> 1, should NOT free
        ST_ASSERT(f->refcount.load() == 1);
        ST_ASSERT(f->state == FrameState::Allocated);

        frame_decref(f);  // 1 -> 0, should free to pool
        // After decref to 0, frame is returned to pool.
        // We can't safely check f->state because it might be reused.
    }
    st_pass();
    st_begin("pmm: pmm_alloc_frames natural alignment (order-3)");
    {
        Frame* f = pmm_alloc_frames(3);
        ST_ASSERT(f != nullptr);
        uint64 pa = frame_to_pa(f);
        ST_ASSERT_EQ(pa % (kPageSize * 8), 0ULL);
        pmm_free_frames(f, 3);
    }
    st_pass();

    st_begin("pmm: frame_decref to 0 and reuse (order-0)");
    {
        Frame* f = pmm_alloc_frame();
        uint64 pa = frame_to_pa(f);
        frame_decref(f); // drops 1 -> 0, freeing it
        
        // Next alloc from PCP should give back the same frame
        Frame* f2 = pmm_alloc_frame();
        ST_ASSERT_EQ(frame_to_pa(f2), pa);
        pmm_free_frame(f2);
    }
    st_pass();

    st_begin("pmm: frame_decref to 0 on multi-page blocks (order-3)");
    {
        Frame* f = pmm_alloc_frames(3);
        uint64 pa = frame_to_pa(f);
        frame_decref(f); // Should internally route to pmm_free_frames(f, 3)
        
        // Re-allocate order-3 and see if we get it back (buddy coalescing was respected)
        Frame* f2 = pmm_alloc_frames(3);
        ST_ASSERT_EQ(frame_to_pa(f2), pa);
        pmm_free_frames(f2, 3);
    }
    st_pass();

    st_begin("pmm: buddy split and block coalescing correctness");
    {
        // Force split: allocate order-1, free it, allocate two order-0
        Frame* f_ord1 = pmm_alloc_frames(1);
        uint64 pa1 = frame_to_pa(f_ord1);
        pmm_free_frames(f_ord1, 1);
        
        Frame* f0_a = pmm_alloc_frame();
        Frame* f0_b = pmm_alloc_frame();
        
        // Free them to trigger coalesce
        pmm_free_frame(f0_a);
        pmm_free_frame(f0_b);
        
        // Allocate order-1 again to verify successful coalescing
        Frame* f_ord1_again = pmm_alloc_frames(1);
        ST_ASSERT_EQ(frame_to_pa(f_ord1_again), pa1);
        pmm_free_frames(f_ord1_again, 1);
    }
    st_pass();

    st_begin("pmm: mixed order cross allocation");
    {
        Frame* f0 = pmm_alloc_frame();
        Frame* f2 = pmm_alloc_frames(2);
        Frame* f0b = pmm_alloc_frame();
        
        ST_ASSERT(f0 != nullptr);
        ST_ASSERT(f2 != nullptr);
        ST_ASSERT(f0b != nullptr);
        ST_ASSERT_NE(frame_to_pa(f0), frame_to_pa(f2));
        
        pmm_free_frame(f0);
        pmm_free_frames(f2, 2);
        pmm_free_frame(f0b);
    }
    st_pass();

    st_begin("pmm: PCP drain/refill boundaries");
    {
        // kPcpHighWatermark = 64. Allocating and freeing 65 blocks triggers drain.
        Frame* frames[65];
        for (int i=0; i<65; i++) frames[i] = pmm_alloc_frame();
        for (int i=0; i<65; i++) pmm_free_frame(frames[i]);
        
        // The system shouldn't crash and PCP logic should handle this.
        Frame* verify_f = pmm_alloc_frame();
        ST_ASSERT(verify_f != nullptr);
        pmm_free_frame(verify_f);
    }
    st_pass();

    st_begin("pmm: OOM exhaustion stability");
    {
        Frame* head = nullptr;
        // First allocate large chunks to be fast
        while (true) {
            Frame* f = pmm_alloc_frames(5);
            if (!f) break;
            uint64* ptr = reinterpret_cast<uint64*>(frame_to_va(f));
            *ptr = reinterpret_cast<uint64>(head);
            // encode order in the second word
            *(ptr + 1) = 5;
            head = f;
        }
        // Then allocate single frames until absolute zero
        while (true) {
            Frame* f = pmm_alloc_frame();
            if (!f) break;
            uint64* ptr = reinterpret_cast<uint64*>(frame_to_va(f));
            *ptr = reinterpret_cast<uint64>(head);
            *(ptr + 1) = 0;
            head = f;
        }
        
        // We hit nullptr. System is completely exhausted.
        ST_ASSERT(pmm_alloc_frame() == nullptr);
        
        // Free everything
        while (head) {
            uint64* ptr = reinterpret_cast<uint64*>(frame_to_va(head));
            Frame* nxt = reinterpret_cast<Frame*>(*ptr);
            uint64 order = *(ptr + 1);
            if (order == 5) pmm_free_frames(head, 5);
            else pmm_free_frame(head);
            head = nxt;
        }
    }
    st_pass();

    st_begin("pmm: out of bounds order allocation gracefully fails");
    {
        // kMaxOrder is 11, so passing 11 or higher should safely return nullptr.
        Frame* f = pmm_alloc_frames(11);
        ST_ASSERT(f == nullptr);
        f = pmm_alloc_frames(255);
        ST_ASSERT(f == nullptr);
    }
    st_pass();

    st_begin("pmm: pmm_get_mem_base / pmm_get_mem_size sanity");
    {
        uint64 base = pmm_get_mem_base();
        uint64 size = pmm_get_mem_size();

        // QEMU virt platform: RAM starts at 0x80000000
        ST_ASSERT(base >= 0x80000000ULL);
        ST_ASSERT(size > 0);
        // Size must be page-aligned
        ST_ASSERT_EQ(size % kPageSize, 0ULL);
        // Base must be page-aligned
        ST_ASSERT_EQ(base % kPageSize, 0ULL);
    }
    st_pass();
}
