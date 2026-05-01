/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * pmap.cc — SV39 page table operations (MD layer)
 *
 * Implements the pmap namespace interface for RISC-V SV39.
 * 3-level page table: VPN[2] (9 bits) -> VPN[1] (9 bits) -> VPN[0] (9 bits)
 * Each level is a 4KB page containing 512 PTEs of 8 bytes each.
 *
 * Address conversion: all page table operations work with physical addresses.
 * To read/write page table entries we must convert PA to VA via pa_to_va().
 *
 * Reference: docs/specs/vmm.md
 */

#include <lume/types.h>
#include <lume/addr.h>
#include <lume/config.h>
#include <lume/pmm.h>
#include <arch/mmu.h>
#include <lume/klog.h>

namespace pmap {

/* PTE bit definitions */
inline constexpr uint64 PTE_V = 1ULL << 0;
inline constexpr uint64 PTE_R = 1ULL << 1;
inline constexpr uint64 PTE_W = 1ULL << 2;
inline constexpr uint64 PTE_X = 1ULL << 3;
inline constexpr uint64 PTE_U = 1ULL << 4;
inline constexpr uint64 PTE_G = 1ULL << 5;
inline constexpr uint64 PTE_A = 1ULL << 6;
inline constexpr uint64 PTE_D = 1ULL << 7;

/* SV39: 3 levels, 9 bits per level, 12-bit page offset */
inline constexpr int kLevels = 3;
inline constexpr int kPtePerPage = 512;

/* Extract VPN[level] from a virtual address */
static inline uint64 vpn(uint64 va, int level)
{
    return (va >> (12 + 9 * level)) & 0x1FF;
}

/* Extract PA from a PTE */
static inline uint64 pte_to_pa(uint64 pte)
{
    return ((pte >> 10) & 0xFFFFFFFFFFFULL) << 12;
}

/* Create a PTE from a PA and flags */
static inline uint64 pa_to_pte(uint64 pa, uint64 flags)
{
    return ((pa >> 12) << 10) | flags;
}

/* Convert PA to kernel VA for accessing page table contents */
static inline uint64 *pa_to_ptr(uint64 pa)
{
    return reinterpret_cast<uint64 *>(pa_to_va(pa));
}

/* Allocate a zeroed page for a page table level.
 * Returns PA of the new page, or 0 on failure. */
static uint64 alloc_pt_page()
{
    Frame *f = pmm_alloc_frame();
    if (!f)
        return 0;
    uint64 pa = frame_to_pa(f);
    /* Zero the page */
    uint64 *ptr = pa_to_ptr(pa);
    for (int i = 0; i < kPtePerPage; i++)
        ptr[i] = 0;
    return pa;
}

uint64 create()
{
    return alloc_pt_page();
}

void destroy(uint64 root_pa)
{
    uint64 *l2 = pa_to_ptr(root_pa);
    for (int i = 0; i < kPtePerPage; i++) {
        if (!(l2[i] & PTE_V))
            continue;
        /* Non-leaf L2 entry? (no R/W/X bits = pointer to L1 table) */
        if (!(l2[i] & (PTE_R | PTE_W | PTE_X))) {
            uint64 l1_pa = pte_to_pa(l2[i]);
            uint64 *l1 = pa_to_ptr(l1_pa);
            for (int j = 0; j < kPtePerPage; j++) {
                if (!(l1[j] & PTE_V))
                    continue;
                if (!(l1[j] & (PTE_R | PTE_W | PTE_X))) {
                    /* L0 page table */
                    uint64 l0_pa = pte_to_pa(l1[j]);
                    pmm_free_frame(pa_to_frame(l0_pa));
                }
            }
            pmm_free_frame(pa_to_frame(l1_pa));
        }
    }
    pmm_free_frame(pa_to_frame(root_pa));
}

int map(uint64 root_pa, uint64 va, uint64 pa, uint64 perm)
{
    uint64 *table = pa_to_ptr(root_pa);

    /* Walk levels 2 -> 1, creating intermediate tables as needed */
    for (int level = 2; level > 0; level--) {
        uint64 idx = vpn(va, level);
        if (!(table[idx] & PTE_V)) {
            uint64 child_pa = alloc_pt_page();
            if (!child_pa)
                return -12; /* -ENOMEM */
            table[idx] = pa_to_pte(child_pa, PTE_V);
        }
        table = pa_to_ptr(pte_to_pa(table[idx]));
    }

    /* Level 0: install the leaf PTE */
    uint64 idx = vpn(va, 0);
    table[idx] = pa_to_pte(pa, perm | PTE_V | PTE_A | PTE_D);
    return 0;
}

void unmap(uint64 root_pa, uint64 va)
{
    uint64 *table = pa_to_ptr(root_pa);
    for (int level = 2; level > 0; level--) {
        uint64 idx = vpn(va, level);
        if (!(table[idx] & PTE_V))
            return;
        table = pa_to_ptr(pte_to_pa(table[idx]));
    }
    table[vpn(va, 0)] = 0;
}

bool lookup(uint64 root_pa, uint64 va, uint64 *pa_out)
{
    uint64 *table = pa_to_ptr(root_pa);
    for (int level = 2; level >= 0; level--) {
        uint64 idx = vpn(va, level);
        uint64 pte = table[idx];
        if (!(pte & PTE_V))
            return false;
        /* Leaf PTE? (has R, W, or X) */
        if (pte & (PTE_R | PTE_W | PTE_X)) {
            if (pa_out)
                *pa_out = pte_to_pa(pte);
            return true;
        }
        table = pa_to_ptr(pte_to_pa(pte));
    }
    return false;
}

void activate(uint64 root_pa)
{
    arch::mmu::set_page_table(root_pa);
    arch::mmu::flush_tlb_all();
}

uint64 vm_perm_to_pte(uint64 vm_perm)
{
    /* Translate MI VM_* flags to SV39 PTE bits.
     * The MI flags are defined in <lume/vmm.h>. */
    uint64 pte = PTE_V | PTE_A | PTE_D;  // Valid + Accessed + Dirty (avoid HW A/D faults)
    if (vm_perm & (1ULL << 0)) pte |= PTE_R;  // VM_READ
    if (vm_perm & (1ULL << 1)) pte |= PTE_W;  // VM_WRITE
    if (vm_perm & (1ULL << 2)) pte |= PTE_X;  // VM_EXEC
    if (vm_perm & (1ULL << 3)) pte |= PTE_U;  // VM_USER
    return pte;
}

} // namespace pmap
