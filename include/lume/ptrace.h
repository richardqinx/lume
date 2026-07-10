/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * PtRegs — Linux-compatible user register context
 *
 * This structure MUST match the Linux RISC-V pt_regs layout exactly.
 * It is the canonical representation for:
 *   - Signal frame construction (ucontext / sigcontext)
 *   - ptrace(GETREGS/SETREGS)
 *   - /proc/<pid>/regs
 *
 * The internal TrapFrame (arch/trapframe.h) has a DIFFERENT layout
 * optimized for fast trap entry/exit.  Conversion between the two
 * is done via trapframe_to_pt_regs() / pt_regs_to_trapframe().
 *
 * Reference: Linux arch/riscv/include/asm/ptrace.h
 */

#include <lume/types.h>

struct PtRegs {
    uint64 epc;        // Program counter at trap
    uint64 ra;         // x1
    uint64 sp;         // x2
    uint64 gp;         // x3
    uint64 tp;         // x4
    uint64 t0;         // x5
    uint64 t1;         // x6
    uint64 t2;         // x7
    uint64 s0;         // x8
    uint64 s1;         // x9
    uint64 a0;         // x10
    uint64 a1;         // x11
    uint64 a2;         // x12
    uint64 a3;         // x13
    uint64 a4;         // x14
    uint64 a5;         // x15
    uint64 a6;         // x16
    uint64 a7;         // x17
    uint64 s2;         // x18
    uint64 s3;         // x19
    uint64 s4;         // x20
    uint64 s5;         // x21
    uint64 s6;         // x22
    uint64 s7;         // x23
    uint64 s8;         // x24
    uint64 s9;         // x25
    uint64 s10;        // x26
    uint64 s11;        // x27
    uint64 t3;         // x28
    uint64 t4;         // x29
    uint64 t5;         // x30
    uint64 t6;         // x31
    /* CSRs */
    uint64 status;     // sstatus
    uint64 badaddr;    // stval
    uint64 cause;      // scause
    /* Syscall bookkeeping */
    uint64 orig_a0;    // a0 value before syscall (for restart)
};

static_assert(sizeof(PtRegs) == 36 * 8, "PtRegs must be 288 bytes (Linux ABI)");

/*
 * Convert between internal TrapFrame and Linux-ABI PtRegs.
 * These are the ONLY places that know both layouts.
 * Future TrapFrame restructuring only needs to update these two functions.
 */
namespace arch { struct TrapFrame; }

void trapframe_to_pt_regs(PtRegs* dst, const arch::TrapFrame* src,
                          uint64 scause, uint64 stval);
void pt_regs_to_trapframe(arch::TrapFrame* dst, const PtRegs* src);
