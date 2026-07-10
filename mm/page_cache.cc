/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * page_cache.cc — Minimal page cache implementation
 *
 * Open-addressing hash table indexed by (mapping, index) pairs.
 * Fixed-size bucket array allocated at init time via slab.
 *
 * This is intentionally simple: no LRU, no writeback, no eviction.
 * The interface in page_cache.h is designed so that upgrading to a
 * radix tree + LRU scheme later only changes this file.
 *
 * Concurrency: protected by a single spinlock. Acceptable for
 * initial bring-up; will be replaced by per-bucket or RCU-based
 * locking when contention becomes measurable.
 */

#include <lume/page_cache.h>
#include <lume/page.h>
#include <lume/pmm.h>
#include <lume/errno.h>
#include <lume/new.h>
#include <kernel/sync/spinlock.h>

/* ------------------------------------------------------------------ */
/*  Hash table internals                                              */
/* ------------------------------------------------------------------ */

struct CacheEntry {
    void*  mapping;   // nullptr = empty slot
    uint64 index;
    Page*  page;
};

namespace {

constexpr uint64 kCacheBuckets = 1024;

CacheEntry g_buckets[kCacheBuckets];
Spinlock   g_cache_lock;

uint64 hash_key(void* mapping, uint64 index)
{
    uint64 m = reinterpret_cast<uint64>(mapping);
    /* FNV-1a inspired mixing */
    uint64 h = m ^ (index * 0x517cc1b727220a95ULL);
    h ^= h >> 17;
    h *= 0xbf58476d1ce4e5b9ULL;
    h ^= h >> 31;
    return h % kCacheBuckets;
}

/* Linear probe to find an entry or an empty slot. */
CacheEntry* find_slot(void* mapping, uint64 index)
{
    uint64 start = hash_key(mapping, index);
    for (uint64 i = 0; i < kCacheBuckets; i++) {
        uint64 idx = (start + i) % kCacheBuckets;
        CacheEntry* e = &g_buckets[idx];
        if (e->mapping == nullptr) {
            return e;  // Empty slot
        }
        if (e->mapping == mapping && e->index == index) {
            return e;  // Found
        }
    }
    return nullptr;  // Table full
}

/* Find an existing entry (not an empty slot). */
CacheEntry* find_entry(void* mapping, uint64 index)
{
    uint64 start = hash_key(mapping, index);
    for (uint64 i = 0; i < kCacheBuckets; i++) {
        uint64 idx = (start + i) % kCacheBuckets;
        CacheEntry* e = &g_buckets[idx];
        if (e->mapping == nullptr) {
            return nullptr;  // Empty = not found
        }
        if (e->mapping == mapping && e->index == index) {
            return e;
        }
    }
    return nullptr;
}

/*
 * Remove an entry and fix up the linear-probe chain.
 * Standard open-addressing deletion with backward shift.
 */
void remove_entry(CacheEntry* entry)
{
    uint64 removed = static_cast<uint64>(entry - g_buckets);
    entry->mapping = nullptr;
    entry->page = nullptr;

    /* Backward-shift deletion to maintain probe chain integrity */
    uint64 cur = (removed + 1) % kCacheBuckets;
    while (g_buckets[cur].mapping != nullptr) {
        uint64 ideal = hash_key(g_buckets[cur].mapping, g_buckets[cur].index);
        /* Check if cur's ideal position is "before" removed in probe order */
        bool needs_shift = false;
        if (removed <= cur) {
            needs_shift = (ideal <= removed || ideal > cur);
        } else {
            needs_shift = (ideal <= removed && ideal > cur);
        }

        if (needs_shift) {
            g_buckets[removed] = g_buckets[cur];
            g_buckets[cur].mapping = nullptr;
            g_buckets[cur].page = nullptr;
            removed = cur;
        }
        cur = (cur + 1) % kCacheBuckets;
    }
}

} // namespace

/* ------------------------------------------------------------------ */
/*  Public API                                                        */
/* ------------------------------------------------------------------ */

void page_cache_init()
{
    g_cache_lock.init("page_cache");
    for (uint64 i = 0; i < kCacheBuckets; i++) {
        g_buckets[i].mapping = nullptr;
        g_buckets[i].index = 0;
        g_buckets[i].page = nullptr;
    }
}

Page* page_cache_get(void* mapping, uint64 index)
{
    LockGuard guard(g_cache_lock);
    CacheEntry* e = find_entry(mapping, index);
    if (!e) {
        return nullptr;
    }
    page_incref(e->page);
    return e->page;
}

int page_cache_insert(void* mapping, uint64 index, Page* page)
{
    if (!mapping || !page) {
        return -EINVAL;
    }

    LockGuard guard(g_cache_lock);

    /* Check for existing entry */
    CacheEntry* existing = find_entry(mapping, index);
    if (existing) {
        return -EEXIST;
    }

    /* Find an empty slot */
    CacheEntry* slot = find_slot(mapping, index);
    if (!slot || slot->mapping != nullptr) {
        return -ENOMEM;  // Table full
    }

    slot->mapping = mapping;
    slot->index = index;
    slot->page = page;
    page_incref(page);  // Cache holds a reference

    return 0;
}

void page_cache_put(Page* page)
{
    if (!page) {
        return;
    }
    page_decref(page);
}

Page* page_cache_remove(void* mapping, uint64 index)
{
    LockGuard guard(g_cache_lock);
    CacheEntry* e = find_entry(mapping, index);
    if (!e) {
        return nullptr;
    }

    Page* page = e->page;
    remove_entry(e);
    page_decref(page);  // Release cache's reference
    return page;
}

void page_cache_invalidate(void* mapping)
{
    if (!mapping) {
        return;
    }

    LockGuard guard(g_cache_lock);

    /* Scan all buckets — acceptable for current table size */
    for (uint64 i = 0; i < kCacheBuckets; i++) {
        if (g_buckets[i].mapping == mapping) {
            Page* page = g_buckets[i].page;
            remove_entry(&g_buckets[i]);
            page_decref(page);
            /* After removal, re-check this index since backward shift
             * may have moved an entry into this slot. */
            i--;
        }
    }
}

Page* page_cache_get_or_alloc(void* mapping, uint64 index)
{
    /* Fast path: already cached */
    Page* page = page_cache_get(mapping, index);
    if (page) {
        return page;
    }

    /* Slow path: allocate and insert */
    page = pmm_alloc_page();
    if (!page) {
        return nullptr;
    }

    int ret = page_cache_insert(mapping, index, page);
    if (ret == -EEXIST) {
        /* Race: another thread inserted between our get and insert.
         * Free our allocation and return the existing page. */
        pmm_free_page(page);
        return page_cache_get(mapping, index);
    }
    if (ret < 0) {
        pmm_free_page(page);
        return nullptr;
    }

    /* Caller gets a ref (insert already added cache's ref,
     * we need one more for the caller). */
    /* Actually, insert did incref for cache. The page already has
     * refcount=1 from alloc + 1 from insert = 2.
     * We return it to caller who must put() when done.
     * So we incref once more for the caller's reference. */
    page_incref(page);
    return page;
}
