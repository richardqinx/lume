/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * lume::atomic<T> — Thin wrapper over __atomic builtins.
 *
 * All multi-core shared data that does NOT use a spinlock MUST use
 * this wrapper instead of raw __atomic_* builtins.
 *
 * Reference: docs/specs/00_conventions.md §5.3
 */

#include <lume/types.h>

namespace lume {

template<typename T>
class atomic {
public:
    atomic() = default;
    explicit atomic(T val) : val_(val) {}

    /* Prevent copies — an atomic value has identity */
    atomic(const atomic&) = delete;
    atomic& operator=(const atomic&) = delete;

    /* Load with specified memory ordering */
    T load(int order = __ATOMIC_SEQ_CST) const {
        return __atomic_load_n(&val_, order);
    }

    /* Store with specified memory ordering */
    void store(T desired, int order = __ATOMIC_SEQ_CST) {
        __atomic_store_n(&val_, desired, order);
    }

    /* Atomic exchange, returns old value */
    T exchange(T desired, int order = __ATOMIC_SEQ_CST) {
        return __atomic_exchange_n(&val_, desired, order);
    }

    /* Fetch-and-add, returns old value */
    T fetch_add(T delta, int order = __ATOMIC_ACQ_REL) {
        return __atomic_fetch_add(&val_, delta, order);
    }

    /* Fetch-and-subtract, returns old value */
    T fetch_sub(T delta, int order = __ATOMIC_ACQ_REL) {
        return __atomic_fetch_sub(&val_, delta, order);
    }

    /* Compare-and-swap. Returns true on success. */
    bool compare_exchange(T& expected, T desired,
                          int success_order = __ATOMIC_ACQ_REL,
                          int failure_order = __ATOMIC_ACQUIRE) {
        return __atomic_compare_exchange_n(&val_, &expected, desired,
                                           false, success_order, failure_order);
    }

private:
    T val_ = 0;
};

}  // namespace lume
