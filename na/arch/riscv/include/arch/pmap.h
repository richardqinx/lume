/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * pmap — SV39 page table interface (MD layer)
 *
 * Namespace functions, zero runtime overhead.
 * Implementation: arch/riscv/mm/pmap.cc
 *
 * Reference: docs/specs/vmm.md §3.2
 */

#include <lume/types.h>

namespace pmap {

/* PTE permission bits */
inline constexpr uint64 PTE_V = 1ULL << 0;
inline constexpr uint64 PTE_R = 1ULL << 1;
inline constexpr uint64 PTE_W = 1ULL << 2;
inline constexpr uint64 PTE_X = 1ULL << 3;
inline constexpr uint64 PTE_U = 1ULL << 4;
inline constexpr uint64 PTE_G = 1ULL << 5;
inline constexpr uint64 PTE_A = 1ULL << 6;
inline constexpr uint64 PTE_D = 1ULL << 7;

uint64 create();
void destroy(uint64 root_pa);
int map(uint64 root_pa, uint64 va, uint64 pa, uint64 perm);
int map_2mb(uint64 root_pa, uint64 va, uint64 pa, uint64 perm);
void unmap(uint64 root_pa, uint64 va);
bool lookup(uint64 root_pa, uint64 va, uint64* pa_out);
void activate(uint64 root_pa);

/*
 * Translate MI-layer VM_* permission flags to hardware PTE bits.
 * Called by vma.cc when faulting in a page.
 */
uint64 vm_perm_to_pte(uint64 vm_perm);

} // namespace pmap
