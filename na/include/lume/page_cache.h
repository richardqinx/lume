/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * page_cache.h — Page Cache interface
 *
 * Provides a stable abstraction for caching physical pages indexed by
 * (mapping, index) pairs. All file-backed fault paths should go
 * through this interface so that upgrading the backing implementation
 * (e.g. LRU eviction, writeback, radix tree) does not require
 * changing any caller.
 *
 * Current implementation: simple open-addressing hash table.
 * Future: radix tree + LRU lists + writeback integration.
 *
 * Terminology:
 *   mapping — opaque pointer identifying the backing object
 *             (FileMapping*, or any future cache-able object).
 *   index   — page-granularity offset within the mapping.
 *
 * Reference: docs/specs/linux_abi_mm_plan.md §2.9, §3
 */

#include <lume/types.h>

struct Page;

/*
 * Look up a cached page by (mapping, index).
 * Returns the Page* if found (with refcount incremented), or nullptr.
 * Caller must call page_cache_put() when done.
 */
Page* page_cache_get(void* mapping, uint64 index);

/*
 * Insert a page into the cache, associated with (mapping, index).
 * The page's refcount is incremented by the cache.
 * If a page already exists at (mapping, index), returns -EEXIST.
 * Returns 0 on success, negative errno on failure.
 */
int page_cache_insert(void* mapping, uint64 index, Page* page);

/*
 * Release a reference obtained via page_cache_get().
 * This decrements the page's refcount. If the page was removed
 * from the cache and refcount drops to 0, the page is freed.
 */
void page_cache_put(Page* page);

/*
 * Remove a page from the cache by (mapping, index).
 * Decrements the cache's reference on the page.
 * Returns the removed Page* (caller does NOT own a new ref),
 * or nullptr if not found.
 */
Page* page_cache_remove(void* mapping, uint64 index);

/*
 * Remove all pages associated with a given mapping.
 * Used during file close / inode eviction / truncate.
 * Each removed page has its cache reference decremented.
 */
void page_cache_invalidate(void* mapping);

/*
 * Look up a page; if not found, allocate one, insert it, and return it.
 * The returned page has its refcount incremented (caller must put).
 * Returns nullptr on OOM.
 *
 * This is the primary interface for file-backed fault paths:
 * the caller gets a page and then fills it with file data if kPgUptodate
 * is not set.
 */
Page* page_cache_get_or_alloc(void* mapping, uint64 index);

/*
 * Initialize the page cache subsystem.
 * Called once during boot after slab_init().
 */
void page_cache_init();
