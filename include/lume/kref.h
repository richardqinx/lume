/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * kref — atomic reference counting.
 *
 * Mirrors Linux include/linux/kref.h.  Use kref_init() to set count=1,
 * kref_get() / kref_put() to add/drop refs.  kref_put() invokes the
 * release callback when the final ref is dropped and returns 1 in that
 * case.
 *
 * Reference: docs/specs/storage_stack.md §4.1
 */

#include <lume/types.h>
#include <lume/atomic.h>

struct kref {
    lume::atomic<int32> refcount;
};

inline void kref_init(kref* k)
{
    k->refcount.store(1, __ATOMIC_RELEASE);
}

inline void kref_get(kref* k)
{
    k->refcount.fetch_add(1, __ATOMIC_RELAXED);
}

inline int kref_put(kref* k, void (*release)(kref*))
{
    if (k->refcount.fetch_sub(1, __ATOMIC_ACQ_REL) == 1) {
        release(k);
        return 1;
    }
    return 0;
}

inline int32 kref_read(const kref* k)
{
    return k->refcount.load(__ATOMIC_RELAXED);
}
