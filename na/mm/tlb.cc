/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * tlb.cc — TLB shootdown implementation
 *
 * Uses RISC-V SBI Remote Fence extension to perform cross-hart
 * TLB invalidation. SBI firmware handles the IPI delivery and
 * synchronization — the call blocks until all target harts have
 * completed their local sfence.vma.
 *
 * When a VmSpace is provided, we use its cpu_mask to target only
 * the CPUs that have this address space loaded in satp. This avoids
 * unnecessary IPI storms on unrelated cores.
 *
 * Reference: docs/specs/linux_abi_mm_plan.md §SMP §2.1
 */

#include <lume/tlb.h>
#include <lume/vmm.h>
#include <lume/config.h>
#include <arch/mmu.h>
#include <arch/tlb.h>
#include <arch/cpu.h>

/*
 * If a shootdown range exceeds this many pages, do a full flush
 * instead of per-page invalidation.
 */
static constexpr uint64 kShootdownPageThreshold = 32;

/*
 * Build a cpu mask for all online CPUs (fallback when mm is null).
 */
namespace {
uint64 all_cpus_mask()
{
    uint64 mask = 0;
    for (uint32 i = 0; i < kMaxCpus; i++) {
        mask |= (1ULL << i);
    }
    return mask;
}

/*
 * Get the target cpu mask: use mm->cpu_mask when available,
 * fall back to all_cpus_mask for kernel address space (mm == nullptr).
 */
uint64 target_cpu_mask(VmSpace* mm)
{
    if (mm) {
        uint64 mask = mm->cpu_mask.load(__ATOMIC_RELAXED);
        /* Always include our own CPU — we may still have stale TLB */
        mask |= (1ULL << arch::cpu::id());
        return mask;
    }
    return all_cpus_mask();
}
} // namespace

void tlb_shootdown_range(VmSpace* mm, uint64 start, uint64 end)
{
    if (start >= end) {
        return;
    }

    uint64 num_pages = (end - start) / kPageSize;
    uint64 cpu_mask = target_cpu_mask(mm);

    if (num_pages > kShootdownPageThreshold) {
        /* Full flush on target CPUs via arch backend */
        arch::tlb::flush_remote(cpu_mask, 0, ~0ULL);
        return;
    }

    /* Range flush on target CPUs via arch backend */
    arch::tlb::flush_remote(cpu_mask, start, end - start);
}

void tlb_shootdown_page(VmSpace* mm, uint64 va)
{
    uint64 cpu_mask = target_cpu_mask(mm);
    arch::tlb::flush_remote(cpu_mask, va, kPageSize);
}

void tlb_shootdown_all()
{
    uint64 cpu_mask = all_cpus_mask();
    arch::tlb::flush_remote(cpu_mask, 0, ~0ULL);
}
