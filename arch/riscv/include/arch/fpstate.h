/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * FPU State — Floating-Point Register Context
 *
 * Pre-reserved structure for RISC-V F/D extension floating-point state.
 * MUST be allocated in every TaskControlBlock so that future FPU
 * save/restore logic has a stable destination without restructuring TCB.
 *
 * RISC-V F/D extension state:
 *   - 32 FP registers (f0-f31), each 64 bits for D extension
 *   - fcsr (Floating-point Control and Status Register)
 *
 * sstatus.FS field management:
 *   - FS=0 (Off):    FPU disabled, any FP instruction traps
 *   - FS=1 (Initial): FPU enabled, registers are initial state
 *   - FS=2 (Clean):  FPU enabled, registers not modified since last save
 *   - FS=3 (Dirty):  FPU enabled, registers modified (need save)
 *
 * Current status: Structure defined, save/restore NOT implemented.
 * When implemented, trap_dispatch and swtch.S will use lazy
 * save/restore based on sstatus.FS dirty tracking.
 *
 * Reference: RISC-V ISA Manual §3.1.6.5 (FS field)
 */

#include <lume/types.h>

namespace arch {

struct FpState {
    uint64 f[32];       // f0-f31 (64-bit each for D extension)
    uint32 fcsr;        // Floating-point CSR (frm + fflags)
    uint32 _pad;        // Alignment padding
};

static_assert(sizeof(FpState) == 32 * 8 + 8, "FpState must be 264 bytes");

/*
 * sstatus.FS field constants
 */
inline constexpr uint64 kSstatusFS_Off     = 0ULL << 13;
inline constexpr uint64 kSstatusFS_Initial = 1ULL << 13;
inline constexpr uint64 kSstatusFS_Clean   = 2ULL << 13;
inline constexpr uint64 kSstatusFS_Dirty   = 3ULL << 13;
inline constexpr uint64 kSstatusFS_Mask    = 3ULL << 13;

/*
 * Check if sstatus indicates FPU state is dirty (needs save).
 */
inline bool fpu_state_dirty(uint64 sstatus) {
    return (sstatus & kSstatusFS_Mask) == kSstatusFS_Dirty;
}

/*
 * Check if FPU is enabled (FS != Off).
 */
inline bool fpu_enabled(uint64 sstatus) {
    return (sstatus & kSstatusFS_Mask) != kSstatusFS_Off;
}

}  // namespace arch

/* Assembly routines for FPU register save/restore (fpu.S) */
extern "C" void fpu_save(arch::FpState* state);
extern "C" void fpu_restore(arch::FpState* state);

namespace arch {

/*
 * Read sstatus.FS field (current FPU state)
 */
inline uint64 fpu_get_fs() {
    uint64 sstatus;
    __asm__ volatile("csrr %0, sstatus" : "=r"(sstatus));
    return sstatus & kSstatusFS_Mask;
}

/*
 * Set sstatus.FS field.
 * @fs: one of kSstatusFS_Off, kSstatusFS_Initial, kSstatusFS_Clean, kSstatusFS_Dirty
 */
inline void fpu_set_fs(uint64 fs) {
    __asm__ volatile(
        "csrc sstatus, %0\n"
        "csrs sstatus, %1\n"
        :: "r"(kSstatusFS_Mask), "r"(fs)
    );
}

}  // namespace arch
