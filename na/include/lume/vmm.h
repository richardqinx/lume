/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * vmm.h — Virtual Memory Manager
 *
 * Managing kernel and user virtual address spaces.
 * 
 * Reference: docs/specs/vmm.md
 */

#include <lume/types.h>
#include <lume/rbtree.h>
#include <kernel/sync/spinlock.h>

/* ------------------------------------------------------------------ */
/*  MI-layer permission flags (architecture-independent)               */
/*                                                                     */
/*  These are used by VMA and vmm_map_user / vmm_handle_page_fault.    */
/*  The pmap MD layer translates them to hardware PTE bits.            */
/* ------------------------------------------------------------------ */
inline constexpr uint64 VM_READ  = (1ULL << 0);
inline constexpr uint64 VM_WRITE = (1ULL << 1);
inline constexpr uint64 VM_EXEC  = (1ULL << 2);
inline constexpr uint64 VM_USER  = (1ULL << 3);

enum class VmFaultCause : uint8 {
    Read  = 0,
    Write = 1,
    Exec  = 2,
};

/* Forward declarations */
struct VmSpace;
struct VmAreaStruct;

/*
 * Virtual Memory Area (VMA)
 * Represents a contiguous range [start, end) of uniform permissions.
 */
struct VmAreaStruct {
    uint64 start;           // Start VA (page aligned)
    uint64 end;             // End VA (exclusive, page aligned)
    uint64 perm;            // VM_READ | VM_WRITE | VM_EXEC | VM_USER
    struct rb_node rb;      // Linkage in VmSpace::vma_tree
    VmSpace* mm;            // Back pointer to the parent address space
};

/*
 * Address Space (VmSpace)
 * Represents a user process's complete virtual memory mapping.
 *
 * Lock contract:
 *   Holds: lock (internal spinlock)
 *   May acquire: PMM global lock (via pmm_alloc_page inside page fault)
 *   Callers must NOT hold: PMM lock (lock ordering: VmSpace -> PMM)
 */
struct VmSpace {
    uint64 root_pa;         // SV39 root page table physical address
    struct rb_root vma_tree; // Red-black tree of VmAreaStructs
    Spinlock lock;          // Protects vma_tree mutations

    uint64 brk_start;        // Start of heap (page-aligned)
    uint64 brk_end;          // Current heap end (page-aligned)
    
    // Create a brand new VmSpace (allocates root pagetable)
    static VmSpace* create();
    
    // Destroy VmSpace, unmapping all VMAs and freeing pagetables
    void destroy();
};

/* Initialize kernel page table (Phase 1) */
void vmm_init();

/* Switch AP to the kernel page table built by BSP (Phase 1) */
void vmm_init_ap();

/* Map MMIO device region to the active kernel page table */
void vmm_map_kernel_mmio(uint64 pa, uint64 size);

/* Query page_map allocation (set by vmm_init, read by pmm_init).
 * Returns the PA, byte size, and page count of the vmemmap region. */
uint64 vmm_get_page_map_pa();
uint64 vmm_get_page_map_size();
uint64 vmm_get_num_pages();

/* User space memory management (VMA & Demand Paging) */
int vmm_map_user(VmSpace* space, uint64 va, uint64 len, uint64 perm);
int vmm_unmap_user(VmSpace* space, uint64 va, uint64 len);
int vmm_protect_user(VmSpace* space, uint64 va, uint64 len, uint64 perm);

/* VMA helpers for mmap/mprotect implementations */
uint64 mm_find_free_va(VmSpace* space, uint64 length, uint64 align);
bool vma_range_covered(VmSpace* space, uint64 start, uint64 end);

/* Handle user page fault (lookup VMA -> allocate page -> map) */
int vmm_handle_page_fault(VmSpace* space, uint64 fault_addr, VmFaultCause cause);

/* Clone an address space for fork() */
VmSpace* vmm_clone(VmSpace* parent_space);
