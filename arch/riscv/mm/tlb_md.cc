/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <arch/tlb.h>
#include <arch/sbi.h>

namespace arch::tlb {

void flush_remote(uint64 cpu_mask, uint64 start, uint64 size) {
    if (size == ~0ULL) {
        arch::sbi::sbi_remote_sfence_vma(cpu_mask, 0, 0, ~0UL);
    } else {
        arch::sbi::sbi_remote_sfence_vma(cpu_mask, 0, start, size);
    }
}

} // namespace arch::tlb
