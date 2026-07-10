/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * smp.h — Machine-Independent SMP primitives
 *
 * Provides cross-CPU communication (IPI) and TLB coordination.
 * The MI interface calls through to arch-specific backends
 * (e.g. SBI on RISC-V, APIC on x86).
 *
 * Reference: docs/specs/linux_abi_mm_plan.md §SMP
 */

#include <lume/types.h>
#include <lume/atomic.h>
#include <lume/config.h>

/*
 * IPI reasons — each bit in the per-CPU pending mask
 * corresponds to one reason. Multiple reasons can be
 * pending simultaneously.
 */
enum IpiReason : uint32 {
    IPI_RESCHEDULE    = (1U << 0),  /* Target should call schedule() */
    IPI_TLB_SHOOTDOWN = (1U << 1),  /* Target should flush TLB */
    IPI_CALL_FUNCTION = (1U << 2),  /* Target should run a function */
    IPI_HALT          = (1U << 3),  /* Target should halt */
};

/*
 * Per-CPU IPI pending state.
 * Written by sender (atomically), consumed by receiver in IRQ context.
 */
struct IpiData {
    lume::atomic<uint32> pending;    /* Bitmask of IpiReason */

    /* TLB shootdown payload */
    uint64 tlb_start;
    uint64 tlb_end;
};

/* Per-CPU IPI data array (BSS zero-initialized) */
extern IpiData g_ipi_data[kMaxCpus];

/*
 * smp_send_ipi — Send an IPI to a set of CPUs
 *
 * @cpu_mask:  bitmask of target CPU IDs (bit N = CPU N)
 * @reason:    reason bits to set in the target's pending mask
 *
 * Safe to call from any context (interrupt or process).
 */
void smp_send_ipi(uint64 cpu_mask, uint32 reason);

/*
 * smp_send_reschedule — Convenience: send reschedule IPI to one CPU
 */
inline void smp_send_reschedule(uint8 cpu_id)
{
    smp_send_ipi(1ULL << cpu_id, IPI_RESCHEDULE);
}

/*
 * smp_init — Initialize SMP subsystem (called from BSP after trap_init)
 */
void smp_init();

/*
 * smp_handle_ipi — Called from trap handler on receiving S-mode
 *                  software interrupt. Processes all pending IPI reasons.
 */
void smp_handle_ipi();
