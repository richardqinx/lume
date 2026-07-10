/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * tlb.h — Machine-Independent TLB management interface
 *
 * All TLB invalidation in the kernel MUST go through these functions.
 * Direct use of arch::mmu::flush_tlb_*() is prohibited outside of
 * this file's implementation.
 *
 * Current implementation: local CPU sfence.vma only (single-core).
 * When SMP IPI infrastructure is available, tlb_shootdown_range()
 * and tlb_shootdown_all() will broadcast invalidation to remote
 * CPUs via IPI — no caller changes required.
 *
 * Reference: docs/specs/linux_abi_mm_plan.md §4
 */

#include <lume/types.h>

struct VmSpace;

/*
 * Invalidate TLB entries for a VA range [start, end) on ALL CPUs
 * that may have cached translations for the given address space.
 *
 * @mm:    address space (used to determine which CPUs to IPI;
 *         nullptr means kernel address space = all CPUs).
 * @start: first VA to invalidate (page-aligned).
 * @end:   one-past-last VA to invalidate (page-aligned).
 *
 * If (end - start) exceeds a threshold, falls back to full flush.
 */
void tlb_shootdown_range(VmSpace* mm, uint64 start, uint64 end);

/*
 * Invalidate a single page's TLB entry on ALL CPUs.
 * Convenience wrapper around tlb_shootdown_range().
 */
void tlb_shootdown_page(VmSpace* mm, uint64 va);

/*
 * Full TLB flush on ALL CPUs.
 * Used after page table switch, large-scale munmap, etc.
 */
void tlb_shootdown_all();
