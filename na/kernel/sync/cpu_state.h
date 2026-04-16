/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Per-CPU Interrupt Nesting Tracker
 *
 * Tracks spinlock nesting depth on each CPU to ensure interrupts
 * are only restored when the last spinlock is released.
 *
 * BSS-segment global array; zero-initialized by entry.S BSS clear.
 * Reference: docs/specs/spinlock.md §3.1
 */

#include <lume/types.h>

namespace sync {

struct CpuSyncState {
    int lock_depth;      // Number of spinlocks held by this CPU
    bool intr_was_on;    // Were interrupts enabled before the first lock?
};

inline constexpr uint64 kInvalidCpuId = ~0ULL;

// BSS-segment global array, zero-initialized by entry.S
extern CpuSyncState g_cpu_sync_states[kMaxCPUs];

// Internal API — called only by Spinlock::acquire/release
void push_intr();
void pop_intr();

}  // namespace sync
