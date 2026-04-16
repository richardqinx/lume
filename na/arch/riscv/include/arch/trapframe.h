/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Trap Frame Structure (RISC-V 64)
 *
 * Saved/restored by the assembly trap_vector on every interrupt,
 * exception, or system call. Contains the full CPU snapshot needed
 * to resume execution after trap handling.
 *
 * Layout must match the assembly offsets in trap_vector.S exactly.
 * Reference: docs/specs/arch_abstraction.md §3.2
 */

/*
 * TrapFrame field offsets for use in assembly.
 * These must be kept in sync with the struct layout below.
 * Placed before any C++ code so assembly can #include this file.
 */
#define TF_KERNEL_SATP    0
#define TF_KERNEL_SP      8
#define TF_KERNEL_TRAP   16
#define TF_KERNEL_CPUID  24
#define TF_EPC           32
#define TF_SSTATUS       40
#define TF_RA            48
#define TF_SP            56
#define TF_GP            64
#define TF_TP            72
#define TF_T0            80
#define TF_T1            88
#define TF_T2            96
#define TF_T3           104
#define TF_T4           112
#define TF_T5           120
#define TF_T6           128
#define TF_S0           136
#define TF_S1           144
#define TF_S2           152
#define TF_S3           160
#define TF_S4           168
#define TF_S5           176
#define TF_S6           184
#define TF_S7           192
#define TF_S8           200
#define TF_S9           208
#define TF_S10          216
#define TF_S11          224
#define TF_A0           232
#define TF_A1           240
#define TF_A2           248
#define TF_A3           256
#define TF_A4           264
#define TF_A5           272
#define TF_A6           280
#define TF_A7           288
#define TF_SIZE         296

#ifndef __ASSEMBLER__

#include <lume/types.h>

namespace arch {

struct TrapFrame {
    /* ---- Kernel metadata (offset 0-39) ---- */
    uint64 kernel_satp;     // 0:  Kernel page table (written to satp on trap entry)
    uint64 kernel_sp;       // 8:  Top of kernel stack for this task
    uint64 kernel_trap;     // 16: Address of C++ trap_handler function
    uint64 kernel_cpu_id;   // 24: CPU ID (loaded into tp on trap entry)
    uint64 epc;             // 32: Interrupted instruction address (sepc)

    /* ---- CSR backup (offset 40-47) ---- */
    uint64 sstatus;         // 40: Privilege status (SPP, SPIE bits)

    /* ---- General-purpose registers (offset 48-295) ---- */
    uint64 ra;              // 48:  x1  - Return address
    uint64 sp;              // 56:  x2  - User stack pointer
    uint64 gp;              // 64:  x3  - Global pointer
    uint64 tp;              // 72:  x4  - Thread pointer
    uint64 t[7];            // 80:  x5-x7, x28-x31 (t0-t6, caller-saved temporaries)
    uint64 s[12];           // 136: x8-x9, x18-x27 (s0-s11, callee-saved)
    uint64 a[8];            // 232: x10-x17 (a0-a7, arguments / syscall params)
};

static_assert(sizeof(TrapFrame) == 296, "TrapFrame size mismatch with assembly offsets");

}  // namespace arch

#endif /* __ASSEMBLER__ */
