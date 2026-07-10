/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * smp.cc — SMP IPI implementation
 *
 * Sending side: atomically set reason bits in target CPU's IpiData,
 * then invoke arch-specific IPI delivery (SBI ecall on RISC-V).
 *
 * Receiving side: smp_handle_ipi() is called from the trap handler
 * when an S-mode software interrupt arrives. It atomically consumes
 * all pending reason bits and dispatches to the appropriate handler.
 *
 * Reference: docs/specs/linux_abi_mm_plan.md §SMP §2.2
 */

#include <lume/smp.h>
#include <lume/klog.h>
#include <lume/sched.h>
#include <arch/cpu.h>
#include <arch/mmu.h>
#include <arch/sbi.h>

/* Per-CPU IPI data — BSS zero-initialized */
IpiData g_ipi_data[kMaxCpus];

/* ------------------------------------------------------------------ */
/*  smp_init                                                           */
/* ------------------------------------------------------------------ */

void smp_init()
{
    for (uint32 i = 0; i < kMaxCpus; i++) {
        g_ipi_data[i].pending.store(0, __ATOMIC_RELAXED);
        g_ipi_data[i].tlb_start = 0;
        g_ipi_data[i].tlb_end = 0;
    }

    printk(KERN_INFO "smp: IPI framework initialized (%u CPUs max)\n",
           static_cast<unsigned>(kMaxCpus));
}

/* ------------------------------------------------------------------ */
/*  smp_send_ipi — send IPI to target CPUs                             */
/* ------------------------------------------------------------------ */

void smp_send_ipi(uint64 cpu_mask, uint32 reason)
{
    if (cpu_mask == 0) return;

    /* Set pending bits on each target CPU's IpiData */
    for (uint32 cpu = 0; cpu < kMaxCpus; cpu++) {
        if (cpu_mask & (1ULL << cpu)) {
            g_ipi_data[cpu].pending.fetch_or(reason, __ATOMIC_RELEASE);
        }
    }

    /* Deliver hardware interrupt via SBI.
     * RISC-V SBI IPI extension sends S-mode software interrupt
     * to the specified harts. hart_mask maps 1:1 to cpu_mask
     * (assuming hartid == cpu_id, which holds for QEMU virt). */
    arch::sbi::sbi_send_ipi(cpu_mask, 0);
}

/* ------------------------------------------------------------------ */
/*  smp_handle_ipi — called from trap handler on software interrupt    */
/* ------------------------------------------------------------------ */

void smp_handle_ipi()
{
    uint32 cpu = static_cast<uint32>(arch::cpu::id());

    /* Clear the S-mode software interrupt pending bit (sip.SSIP).
     * On RISC-V, we must clear this in software, otherwise the
     * interrupt will keep firing. */
    arch::cpu::clear_sip_ssip();

    /* Atomically consume all pending reasons */
    uint32 reasons = g_ipi_data[cpu].pending.exchange(0, __ATOMIC_ACQUIRE);

    if (reasons == 0) return;  /* Spurious */

    /* Dispatch each reason */

    if (reasons & IPI_RESCHEDULE) {
        /* Just need to return from interrupt — schedule() will be
         * called on the return-from-trap path if need_resched is set.
         * For now, set the flag by yielding on next opportunity. */
        /* TODO: set need_resched flag when preemption tracking is added */
    }

    if (reasons & IPI_TLB_SHOOTDOWN) {
        /* Execute local TLB flush with the parameters the sender stored */
        uint64 start = g_ipi_data[cpu].tlb_start;
        uint64 end   = g_ipi_data[cpu].tlb_end;
        if (start == 0 && end == 0) {
            arch::mmu::flush_tlb_all();
        } else {
            for (uint64 va = start; va < end; va += kPageSize) {
                arch::mmu::flush_tlb_page(va);
            }
        }
    }

    if (reasons & IPI_HALT) {
        printk(KERN_INFO "smp: CPU %u halting by IPI\n", cpu);
        arch::cpu::intr_off();
        while (true) {
            arch::cpu::halt_until_interrupt();
        }
    }
}
