/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Spinlock & LockGuard
 *
 * Provides mutual exclusion for SMP kernels using TTAS
 * (Test-and-Test-and-Set) with acquire/release memory ordering.
 * Interrupt disable/enable is managed automatically via push_intr/pop_intr.
 *
 * Reference: docs/specs/spinlock.md
 */

#include <lume/types.h>
#include "cpu_state.h"

class Spinlock {
public:
    // Default: BSS zero is safe. Call init() to give the lock a name.
    Spinlock() = default;

    // Explicit initialization (for global objects or Placement New)
    void init(const char* name);

    // Non-copyable, non-movable (lock identity is its address)
    Spinlock(const Spinlock&) = delete;
    Spinlock& operator=(const Spinlock&) = delete;
    Spinlock(Spinlock&&) = delete;
    Spinlock& operator=(Spinlock&&) = delete;

    void acquire();
    void release();
    bool is_held_by_current_cpu() const;

private:
    uint32 locked_ = 0;                    // 0 = free, 1 = held
    const char* name_ = "uninit";          // Lock name (for panic messages)
    uint64 cpu_id_ = sync::kInvalidCpuId;  // Holder CPU ID
};

class LockGuard {
public:
    explicit LockGuard(Spinlock& lock) : lock_(lock) {
        lock_.acquire();
    }

    ~LockGuard() {
        lock_.release();
    }

    LockGuard(const LockGuard&) = delete;
    LockGuard& operator=(const LockGuard&) = delete;
    LockGuard(LockGuard&&) = delete;
    LockGuard& operator=(LockGuard&&) = delete;

private:
    Spinlock& lock_;
};
