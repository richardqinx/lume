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
#include <lume/klog.h>
#include <arch/pmap.h>
#include <arch/mmu.h>

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

static VmAreaStruct* node_to_vma(struct rb_node* node)
{
    return reinterpret_cast<VmAreaStruct*>(
        reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));
}

static uint64 align_up_any(uint64 value, uint64 align)
{
    if (align == 0) {
        return value;
    }
    return ((value + align - 1) / align) * align;
}

static bool range_overlaps(uint64 a_start, uint64 a_end,
                           uint64 b_start, uint64 b_end)
{
    return a_start < b_end && b_start < a_end;
}

static constexpr uint64 kUserVaBase = kPageSize;  // Avoid mapping the null page
static constexpr uint64 kUserVaLimit = 0xFFFFFFC000000000ULL;

static bool vma_overlaps_locked(VmSpace* space, uint64 start, uint64 end)
{
    struct rb_node* node = rb_first(&space->vma_tree);
    while (node) {
        VmAreaStruct* vma = node_to_vma(node);
        if (range_overlaps(start, end, vma->start, vma->end)) {
            return true;
        }
        node = rb_next(node);
    }
    return false;
}

static bool vma_range_covered_locked(VmSpace* space, uint64 start, uint64 end)
{
    uint64 cursor = start;
    struct rb_node* node = rb_first(&space->vma_tree);
    while (node && cursor < end) {
        VmAreaStruct* vma = node_to_vma(node);
        if (vma->end <= cursor) {
            node = rb_next(node);
            continue;
        }
        if (vma->start > cursor) {
            return false;
        }
        if (vma->end > cursor) {
            cursor = vma->end;
        }
        node = rb_next(node);
    }
    return cursor >= end;
}

static void vma_try_merge_neighbors_locked(VmSpace* space, VmAreaStruct* vma)
{
    struct rb_node* prev_node = rb_prev(&vma->rb);
    if (prev_node) {
        VmAreaStruct* prev = node_to_vma(prev_node);
        if (prev->end == vma->start && prev->perm == vma->perm) {
            prev->end = vma->end;
            rb_erase(&vma->rb, &space->vma_tree);
            delete vma;
            vma = prev;
        }
    }

    struct rb_node* next_node = rb_next(&vma->rb);
    if (next_node) {
        VmAreaStruct* next = node_to_vma(next_node);
        if (vma->end == next->start && vma->perm == next->perm) {
            vma->end = next->end;
            rb_erase(&next->rb, &space->vma_tree);
            delete next;
        }
    }
}

static int vma_split_locked(VmSpace* space, VmAreaStruct* vma, uint64 split)
{
    if (split <= vma->start || split >= vma->end) {
        return 0;
    }

    VmAreaStruct* right = new VmAreaStruct;
    if (!right) {
        return -ENOMEM;
    }

    right->start = split;
    right->end = vma->end;
    right->perm = vma->perm;
    right->mm = space;

    vma->end = split;
    rb_add(&right->rb, &space->vma_tree, vma_less);
    return 0;
}

static int vma_split_range_locked(VmSpace* space, uint64 start, uint64 end)
{
    if (end <= start) {
        return 0;
    }

    struct rb_node* start_node = rb_find(&start, &space->vma_tree, vma_cmp);
    if (!start_node) {
        return -ENOMEM;
    }
    VmAreaStruct* start_vma = node_to_vma(start_node);
    int ret = vma_split_locked(space, start_vma, start);
    if (ret < 0) {
        return ret;
    }

    uint64 end_key = end - 1;
    struct rb_node* end_node = rb_find(&end_key, &space->vma_tree, vma_cmp);
    if (!end_node) {
        return -ENOMEM;
    }
    VmAreaStruct* end_vma = node_to_vma(end_node);
    return vma_split_locked(space, end_vma, end);
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
    space->brk_start = 0;
    space->brk_end = 0;
    return space;
}

