/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: Slab Allocator (kmalloc/kfree)
 *
 * Tests:
 *   1. Small allocation (8 bytes) and free
 *   2. Multiple size classes
 *   3. No aliasing between consecutive allocs
 *   4. Alignment check (minimum 8-byte aligned)
 *   5. Bulk alloc/free stress
 *   6. operator new / operator delete
 *   7. Large allocation (> 2048, falls back to PMM)
 *   8. Zero-size and null-free edge cases
 */

#include <lume/selftest.h>
#include <lume/new.h>
#include <lume/pmm.h>
#include <lume/addr.h>

/* Forward declarations — defined in slab.cc */
void* kmalloc(uint32 size);
void kfree(void* ptr);

void selftest_slab()
{
    st_begin("slab: small alloc (8 bytes)");
    {
        void* p = kmalloc(8);
        ST_ASSERT(p != nullptr);
        // Write and read back to verify the memory is usable
        *static_cast<uint64*>(p) = 0xDEADBEEFCAFEBABEULL;
        ST_ASSERT_EQ(*static_cast<uint64*>(p), 0xDEADBEEFCAFEBABEULL);
        kfree(p);
    }
    st_pass();

    st_begin("slab: multiple size classes");
    {
        uint32 sizes[] = {8, 16, 32, 64, 128, 256, 512, 1024, 2048};
        void* ptrs[9];
        for (int i = 0; i < 9; i++) {
            ptrs[i] = kmalloc(sizes[i]);
            ST_ASSERT(ptrs[i] != nullptr);
            // Write a marker
            *static_cast<uint8*>(ptrs[i]) = static_cast<uint8>(i);
        }
        // Verify markers (no cross-contamination)
        for (int i = 0; i < 9; i++) {
            ST_ASSERT_EQ(*static_cast<uint8*>(ptrs[i]), static_cast<uint8>(i));
        }
        for (int i = 0; i < 9; i++) {
            kfree(ptrs[i]);
        }
    }
    st_pass();

    st_begin("slab: no aliasing");
    {
        void* a = kmalloc(32);
        void* b = kmalloc(32);
        ST_ASSERT(a != nullptr);
        ST_ASSERT(b != nullptr);
        ST_ASSERT_NE(a, b);
        kfree(b);
        kfree(a);
    }
    st_pass();

    st_begin("slab: alignment (8-byte minimum)");
    {
        for (int i = 0; i < 16; i++) {
            void* p = kmalloc(7);  // odd size, should still be 8-aligned
            ST_ASSERT(p != nullptr);
            ST_ASSERT_EQ(reinterpret_cast<uint64>(p) % 8, 0ULL);
            kfree(p);
        }
    }
    st_pass();

    st_begin("slab: bulk alloc/free stress (128 x 64B)");
    {
        constexpr int N = 128;
        void* ptrs[N];
        for (int i = 0; i < N; i++) {
            ptrs[i] = kmalloc(64);
            ST_ASSERT(ptrs[i] != nullptr);
        }
        // Free in reverse order
        for (int i = N - 1; i >= 0; i--) {
            kfree(ptrs[i]);
        }
    }
    st_pass();

    st_begin("slab: operator new/delete");
    {
        struct TestObj {
            uint64 a;
            uint64 b;
        };
        TestObj* obj = new TestObj{42, 99};
        ST_ASSERT(obj != nullptr);
        ST_ASSERT_EQ(obj->a, 42ULL);
        ST_ASSERT_EQ(obj->b, 99ULL);
        delete obj;
    }
    st_pass();

    st_begin("slab: large alloc (4096 bytes, PMM fallback)");
    {
        void* p = kmalloc(4096);
        ST_ASSERT(p != nullptr);
        ST_ASSERT_EQ(reinterpret_cast<uint64>(p) % kPageSize, 0ULL);
        kfree(p);
    }
    st_pass();

    st_begin("slab: edge cases (zero size, null free)");
    {
        void* p = kmalloc(0);
        ST_ASSERT(p == nullptr);
        kfree(nullptr);  // should not crash
    }
    st_pass();
    st_begin("slab: LIFO freelist reallocation (same address)");
    {
        void* a = kmalloc(32);
        kfree(a);
        void* b = kmalloc(32);
        ST_ASSERT_EQ(a, b);
        kfree(b);
    }
    st_pass();

    st_begin("slab: boundary conditions (2048 bytes size class)");
    {
        // 2048 bytes should still use slab (2 objects per page)
        // We allocate 3 to guarantee at least two fall in the exact same slab page
        void* p1 = kmalloc(2048);
        void* p2 = kmalloc(2048);
        void* p3 = kmalloc(2048);
        
        auto diff = [](void* a, void* b) -> uint64 {
            uint64 ua = reinterpret_cast<uint64>(a);
            uint64 ub = reinterpret_cast<uint64>(b);
            return ua > ub ? ua - ub : ub - ua;
        };
        
        // At least one adjacent pair MUST be exactly separated by 2048 bytes
        bool found_2048 = (diff(p1, p2) == 2048ULL) || (diff(p2, p3) == 2048ULL);
        ST_ASSERT(found_2048);
        
        kfree(p1);
        kfree(p2);
        kfree(p3);
    }
    st_pass();

    st_begin("slab: cross-page allocation (> 1 page equivalent objects)");
    {
        // Allocating more than one page worth of 32-byte objects (4096 / 32 = 128)
        constexpr int NUM = 150;
        void* ptrs[NUM];
        for (int i=0; i<NUM; i++) {
            ptrs[i] = kmalloc(32);
            ST_ASSERT(ptrs[i] != nullptr);
        }
        for (int i=0; i<NUM; i++) {
            kfree(ptrs[i]);
        }
    }
    st_pass();

    st_begin("slab: empty page reclamation (verifiable by page availability)");
    {
        // Allocate 128-byte objects until we hit the start of a completely new page.
        void* base_ptr = nullptr;
        void* drain[64];
        int drain_count = 0;
        
        while (true) {
            void* p = kmalloc(128);
            // Because 128 divides 4096 evenly, a new page starts at an exact multiple of kPageSize.
            if (reinterpret_cast<uint64>(p) % kPageSize == 0) {
                base_ptr = p;
                break;
            }
            drain[drain_count++] = p;
        }
        
        // base_ptr is the very first object in a fresh slab page!
        // The page holds exactly 32 objects (4096 / 128 = 32). We already hold 1 (base_ptr).
        void* ptrs[32];
        ptrs[0] = base_ptr;
        for (int i = 1; i < 32; i++) {
            ptrs[i] = kmalloc(128);
        }
        
        // At this point, we completely own all 32 objects of this slab page.
        uint64 page_pa = va_to_pa(virt_addr(reinterpret_cast<uint64>(base_ptr))).raw;
        Page* page = pa_to_page(phys_addr(page_pa));
        
        ST_ASSERT(page->state == PageState::Slab);
        ST_ASSERT(page->slab.obj_count == 32);

        // Free all items in this isolated slab page
        for (int i = 0; i < 32; i++) {
            kfree(ptrs[i]);
        }
        
        // The page MUST have been returned to the PMM (either global Free or Per-CPU Cached).
        ST_ASSERT(page->state == PageState::Free || page->state == PageState::PcpCached);
        
        // Clean up the drain array
        for (int i = 0; i < drain_count; i++) {
            kfree(drain[i]);
        }
    }
    st_pass();

    st_begin("slab: continuous operator new/delete memory leak loop");
    {
        struct BigObj { uint8 data[512]; };
        BigObj* ptr = nullptr;
        // 10K allocations to ensure no memory leak causes OOM
        for (int i = 0; i < 10000; i++) {
            ptr = new BigObj;
            ST_ASSERT(ptr != nullptr);
            delete ptr;
        }
    }
    st_pass();

    st_begin("slab: allocation pressure (mixed sizes)");
    {
        constexpr int MAX_ITEMS = 100;
        void* ptrs[MAX_ITEMS];
        uint32 sizes[MAX_ITEMS];
        
        for (int i = 0; i < MAX_ITEMS; i++) {
            sizes[i] = (i * 17) % 2000 + 8; // Pseudo-random sizes between 8 and 2008
            ptrs[i] = kmalloc(sizes[i]);
            ST_ASSERT(ptrs[i] != nullptr);
            ST_ASSERT(reinterpret_cast<uintptr>(ptrs[i]) % 8 == 0);
        }
        
        for (int i = 0; i < MAX_ITEMS; i++) {
            kfree(ptrs[i]);
        }
    }
    st_pass();
}
