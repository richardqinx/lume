/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * vma.cc — Virtual Memory Area management (MI layer)
 *
 * Manages user address spaces using a red-black tree of VMA regions.
 * Implements demand paging: vmm_map_user records intent only;
 * physical pages are allocated on page fault via vmm_handle_page_fault.
 *
 * MI/MD separation: this file NEVER references pmap::PTE_* constants.
 * Permission translation is delegated to pmap::vm_perm_to_pte().
 *
 * Reference: docs/specs/vmm.md
 */

#include <lume/vmm.h>
#include <lume/addr.h>
#include <lume/config.h>
#include <lume/errno.h>
#include <lume/pmm.h>
#include <lume/new.h>
#include <lume/panic.h>
#include <arch/pmap.h>

/* ------------------------------------------------------------------ */
/*  Rbtree callbacks for VMA interval tree                            */
/* ------------------------------------------------------------------ */

static bool vma_less(struct rb_node* node, const struct rb_node* parent) {
    VmAreaStruct* n = reinterpret_cast<VmAreaStruct*>(
        reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));
    const VmAreaStruct* p = reinterpret_cast<const VmAreaStruct*>(
        reinterpret_cast<const char*>(parent) - __builtin_offsetof(VmAreaStruct, rb));
    return n->start < p->start;
}

static int vma_cmp(const void* key, const struct rb_node* node) {
    uint64 addr = *static_cast<const uint64*>(key);
    const VmAreaStruct* n = reinterpret_cast<const VmAreaStruct*>(
        reinterpret_cast<const char*>(node) - __builtin_offsetof(VmAreaStruct, rb));
    if (addr < n->start) return -1;
    if (addr >= n->end) return 1;
    return 0;
}

/* ------------------------------------------------------------------ */
/*  VmSpace lifecycle                                                 */
/* ------------------------------------------------------------------ */

VmSpace* VmSpace::create() {
    VmSpace* space = new VmSpace;
    if (!space) return nullptr;

    space->root_pa = pmap::create();
    if (!space->root_pa) {
        delete space;
        return nullptr;
    }

    space->vma_tree = RB_ROOT;
    space->lock.init("VmSpace");
    return space;
}

void VmSpace::destroy() {
    /* Drain VMA tree under lock, then release BEFORE delete this */
    lock.acquire();
    struct rb_node* node = rb_first(&vma_tree);
    while (node) {
        VmAreaStruct* vma = reinterpret_cast<VmAreaStruct*>(
            reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));
        node = rb_next(node);
        rb_erase(&vma->rb, &vma_tree);
        delete vma;
    }
    uint64 root = root_pa;
    lock.release();

    /* Destroy hardware page tables outside the lock */
    pmap::destroy(root);

    /* Finally free VmSpace itself */
    delete this;
}

/* ------------------------------------------------------------------ */
/*  Public API: VMA manipulation                                      */
/* ------------------------------------------------------------------ */

int vmm_map_user(VmSpace* space, uint64 va, uint64 len, uint64 perm) {
    if (!space) return -EINVAL;

    va = page_align_down(va);
    len = page_align_up(len);
    if (len == 0) return 0;

    VmAreaStruct* vma = new VmAreaStruct;
    if (!vma) return -ENOMEM;
    vma->start = va;
    vma->end = va + len;
    vma->perm = perm | VM_USER;  // Enforce user-mode access (MI flag)
    vma->mm = space;

    LockGuard guard(space->lock);
    rb_add(&vma->rb, &space->vma_tree, vma_less);
    return 0;
}

int vmm_unmap_user(VmSpace* space, uint64 va, uint64 len) {
    if (!space) return -EINVAL;
    va = page_align_down(va);
    len = page_align_up(len);
    uint64 end = va + len;

    LockGuard guard(space->lock);
    struct rb_node* node = rb_first(&space->vma_tree);
    while (node) {
        VmAreaStruct* vma = reinterpret_cast<VmAreaStruct*>(
            reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));
        struct rb_node* nxt = rb_next(node);
        if (vma->start >= va && vma->end <= end) {
            rb_erase(node, &space->vma_tree);
            delete vma;
        }
        node = nxt;
    }
    return 0;
}

/* ------------------------------------------------------------------ */
/*  Page fault handler (demand paging)                                */
/* ------------------------------------------------------------------ */

int vmm_handle_page_fault(VmSpace* space, uint64 fault_addr, uint64 cause) {
    if (!space) return -EINVAL;

    uint64 aligned_addr = page_align_down(fault_addr);

    LockGuard guard(space->lock);
    struct rb_node* node = rb_find(&fault_addr, &space->vma_tree, vma_cmp);
    if (!node) {
        return -EFAULT;  // No VMA covers this address → segfault
    }

    VmAreaStruct* vma = reinterpret_cast<VmAreaStruct*>(
        reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));

    (void)cause;  // TODO: differentiate read/write/exec faults

    /* Check if page is already mapped */
    uint64 paddr;
    if (pmap::lookup(space->root_pa, aligned_addr, &paddr)) {
        return 0;  // Already mapped
    }

    /* Allocate physical frame */
    Frame* f = pmm_alloc_frame();
    if (!f) return -ENOMEM;

    uint64 pa = frame_to_pa(f);

    /* Translate MI permission flags to hardware PTE bits (MD layer) */
    uint64 pte_perm = pmap::vm_perm_to_pte(vma->perm);

    if (pmap::map(space->root_pa, aligned_addr, pa, pte_perm) != 0) {
        pmm_free_frame(f);
        return -ENOMEM;
    }

    return 0;
}

/* ------------------------------------------------------------------ */
/*  Fork / Clone (stub — requires COW infrastructure)                 */
/* ------------------------------------------------------------------ */

VmSpace* vmm_clone(VmSpace* parent) {
    (void)parent;
    return nullptr;
}
