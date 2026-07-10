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
#include <lume/addr_types.h>
#include <arch/config.h>

/* Convert physical address to kernel virtual address (direct map). */
inline VirtAddr pa_to_va(PhysAddr pa)
{
    return VirtAddr{pa.raw + arch::g_direct_map_base};
}

/* Convert kernel virtual address to physical address (direct map). */
inline PhysAddr va_to_pa(VirtAddr va)
{
    return PhysAddr{va.raw - arch::g_direct_map_base};
}

/*
 * Early-boot conversions pinned to the bootstrap direct-map base.
 *
 * Use these only before vmm_init() activates the final kernel page table.
 * They are required when KASLR has already randomized g_direct_map_base,
 * but the CPU is still running on the bootstrap mapping built in entry.S.
 */
inline VirtAddr boot_pa_to_va(PhysAddr pa)
{
    return VirtAddr{pa.raw + arch::kDirectMapBaseDefault};
}

inline PhysAddr boot_va_to_pa(VirtAddr va)
{
    return PhysAddr{va.raw - arch::kDirectMapBaseDefault};
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

inline PhysAddr page_align_up(PhysAddr addr)
{
    return PhysAddr{page_align_up(addr.raw)};
}

inline PhysAddr page_align_down(PhysAddr addr)
{
    return PhysAddr{page_align_down(addr.raw)};
}

inline VirtAddr page_align_up(VirtAddr addr)
{
    return VirtAddr{page_align_up(addr.raw)};
}

inline VirtAddr page_align_down(VirtAddr addr)
{
    return VirtAddr{page_align_down(addr.raw)};
}

/* Convert physical address to page frame number (PFN) */
inline Pfn pa_to_pfn(PhysAddr pa)
{
    return Pfn{pa.raw / kPageSize};
}

/* Convert page frame number (PFN) to physical address */
inline PhysAddr pfn_to_pa(Pfn pfn)
{
    return PhysAddr{pfn.raw * kPageSize};
}
