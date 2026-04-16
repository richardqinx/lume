/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Trap Vector Control Primitives (RISC-V 64)
 *
 * Set/read the S-mode trap vector (stvec), trap cause (scause),
 * and trap value (stval) registers.
 *
 * Reference: docs/specs/arch_abstraction.md §4.3
 */

#include <lume/types.h>

/* scause interrupt bit (bit 63): 1 = interrupt, 0 = exception */
#define SCAUSE_INTERRUPT (1UL << 63)

/* Exception cause codes (scause with bit 63 = 0) */
#define EXC_INST_MISALIGNED     0
#define EXC_INST_ACCESS_FAULT   1
#define EXC_ILLEGAL_INST        2
#define EXC_BREAKPOINT          3
#define EXC_LOAD_MISALIGNED     4
#define EXC_LOAD_ACCESS_FAULT   5
#define EXC_STORE_MISALIGNED    6
#define EXC_STORE_ACCESS_FAULT  7
#define EXC_ECALL_FROM_U        8
#define EXC_ECALL_FROM_S        9
#define EXC_INST_PAGE_FAULT    12
#define EXC_LOAD_PAGE_FAULT    13
#define EXC_STORE_PAGE_FAULT   15

/* Interrupt cause codes (scause with bit 63 = 1, lower bits) */
#define IRQ_S_SOFTWARE  1
#define IRQ_S_TIMER     5
#define IRQ_S_EXTERNAL  9

namespace arch::trap {

// Set S-mode trap vector base address (writes stvec).
// Mode: Direct (all traps go to handler_addr).
static inline void set_vector(uint64 handler_addr) {
    // Lowest 2 bits of stvec = mode. 0 = Direct.
    __asm__ volatile("csrw stvec, %0" :: "r"(handler_addr));
}

// Read current trap vector base address
static inline uint64 get_vector() {
    uint64 val;
    __asm__ volatile("csrr %0, stvec" : "=r"(val));
    return val;
}

// Read trap cause register (scause)
// Bit 63: 1=interrupt, 0=exception. Lower bits: cause code.
static inline uint64 get_cause() {
    uint64 val;
    __asm__ volatile("csrr %0, scause" : "=r"(val));
    return val;
}

// Read trap value register (stval)
// Contains faulting address (page faults) or faulting instruction.
static inline uint64 get_value() {
    uint64 val;
    __asm__ volatile("csrr %0, stval" : "=r"(val));
    return val;
}

// Check if a scause value represents an interrupt (vs exception)
static inline bool is_interrupt(uint64 cause) {
    return (cause & SCAUSE_INTERRUPT) != 0;
}

// Extract the cause code (strip the interrupt bit)
static inline uint64 cause_code(uint64 cause) {
    return cause & ~SCAUSE_INTERRUPT;
}

}  // namespace arch::trap