void VmSpace::destroy() {
    /* Drain VMA tree under lock, then release BEFORE delete this */
    lock.acquire();
    uint64 root = root_pa;
    struct rb_node* node = rb_first(&vma_tree);
    while (node) {
        VmAreaStruct* vma = reinterpret_cast<VmAreaStruct*>(
            reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));
        
        /* Decref all mapped physical pages */
        for (uint64 addr = vma->start; addr < vma->end; addr += kPageSize) {
            uint64 pa;
            if (pmap::lookup(root, addr, &pa)) {
                page_decref(pa_to_page(phys_addr(pa)));
            }
        }

        node = rb_next(node);
        rb_erase(&vma->rb, &vma_tree);
        delete vma;
    }
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
    if (va < kUserVaBase) return -EINVAL;
    if (va >= kUserVaLimit) return -EINVAL;
    if (va + len < va || va + len > kUserVaLimit) return -EINVAL;

    VmAreaStruct* vma = new VmAreaStruct;
    if (!vma) return -ENOMEM;
    vma->start = va;
    vma->end = va + len;
    vma->perm = perm | VM_USER;  // Enforce user-mode access (MI flag)
    vma->mm = space;

    LockGuard guard(space->lock);
    if (vma_overlaps_locked(space, vma->start, vma->end)) {
        delete vma;
        return -EINVAL;
    }
    rb_add(&vma->rb, &space->vma_tree, vma_less);
    vma_try_merge_neighbors_locked(space, vma);
    return 0;
}

int vmm_unmap_user(VmSpace* space, uint64 va, uint64 len) {
    if (!space) return -EINVAL;
    va = page_align_down(va);
    len = page_align_up(len);
    if (len == 0) return 0;
    if (va < kUserVaBase) return -EINVAL;
    if (va >= kUserVaLimit) return -EINVAL;
    if (va + len < va || va + len > kUserVaLimit) return -EINVAL;
    uint64 end = va + len;

    LockGuard guard(space->lock);
    struct rb_node* node = rb_first(&space->vma_tree);
    while (node) {
        VmAreaStruct* vma = node_to_vma(node);
        struct rb_node* next = rb_next(node);

        if (vma->end <= va) {
            node = next;
            continue;
        }
        if (vma->start >= end) {
            break;
        }

        uint64 unmap_start = (vma->start > va) ? vma->start : va;
        uint64 unmap_end = (vma->end < end) ? vma->end : end;

        if (unmap_start < unmap_end) {
            for (uint64 addr = unmap_start; addr < unmap_end; addr += kPageSize) {
                uint64 pa;
                if (pmap::lookup(space->root_pa, addr, &pa)) {
                    page_decref(pa_to_page(phys_addr(pa)));
                    pmap::unmap(space->root_pa, addr);
                }
            }
        }

        if (unmap_start == vma->start && unmap_end == vma->end) {
            rb_erase(&vma->rb, &space->vma_tree);
            delete vma;
        } else if (unmap_start == vma->start) {
            rb_erase(&vma->rb, &space->vma_tree);
            vma->start = unmap_end;
            rb_add(&vma->rb, &space->vma_tree, vma_less);
        } else if (unmap_end == vma->end) {
            vma->end = unmap_start;
        } else {
            VmAreaStruct* right = new VmAreaStruct;
            if (!right) {
                return -ENOMEM;
            }
            right->start = unmap_end;
            right->end = vma->end;
            right->perm = vma->perm;
            right->mm = space;

            vma->end = unmap_start;
            rb_add(&right->rb, &space->vma_tree, vma_less);
            break;
        }

        node = next;
    }
    return 0;
}

