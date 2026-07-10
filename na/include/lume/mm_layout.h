/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * mm_layout.h — User/Kernel address space boundary definitions
 *
 * Single source of truth for the user/kernel VA split.
 * All modules (VMM, uaccess, page fault, tests) MUST include this
 * header instead of defining their own constants.
 *
 * Layout (SV39, RISC-V):
 *   [0x0000_0000_0000, kUserVaLimit)   — User space
 *   [kUserVaLimit, 0xFFFF_FFFF_FFFF)   — Kernel space (direct map, vmemmap, etc.)
 *
 * Reference: docs/specs/linux_abi_mm_plan.md §5
 */

#include <lume/types.h>
#include <lume/config.h>

/* User VA range: [kUserVaBase, kUserVaLimit)
 * kUserVaBase avoids mapping the null page (catch NULL derefs).
 *
 * SV39: user space is the lower half [0, 2^38).  The upper half
 * [0xFFFFFFC000000000, 0xFFFFFFFFFFFFFFFF] is kernel space.
 * Addresses between 2^38 and 0xFFFFFFC000000000 are non-canonical
 * and will always fault — they must never be used.
 *
 * This value MUST match the page table mode selected by the MD layer.
 * If we ever support SV48/SV57, update this accordingly. */
inline constexpr uint64 kUserVaBase  = kPageSize;
inline constexpr uint64 kUserVaLimit = 0x4000000000ULL;  /* 2^38 = 256 GB */

/* Kernel VA starts at the sign-extended upper half */
inline constexpr uint64 kKernelVaBase = 0xFFFFFFC000000000ULL;

/* User stack: sits at the top of the user VA range.
 * Matches Linux STACK_TOP = TASK_SIZE = kUserVaLimit.
 * One guard page below the top, 8 MB stack. */
inline constexpr uint64 kUserStackSize = 8ULL * 1024 * 1024;
inline constexpr uint64 kUserStackTop  = kUserVaLimit - kPageSize;  /* guard page */
inline constexpr uint64 kUserStackBase = kUserStackTop - kUserStackSize;

/*
 * Check whether an address range [addr, addr+len) is entirely
 * within user space. Returns true if valid.
 */
inline bool is_user_range(uint64 addr, uint64 len)
{
    if (addr < kUserVaBase) {
        return false;
    }
    if (addr >= kUserVaLimit) {
        return false;
    }
    if (addr + len < addr) {
        return false;  // Overflow
    }
    if (addr + len > kUserVaLimit) {
        return false;
    }
    return true;
}

/*
 * Check whether a single address is in user space.
 */
inline bool is_user_address(uint64 addr)
{
    return addr >= kUserVaBase && addr < kUserVaLimit;
}
