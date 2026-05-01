/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

namespace arch::sbi {

struct sbiret {
    long error;
    long value;
};

static inline sbiret sbi_ecall(int ext, int fid, uint64 arg0, uint64 arg1, uint64 arg2, uint64 arg3, uint64 arg4, uint64 arg5) {
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
                     : "+r"(a0), "=r"(a1)
                     : "r"(a2), "r"(a3), "r"(a4), "r"(a5), "r"(a6), "r"(a7)
                     : "memory");
    ret.error = static_cast<long>(a0);
    ret.value = static_cast<long>(a1);
    return ret;
}

static inline void set_timer(uint64 stime_value) {
    // Standard SBI TIME Extension (EID 0x54494D45)
    sbi_ecall(0x54494D45, 0, stime_value, 0, 0, 0, 0, 0);
}

} // namespace arch::sbi