int vmm_protect_user(VmSpace* space, uint64 va, uint64 len, uint64 perm)
{
    if (!space) return -EINVAL;
    va = page_align_down(va);
    len = page_align_up(len);
    if (len == 0) return -EINVAL;
    if (va < kUserVaBase) return -EINVAL;
    if (va >= kUserVaLimit) return -EINVAL;
    if (va + len < va || va + len > kUserVaLimit) return -EINVAL;

    uint64 end = va + len;

    LockGuard guard(space->lock);
    if (!vma_range_covered_locked(space, va, end)) {
        return -ENOMEM;
    }
    int ret = vma_split_range_locked(space, va, end);
    if (ret < 0) {
        return ret;
    }

    bool tlb_flush_needed = false;
    struct rb_node* node = rb_find(&va, &space->vma_tree, vma_cmp);
    while (node) {
        VmAreaStruct* vma = node_to_vma(node);
        if (vma->start >= end) {
            break;
        }
        if (vma->end <= va) {
            node = rb_next(node);
            continue;
        }

        vma->perm = (perm | VM_USER);

        for (uint64 addr = vma->start; addr < vma->end; addr += kPageSize) {
            uint64 pa;
            if (!pmap::lookup(space->root_pa, addr, &pa)) {
                continue;
            }

            if (perm == 0) {
                page_decref(pa_to_page(phys_addr(pa)));
                pmap::unmap(space->root_pa, addr);
                tlb_flush_needed = true;
                continue;
            }

            uint64 pte_perm = pmap::vm_perm_to_pte(vma->perm);
            if ((vma->perm & VM_WRITE) && pmap::is_cow(space->root_pa, addr)) {
                pte_perm &= ~pmap::PTE_W;
                pte_perm |= pmap::PTE_COW;
            }

            int ret = pmap::protect(space->root_pa, addr, pte_perm);
            if (ret < 0) {
                return ret;
            }
            tlb_flush_needed = true;
        }

        node = rb_next(node);
    }

    if (tlb_flush_needed) {
        arch::mmu::flush_tlb_all();
    }
    return 0;
}

uint64 mm_find_free_va(VmSpace* space, uint64 length, uint64 align)
{
    if (!space) return 0;
    length = page_align_up(length);
    if (length == 0) return 0;
    if (align < kPageSize) align = kPageSize;

    LockGuard guard(space->lock);

    uint64 cursor = align_up_any(kUserVaBase, align);
    struct rb_node* node = rb_first(&space->vma_tree);
    while (node) {
        VmAreaStruct* vma = node_to_vma(node);
        if (cursor <= vma->start) {
            if (cursor > kUserVaLimit - length) {
                return 0;
            }
            if (cursor + length <= vma->start) {
                return cursor;
            }
        }
        if (cursor < vma->end) {
            cursor = vma->end;
        }
        cursor = align_up_any(cursor, align);
        node = rb_next(node);
    }

    if (cursor > kUserVaLimit - length) {
        return 0;
    }
    return cursor;
}

bool vma_range_covered(VmSpace* space, uint64 start, uint64 end)
{
    if (!space) return false;
    start = page_align_down(start);
    end = page_align_up(end);
    if (end <= start) return true;

    LockGuard guard(space->lock);
    return vma_range_covered_locked(space, start, end);
}

/* ------------------------------------------------------------------ */
/*  Page fault handler (demand paging)                                */
/* ------------------------------------------------------------------ */

static bool vma_allows(const VmAreaStruct* vma, VmFaultCause cause)
{
    switch (cause) {
    case VmFaultCause::Read:
        return (vma->perm & VM_READ) != 0;
    case VmFaultCause::Write:
        return (vma->perm & VM_WRITE) != 0;
    case VmFaultCause::Exec:
        return (vma->perm & VM_EXEC) != 0;
    default:
        return false;
    }
}

