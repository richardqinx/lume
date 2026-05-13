/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Memory Management System Calls
 *
 * Implements: brk, mmap (anonymous only), munmap, mprotect.
 *
 * Reference: docs/specs/syscall.md §7.2
 */

#include <lume/types.h>
#include <lume/task.h>
#include <lume/vmm.h>
#include <lume/errno.h>
#include <lume/mman.h>
#include <lume/config.h>


/* Page alignment helpers */
static inline uint64 page_align_up(uint64 x)
{
    return (x + kPageSize - 1) & ~(kPageSize - 1);
}

static inline uint64 page_align_down(uint64 x)
{
    return x & ~(kPageSize - 1);
}

/* ======================================================================
 * sys_brk
 * ====================================================================== */

int64 sys_brk(uint64 new_brk, uint64, uint64, uint64, uint64, uint64)
{
    VmSpace* mm = current_task()->mm;
    if (!mm)
        return -ENOMEM; /* kernel threads have no user address space */

    if (new_brk == 0) {
        return static_cast<int64>(mm->brk_end);
    }

    if (mm->brk_start == 0) {
        uint64 init_brk = page_align_up(new_brk);
        mm->brk_start = init_brk;
        mm->brk_end = init_brk;
    }

    if (new_brk < mm->brk_start) {
        return -EINVAL;
    }

    uint64 new_end = page_align_up(new_brk);
    if (new_end > mm->brk_end) {
        uint64 grow = new_end - mm->brk_end;
        int ret = vmm_map_user(mm, mm->brk_end, grow, VM_READ | VM_WRITE);
        if (ret < 0) {
            return ret;
        }
    } else if (new_end < mm->brk_end) {
        uint64 shrink = mm->brk_end - new_end;
        int ret = vmm_unmap_user(mm, new_end, shrink);
        if (ret < 0) {
            return ret;
        }
    }

    mm->brk_end = new_end;
    return static_cast<int64>(new_brk);
}

/* ======================================================================
 * sys_mmap
 * ====================================================================== */

int64 sys_mmap(uint64 addr, uint64 length, uint64 prot,
               uint64 flags, uint64 fd, uint64 offset)
{
    if (length == 0) return -EINVAL;
    length = page_align_up(length);
    if (offset % kPageSize != 0) return -EINVAL;

    if ((flags & MAP_PRIVATE) && (flags & MAP_SHARED)) return -EINVAL;
    if (!(flags & MAP_PRIVATE) && !(flags & MAP_SHARED)) return -EINVAL;

    VmSpace* mm = current_task()->mm;
    if (!mm) return -ENOMEM;

    /* Phase 2: only anonymous private mappings */
    if (!(flags & MAP_ANONYMOUS))
        return -ENOSYS; /* File-backed mmap is Phase 3 */
    if (flags & MAP_SHARED)
        return -ENOSYS; /* Shared mappings are Phase 3 */

    (void)fd;

    /* Convert POSIX prot → MI permission flags */
    uint64 vm_perm = 0;
    if (prot & PROT_READ)  vm_perm |= VM_READ;
    if (prot & PROT_WRITE) vm_perm |= VM_WRITE;
    if (prot & PROT_EXEC)  vm_perm |= VM_EXEC;
    vm_perm |= VM_USER;

    uint64 va = addr;
    if (flags & MAP_FIXED) {
        if (va % kPageSize != 0) return -EINVAL;
    } else if (va != 0) {
        va = page_align_down(va);
    }

    if (va == 0) {
        va = mm_find_free_va(mm, length, kPageSize);
        if (!va) return -ENOMEM;
    }

    if (flags & MAP_FIXED) {
        int ret = vmm_unmap_user(mm, va, length);
        if (ret < 0) return ret;
    }

    int ret = vmm_map_user(mm, va, length, vm_perm);
    if (ret < 0 && !(flags & MAP_FIXED) && addr != 0) {
        uint64 fallback = mm_find_free_va(mm, length, kPageSize);
        if (!fallback) return ret;
        ret = vmm_map_user(mm, fallback, length, vm_perm);
        if (ret < 0) return ret;
        va = fallback;
    } else if (ret < 0) {
        return ret;
    }

    return static_cast<int64>(va);
}

/* ======================================================================
 * sys_munmap
 * ====================================================================== */

int64 sys_munmap(uint64 addr, uint64 length, uint64, uint64, uint64, uint64)
{
    if (length == 0) return -EINVAL;
    if (addr % kPageSize != 0) return -EINVAL;
    length = page_align_up(length);

    VmSpace* mm = current_task()->mm;
    if (!mm) return -EINVAL;

    return vmm_unmap_user(mm, addr, length);
}

/* ======================================================================
 * sys_mprotect — Phase 2 stub
 * ====================================================================== */

int64 sys_mprotect(uint64 addr, uint64 len, uint64 prot,
                   uint64, uint64, uint64)
{
    if (len == 0) return -EINVAL;
    if (addr % kPageSize != 0) return -EINVAL;

    VmSpace* mm = current_task()->mm;
    if (!mm) return -ENOMEM;

    uint64 vm_perm = 0;
    if (prot & PROT_READ)  vm_perm |= VM_READ;
    if (prot & PROT_WRITE) vm_perm |= VM_WRITE;
    if (prot & PROT_EXEC)  vm_perm |= VM_EXEC;

    return vmm_protect_user(mm, addr, len, vm_perm);
}
