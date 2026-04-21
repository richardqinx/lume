/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Machine-Independent Address Conversion Helpers
 *
 * All PA↔VA conversions in MI code (mm/, kernel/, etc.) must go through
 * these functions.  The actual offset is provided by <arch/config.h>.
 *
 * Reference: docs/specs/00_conventions.md §1.1 (MI/MD separation)
 */

#include <lume/types.h>
#include <lume/config.h>
#include <arch/config.h>

/* Convert physical address to kernel virtual address */
inline uint64 pa_to_va(uint64 pa)
{
    return pa + arch::kVAOffset;
}

/* Convert kernel virtual address to physical address */
inline uint64 va_to_pa(uint64 va)
{
    return va - arch::kVAOffset;
}

/* Check if an address is a kernel virtual address */
inline bool is_kernel_va(uint64 addr)
{
    return addr >= arch::kVAOffset;
}

/* Convert an address that might be VA or PA to PA */
inline uint64 ensure_pa(uint64 addr)
{
    return is_kernel_va(addr) ? va_to_pa(addr) : addr;
}

/* Convert an address that might be VA or PA to VA */
inline uint64 ensure_va(uint64 addr)
{
    return is_kernel_va(addr) ? addr : pa_to_va(addr);
}

/* Align up to page boundary */
inline uint64 page_align_up(uint64 addr)
{
    return (addr + kPageSize - 1) & ~(kPageSize - 1);
}

/* Align down to page boundary */
inline uint64 page_align_down(uint64 addr)
{
    return addr & ~(kPageSize - 1);
}

/* Convert physical address to page frame number (PFN) */
inline uint64 pa_to_pfn(uint64 pa)
{
    return pa / kPageSize;
}

/* Convert page frame number (PFN) to physical address */
inline uint64 pfn_to_pa(uint64 pfn)
{
    return pfn * kPageSize;
}
