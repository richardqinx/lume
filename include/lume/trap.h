/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Trap Subsystem — Machine-Independent Interface
 *
 * Defines TrapCause enum and MI-layer declarations.
 * MD layer (arch/riscv/trap/trap_md.cc) translates scause → TrapCause.
 * MI layer (kernel/trap.cc) dispatches based on TrapCause alone.
 *
 * Reference: docs/specs/trap.md §3.2
 */

#include <lume/types.h>

/* MI-layer trap cause classification.
 * MD layer is responsible for translating architecture-specific cause codes
 * (e.g., RISC-V scause) into these semantic values. MI layer never reads CSRs. */
enum class TrapCause : uint32 {
    /* --- Exceptions (Synchronous) --- */
    PageFaultLoad  = 0,   // Load page fault
    PageFaultStore = 1,   // Store/AMO page fault
    PageFaultExec  = 2,   // Instruction page fault
    Syscall        = 3,   // User-mode ecall
    IllegalInst    = 4,   // Illegal instruction
    Breakpoint     = 5,   // Breakpoint (ebreak)
    AccessFault    = 6,   // Bus access fault (not page fault)
    AlignFault     = 7,   // Address misalignment

    /* --- Interrupts (Asynchronous) --- */
    IrqTimer       = 16,  // S-mode timer interrupt
    IrqSoftware    = 17,  // S-mode software interrupt (IPI)
    IrqExternal    = 18,  // S-mode external interrupt (PLIC)

    /* --- Unknown --- */
    Unknown        = 255,
};

/* High-level trap class for routing and stats. */
enum class TrapClass : uint8 {
    Exception = 0,
    Interrupt = 1,
    Syscall   = 2,
    Unknown   = 3,
};

/* Origin privilege of the trap. */
enum class TrapOrigin : uint8 {
    FromUser   = 0,
    FromKernel = 1,
};

/* Unified trap context passed from MD to MI. */
struct TrapInfo {
    TrapClass  cls;
    TrapCause  cause;
    TrapOrigin origin;
    uint64     val;     // stval (faulting address or instruction)
    uint64     epc;     // sepc at trap entry (may be adjusted by MD)
    uint64     scause;  // raw scause for diagnostics
};

/* Trap statistics for debugging/testing. */
inline constexpr uint32 kTrapCauseCount = 12;

struct TrapStats {
    uint64 total;
    uint64 by_cause[kTrapCauseCount];
    TrapCause last_cause;
    TrapClass last_class;
    TrapOrigin last_origin;
    uint64 last_val;
    uint64 last_epc;
    uint64 last_scause;
};

namespace arch {
struct TrapFrame;  // Forward declaration (defined in arch/trapframe.h)
}

/*
 * trap_init() — BSP initialization
 *   Sets stvec to kernel_trap_entry (handles traps while in S-mode).
 *   Initializes the global IrqManager.
 *   Called from kernel_main() after VMM and before PLIC.
 */
void trap_init();

/*
 * trap_init_ap() — AP per-CPU initialization
 *   Sets this CPU's stvec.
 */
void trap_init_ap();

/*
 * trap_handle() — MI-layer semantic dispatcher
 *   Called by MD layer after scause → TrapCause translation.
 *   Routes to page fault handler, syscall dispatcher, IRQ manager, etc.
 *
 *   tf:    pointer to the current TrapFrame
 *   info:  translated trap context from MD layer
 */
void trap_handle(arch::TrapFrame* tf, const TrapInfo& info);

/* Trap statistics helpers (MI layer). */
void trap_stats_get(TrapStats* out);
void trap_stats_reset();
