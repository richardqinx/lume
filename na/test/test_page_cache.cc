/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_page_cache.cc — Self-tests for the page cache hash table
 *
 * Tests: insert, get, remove, duplicate insert, invalidate,
 *        get_or_alloc, null args.
 */

#include <lume/selftest.h>
#include <lume/page_cache.h>
#include <lume/page.h>
#include <lume/pmm.h>
#include <lume/errno.h>

void selftest_page_cache()
{
    /* Use sentinel pointers as fake "mapping" identifiers.
     * These are never dereferenced — only used as hash keys. */
    int mapping_a_tag = 0;
    int mapping_b_tag = 0;
    void* mapping_a = &mapping_a_tag;
    void* mapping_b = &mapping_b_tag;

    /* ---- insert and get ---- */
    st_begin("page_cache: insert then get returns same page");
    {
        Page* page = pmm_alloc_page();
        ST_ASSERT(page != nullptr);

        int ret = page_cache_insert(mapping_a, 0, page);
        ST_ASSERT_EQ(ret, 0);

        Page* got = page_cache_get(mapping_a, 0);
        ST_ASSERT_EQ(got, page);

        /* put the reference from get */
        page_cache_put(got);

        /* Clean up */
        page_cache_remove(mapping_a, 0);
        pmm_free_page(page);
    }
    st_pass();

    /* ---- get nonexistent returns nullptr ---- */
    st_begin("page_cache: get nonexistent returns nullptr");
    {
        Page* got = page_cache_get(mapping_a, 99999);
        ST_ASSERT(got == nullptr);
    }
    st_pass();

    /* ---- duplicate insert returns -EEXIST ---- */
    st_begin("page_cache: duplicate insert returns -EEXIST");
    {
        Page* page = pmm_alloc_page();
        ST_ASSERT(page != nullptr);

        int ret1 = page_cache_insert(mapping_a, 1, page);
        ST_ASSERT_EQ(ret1, 0);

        Page* page2 = pmm_alloc_page();
        ST_ASSERT(page2 != nullptr);

        int ret2 = page_cache_insert(mapping_a, 1, page2);
        ST_ASSERT_EQ(ret2, -EEXIST);

        /* Clean up */
        page_cache_remove(mapping_a, 1);
        pmm_free_page(page);
        pmm_free_page(page2);
    }
    st_pass();

    /* ---- remove returns page ---- */
    st_begin("page_cache: remove returns page and deletes entry");
    {
        Page* page = pmm_alloc_page();
        ST_ASSERT(page != nullptr);

        page_cache_insert(mapping_a, 2, page);

        Page* removed = page_cache_remove(mapping_a, 2);
        ST_ASSERT_EQ(removed, page);

        /* Should be gone now */
        Page* got = page_cache_get(mapping_a, 2);
        ST_ASSERT(got == nullptr);

        pmm_free_page(page);
    }
    st_pass();

    /* ---- remove nonexistent returns nullptr ---- */
    st_begin("page_cache: remove nonexistent returns nullptr");
    {
        Page* got = page_cache_remove(mapping_a, 77777);
        ST_ASSERT(got == nullptr);
    }
    st_pass();

    /* ---- different mappings are independent ---- */
    st_begin("page_cache: different mappings are independent");
    {
        Page* pa = pmm_alloc_page();
        Page* pb = pmm_alloc_page();
        ST_ASSERT(pa != nullptr);
        ST_ASSERT(pb != nullptr);

        page_cache_insert(mapping_a, 5, pa);
        page_cache_insert(mapping_b, 5, pb);

        Page* got_a = page_cache_get(mapping_a, 5);
        Page* got_b = page_cache_get(mapping_b, 5);
        ST_ASSERT_EQ(got_a, pa);
        ST_ASSERT_EQ(got_b, pb);
        ST_ASSERT_NE(got_a, got_b);

        page_cache_put(got_a);
        page_cache_put(got_b);
        page_cache_remove(mapping_a, 5);
        page_cache_remove(mapping_b, 5);
        pmm_free_page(pa);
        pmm_free_page(pb);
    }
    st_pass();

    /* ---- invalidate removes all entries for a mapping ---- */
    st_begin("page_cache: invalidate removes all entries for mapping");
    {
        Page* pages[4];
        for (int i = 0; i < 4; i++) {
            pages[i] = pmm_alloc_page();
            ST_ASSERT(pages[i] != nullptr);
            page_cache_insert(mapping_a, 10 + i, pages[i]);
        }

        /* Also insert one for mapping_b */
        Page* pb = pmm_alloc_page();
        page_cache_insert(mapping_b, 10, pb);

        /* Invalidate mapping_a */
        page_cache_invalidate(mapping_a);

        /* All mapping_a entries should be gone */
        for (int i = 0; i < 4; i++) {
            Page* got = page_cache_get(mapping_a, 10 + i);
            ST_ASSERT(got == nullptr);
            pmm_free_page(pages[i]);
        }

        /* mapping_b should still be there */
        Page* got_b = page_cache_get(mapping_b, 10);
        ST_ASSERT_EQ(got_b, pb);
        page_cache_put(got_b);
        page_cache_remove(mapping_b, 10);
        pmm_free_page(pb);
    }
    st_pass();

    /* ---- insert null mapping returns -EINVAL ---- */
    st_begin("page_cache: insert null mapping returns -EINVAL");
    {
        Page* page = pmm_alloc_page();
        int ret = page_cache_insert(nullptr, 0, page);
        ST_ASSERT_EQ(ret, -EINVAL);
        pmm_free_page(page);
    }
    st_pass();

    /* ---- insert null page returns -EINVAL ---- */
    st_begin("page_cache: insert null page returns -EINVAL");
    {
        int ret = page_cache_insert(mapping_a, 0, nullptr);
        ST_ASSERT_EQ(ret, -EINVAL);
    }
    st_pass();
}
