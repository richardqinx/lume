/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * MMU Hardware Primitives (RISC-V SV39)
 *
 * Page table switching, TLB flushing, and fault address reading.
 * All functions are static inline — zero call overhead.
 *
 * Note on SMP: flush_tlb_page() only flushes the LOCAL CPU's TLB.
 *              Cross-CPU TLB shootdown via IPI is not yet implemented.
 *
 * Reference: docs/specs/arch_abstraction.md §4.2
 */

#include <lume/types.h>

/* SATP register: mode field for SV39 */
#define SATP_SV39 (8UL << 60)

/* SATP PPN mask (bits 43:0) */
#define SATP_PPN_MASK ((1UL << 44) - 1)

namespace arch::mmu {

// Read the faulting virtual address from stval (set by HW on page fault)
static inline uint64 get_fault_address() {
    uint64 val;
    __asm__ volatile("csrr %0, stval" : "=r"(val));
    return val;
}

// Switch the top-level page table.
// Takes a PHYSICAL ADDRESS (not PPN); internally shifts right by 12
// and combines with SV39 mode bits before writing to satp.
static inline void set_page_table(uint64 physical_pgdir_addr) {
    uint64 ppn = physical_pgdir_addr >> 12;
    uint64 satp_val = SATP_SV39 | ppn;
    __asm__ volatile("csrw satp, %0" :: "r"(satp_val));
    // Note: caller should call flush_tlb_all() after this
}

// Read the current page table physical address.
// Extracts PPN from satp and converts back to physical address.
static inline uint64 get_page_table() {
    uint64 satp_val;
    __asm__ volatile("csrr %0, satp" : "=r"(satp_val));
    return (satp_val & SATP_PPN_MASK) << 12;
}

// Flush the entire TLB (all ASIDs, all addresses)
static inline void flush_tlb_all() {
    __asm__ volatile("sfence.vma zero, zero" ::: "memory");
}

// Flush a single TLB entry for the given virtual address
static inline void flush_tlb_page(uint64 vaddr) {
    __asm__ volatile("sfence.vma %0, zero" :: "r"(vaddr) : "memory");
}

}  // namespace arch::mmu