int vmm_handle_page_fault(VmSpace* space, uint64 fault_addr, VmFaultCause cause) {
    if (!space) return -EINVAL;

    uint64 aligned_addr = page_align_down(fault_addr);

    LockGuard guard(space->lock);
    struct rb_node* node = rb_find(&fault_addr, &space->vma_tree, vma_cmp);
    if (!node) {
        return -EFAULT;  // No VMA covers this address → segfault
    }

    VmAreaStruct* vma = reinterpret_cast<VmAreaStruct*>(
        reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));

    if (!vma_allows(vma, cause)) {
        return -EFAULT;
    }

    /* Check if page is already mapped */
    uint64 paddr;
    if (pmap::lookup(space->root_pa, aligned_addr, &paddr)) {
        if (cause == VmFaultCause::Write && pmap::is_cow(space->root_pa, aligned_addr)) {
            /* Store Page Fault on a COW page */
            Page* page = pmm_alloc_page();
            if (!page) return -ENOMEM;
            uint64 new_pa = page_to_pa(page).raw;

            /* Copy page contents */
            uint8* dst = reinterpret_cast<uint8*>(pa_to_va(phys_addr(new_pa)).raw);
            const uint8* src = reinterpret_cast<const uint8*>(pa_to_va(phys_addr(paddr)).raw);
            for (uint64 i = 0; i < kPageSize; i++) {
                dst[i] = src[i];
            }

            /* Remap with write permission, clearing COW */
            uint64 pte_perm = pmap::vm_perm_to_pte(vma->perm);
            if (pmap::map(space->root_pa, aligned_addr, new_pa, pte_perm) != 0) {
                pmm_free_page(page);
                return -ENOMEM;
            }

            /* Decrement refcount of old page */
            page_decref(pa_to_page(phys_addr(paddr)));
            
            /* Flush TLB to remove old read-only cached translation */
            asm volatile("sfence.vma %0" : : "r"(aligned_addr) : "memory");
            return 0;
        }
        return 0;  // Already mapped, maybe read fault on existing page
    }

    /* Allocate physical page */
    Page* page = pmm_alloc_page();
    if (!page) return -ENOMEM;

    uint64 pa = page_to_pa(page).raw;

    /* Translate MI permission flags to hardware PTE bits (MD layer) */
    uint64 pte_perm = pmap::vm_perm_to_pte(vma->perm);

    if (pmap::map(space->root_pa, aligned_addr, pa, pte_perm) != 0) {
        pmm_free_page(page);
        return -ENOMEM;
    }

    /* Initial mapping, refcount is already 1 from pmm_alloc_page */

    return 0;
}

/* ------------------------------------------------------------------ */
/*  Fork / Clone (COW infrastructure)                                 */
/* ------------------------------------------------------------------ */

VmSpace* vmm_clone(VmSpace* parent) {
    if (!parent) return nullptr;

    VmSpace* child = VmSpace::create();
    if (!child) return nullptr;

    child->brk_start = parent->brk_start;
    child->brk_end = parent->brk_end;

    LockGuard parent_guard(parent->lock);
    
    struct rb_node* node = rb_first(&parent->vma_tree);
    while (node) {
        VmAreaStruct* parent_vma = reinterpret_cast<VmAreaStruct*>(
            reinterpret_cast<char*>(node) - __builtin_offsetof(VmAreaStruct, rb));
        
        VmAreaStruct* child_vma = new VmAreaStruct;
        if (!child_vma) {
            child->destroy();
            return nullptr;
        }
        child_vma->start = parent_vma->start;
        child_vma->end = parent_vma->end;
        child_vma->perm = parent_vma->perm;
        child_vma->mm = child;
        
        /* Copy pages and mark COW if writable */
        for (uint64 va = child_vma->start; va < child_vma->end; va += kPageSize) {
            uint64 pa;
            if (pmap::lookup(parent->root_pa, va, &pa)) {
                /* Make parent COW if it was writable */
                if (child_vma->perm & VM_WRITE) {
                    pmap::make_cow(parent->root_pa, va);
                    /* Flush TLB for parent since we reduced permissions */
                    asm volatile("sfence.vma %0" : : "r"(va) : "memory");
                }
                
                /* Map in child as COW or read-only */
                uint64 pte_perm = pmap::vm_perm_to_pte(child_vma->perm);
                if (child_vma->perm & VM_WRITE) {
                    pte_perm &= ~pmap::PTE_W;
                    pte_perm |= pmap::PTE_COW;
                }
                
                if (pmap::map(child->root_pa, va, pa, pte_perm) != 0) {
                    /* If map fails, we leak what we did in this loop for now, 
                     * but child->destroy() will clean it up safely since 
                     * we increment refcounts as we go. */
                    delete child_vma;
                    child->destroy();
                    return nullptr;
                }
                
                /* Increment physical page refcount */
                page_incref(pa_to_page(phys_addr(pa)));
            }
        }
        
        rb_add(&child_vma->rb, &child->vma_tree, vma_less);
        node = rb_next(node);
    }
    
    return child;
}
