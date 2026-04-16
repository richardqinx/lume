/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Spinlock Implementation
 *
 * TTAS (Test-and-Test-and-Set) spinlock with:
 *   - Acquire: __ATOMIC_ACQUIRE memory ordering
 *   - Release: __ATOMIC_RELEASE memory ordering
 *   - Automatic interrupt disable/enable via push_intr/pop_intr
 *   - Dead-lock and invalid-release detection via kernel_panic
 *
 * Reference: docs/specs/spinlock.md
 */

#include "spinlock.h"
#include "cpu_state.h"
#include <arch/cpu.h>
#include <lume/panic.h>

// ============================================================
// Per-CPU sync state (BSS zero-initialized)
// ============================================================
namespace sync {

CpuSyncState g_cpu_sync_states[kMaxCPUs];

void push_intr() {
    bool was_on = arch::cpu::intr_enabled();
    arch::cpu::intr_off();

    auto& state = g_cpu_sync_states[arch::cpu::id()];
    if (state.lock_depth == 0) {
        state.intr_was_on = was_on;
    }
    state.lock_depth++;
}

void pop_intr() {
    auto& state = g_cpu_sync_states[arch::cpu::id()];
    state.lock_depth--;

    if (state.lock_depth == 0 && state.intr_was_on) {
        arch::cpu::intr_on();
    }
}

}  // namespace sync

// ============================================================
// Spinlock methods
// ============================================================

void Spinlock::init(const char* name) {
    name_ = name;
    locked_ = 0;
    cpu_id_ = sync::kInvalidCpuId;
}

void Spinlock::acquire() {
#ifdef DEBUG
    // Optional: detect interrupt-state leakage
    if (arch::cpu::intr_enabled()) {
        auto& state = sync::g_cpu_sync_states[arch::cpu::id()];
        if (state.lock_depth > 0) {
            kernel_panic("spinlock: interrupts enabled while holding lock");
        }
    }
#endif

    // Step 1: disable interrupts, track nesting depth
    sync::push_intr();

    // Step 2: dead-lock detection (same CPU re-acquiring)
    if (is_held_by_current_cpu()) {
        kernel_panic("spinlock: double lock", name_);
    }

    // Step 3: TTAS spin loop
    while (true) {
        // Outer: spin on local cache copy (no bus traffic)
        while (__atomic_load_n(&locked_, __ATOMIC_RELAXED))
            ;
        // Inner: attempt atomic exchange with acquire semantics
        if (__atomic_exchange_n(&locked_, 1, __ATOMIC_ACQUIRE) == 0)
            break;
    }

    // Step 4: record owner
    cpu_id_ = arch::cpu::id();
}

void Spinlock::release() {
    // Step 1: verify caller is the holder
    if (!is_held_by_current_cpu()) {
        kernel_panic("spinlock: invalid release", name_);
    }

    // Step 2: clear owner
    cpu_id_ = sync::kInvalidCpuId;

    // Step 3: release the lock with release semantics
    __atomic_store_n(&locked_, 0, __ATOMIC_RELEASE);

    // Step 4: restore interrupt state if this was the last lock
    sync::pop_intr();
}

bool Spinlock::is_held_by_current_cpu() const {
    return cpu_id_ == arch::cpu::id();
}
