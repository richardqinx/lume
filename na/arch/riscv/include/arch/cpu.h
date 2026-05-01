/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * CPU Control & Status Primitives (RISC-V 64)
 *
 * Provides interrupt enable/disable, CPU ID, timer, and halt.
 * All functions are static inline — zero call overhead.
 *
 * Precondition: tp register must be initialized with CPU ID
 *               by entry.S before any of these functions are called.
 *
 * Reference: docs/specs/arch_abstraction.md §4.1
 */

#include <lume/types.h>

/* RISC-V sstatus register bit definitions */
#define SSTATUS_SIE  (1UL << 1)   /* Supervisor Interrupt Enable */
#define SSTATUS_SPIE (1UL << 5)   /* Supervisor Previous Interrupt Enable */
#define SSTATUS_SPP  (1UL << 8)   /* Supervisor Previous Privilege (0=U, 1=S) */

/* RISC-V sie register bit definitions */
#define SIE_SSIE (1UL << 1)       /* Supervisor Software Interrupt Enable */
#define SIE_STIE (1UL << 5)       /* Supervisor Timer Interrupt Enable */
#define SIE_SEIE (1UL << 9)       /* Supervisor External Interrupt Enable */

namespace arch::cpu {

// Get current CPU ID (from tp register, set by entry.S)
static inline uint64 id() {
    uint64 val;
    __asm__ volatile("mv %0, tp" : "=r"(val));
    return val;
}

// Enable interrupts (set sstatus.SIE = 1)
static inline void intr_on() {
    __asm__ volatile("csrs sstatus, %0" :: "r"(SSTATUS_SIE));
}

// Disable interrupts (clear sstatus.SIE = 0)
static inline void intr_off() {
    __asm__ volatile("csrc sstatus, %0" :: "r"(SSTATUS_SIE));
}

// Check if interrupts are currently enabled
static inline bool intr_enabled() {
    uint64 sstatus;
    __asm__ volatile("csrr %0, sstatus" : "=r"(sstatus));
    return (sstatus & SSTATUS_SIE) != 0;
}

// Halt CPU until next interrupt (wfi instruction)
static inline void halt_until_interrupt() {
    __asm__ volatile("wfi");
}

// Read hardware monotonic timer (rdtime instruction)
// Returns ticks since boot; frequency from FDT timebase-frequency.
static inline uint64 read_time() {
    uint64 val;
    __asm__ volatile("rdtime %0" : "=r"(val));
    return val;
}

// Enable timer interrupt in sie (sie.STIE = 1)
static inline void timer_intr_on() {
    __asm__ volatile("csrs sie, %0" :: "r"(SIE_STIE));
}

// Disable timer interrupt in sie (sie.STIE = 0)
static inline void timer_intr_off() {
    __asm__ volatile("csrc sie, %0" :: "r"(SIE_STIE));
}

}  // namespace arch::cpu
