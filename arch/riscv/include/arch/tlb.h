/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

namespace arch::tlb {

/*
 * Perform a cross-CPU TLB flush (shootdown).
 *
 * @param cpu_mask: Bitmask of CPUs to target.
 * @param start:    Start virtual address, or 0 for full address space.
 * @param size:     Size in bytes, or ~0ULL for full address space.
 */
void flush_remote(uint64 cpu_mask, uint64 start, uint64 size);

} // namespace arch::tlb
