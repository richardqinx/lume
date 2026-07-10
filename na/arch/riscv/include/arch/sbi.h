/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * sbi.h — RISC-V Supervisor Binary Interface (SBI) wrappers
 *
 * Provides inline ecall wrappers for SBI calls from S-mode.
 * Uses the SBI v1.0+ extension-based calling convention.
 *
 * Reference: RISC-V SBI Specification v2.0
 */

#include <lume/types.h>

namespace arch::sbi {

struct sbiret {
    long error;
    long value;
};

/* SBI error codes */
inline constexpr long SBI_SUCCESS               =  0;
inline constexpr long SBI_ERR_NOT_SUPPORTED     = -2;

/* Extension IDs */
inline constexpr int SBI_EXT_TIME   = 0x54494D45;  /* "TIME" */
inline constexpr int SBI_EXT_IPI    = 0x735049;    /* "sPI"  */
inline constexpr int SBI_EXT_RFENCE = 0x52464E43;  /* "RFNC" */
inline constexpr int SBI_EXT_HSM    = 0x48534D;    /* "HSM"  */

static inline sbiret sbi_ecall(int ext, int fid, uint64 arg0 = 0,
                                uint64 arg1 = 0, uint64 arg2 = 0,
                                uint64 arg3 = 0, uint64 arg4 = 0,
                                uint64 arg5 = 0) {
    sbiret ret;
    register uint64 a0 asm("a0") = arg0;
    register uint64 a1 asm("a1") = arg1;
    register uint64 a2 asm("a2") = arg2;
    register uint64 a3 asm("a3") = arg3;
    register uint64 a4 asm("a4") = arg4;
    register uint64 a5 asm("a5") = arg5;
    register uint64 a6 asm("a6") = fid;
    register uint64 a7 asm("a7") = ext;
    __asm__ volatile("ecall"
                     : "+r"(a0), "+r"(a1)
                     : "r"(a2), "r"(a3), "r"(a4), "r"(a5), "r"(a6), "r"(a7)
                     : "memory");
    ret.error = static_cast<long>(a0);
    ret.value = static_cast<long>(a1);
    return ret;
}

/* ---- Timer Extension (EID 0x54494D45) ---- */

static inline void set_timer(uint64 stime_value) {
    sbi_ecall(SBI_EXT_TIME, 0, stime_value);
}

/* ---- IPI Extension (EID 0x735049) ---- */

/*
 * sbi_send_ipi — Send S-mode software interrupt to target harts
 *
 * @hart_mask:      bitmask of target harts (relative to hart_mask_base)
 * @hart_mask_base: base hart ID for the mask (0 = harts 0-63)
 */
static inline sbiret sbi_send_ipi(uint64 hart_mask,
                                   uint64 hart_mask_base = 0) {
    return sbi_ecall(SBI_EXT_IPI, 0, hart_mask, hart_mask_base);
}

/* ---- Remote Fence Extension (EID 0x52464E43) ---- */

/*
 * sbi_remote_sfence_vma — Execute SFENCE.VMA on target harts
 *
 * @hart_mask/base: target harts
 * @start_addr:     start of VA range to invalidate
 * @size:           size of range (use ~0UL for full flush)
 */
static inline sbiret sbi_remote_sfence_vma(uint64 hart_mask,
                                            uint64 hart_mask_base,
                                            uint64 start_addr,
                                            uint64 size) {
    return sbi_ecall(SBI_EXT_RFENCE, 1,
                     hart_mask, hart_mask_base,
                     start_addr, size);
}

/* ---- HSM Extension (EID 0x48534D) ---- */

/*
 * sbi_hart_start — Start (wake) a hart that is in STOPPED state
 *
 * @hartid:      target hart ID to start
 * @start_addr:  PHYSICAL address where the hart should begin execution
 * @opaque:      passed in a1 register to the hart (e.g. FDT pointer)
 *
 * OpenSBI v1.0+ parks non-boot harts; they must be explicitly started.
 */
static inline sbiret sbi_hart_start(uint64 hartid,
                                     uint64 start_addr,
                                     uint64 opaque) {
    return sbi_ecall(SBI_EXT_HSM, 0, hartid, start_addr, opaque);
}

} // namespace arch::sbi

