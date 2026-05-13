/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * User-Kernel Memory Copy — Phase 3 (Exception Tables)
 *
 * Validates user pointers by checking they fall within user address space
 * (below KERNEL_VA_BASE). Uses assembly-level safe copy functions that
 * integrate with the kernel's Exception Table mechanism.
 *
 * Reference: docs/specs/syscall.md §8
 */

#include <lume/uaccess.h>
#include <lume/task.h>
#include <lume/errno.h>
#include <lume/config.h>

/* Kernel VA base — addresses at or above this are kernel space */
inline constexpr uint64 kKernelVABase = 0xFFFFFFC000000000ULL;

extern "C" int __uaccess_memcpy(void* dst, const void* src, uint64 len);
extern "C" int64 __uaccess_strncpy(char* dst, const char* src, uint64 max_len);

/* Validate that [addr, addr+len) is entirely in user space */
static bool is_user_range(uint64 addr, uint64 len)
{
    if (addr >= kKernelVABase)
        return false;
    if (addr + len < addr) /* overflow */
        return false;
    if (addr + len > kKernelVABase)
        return false;
    return true;
}

int copy_from_user(void* kernel_dst, uint64 user_src, uint64 len)
{
    if (len == 0) return 0;
    if (!is_user_range(user_src, len)) return -EFAULT;

    return __uaccess_memcpy(kernel_dst, reinterpret_cast<const void*>(user_src), len);
}

int copy_to_user(uint64 user_dst, const void* kernel_src, uint64 len)
{
    if (len == 0) return 0;
    if (!is_user_range(user_dst, len)) return -EFAULT;

    return __uaccess_memcpy(reinterpret_cast<void*>(user_dst), kernel_src, len);
}

int64 strncpy_from_user(char* kernel_dst, uint64 user_src, uint64 max_len)
{
    if (!is_user_range(user_src, 1)) return -EFAULT;
    
    /* We must also check that the string does not cross into kernel space. 
       This is safely handled by the assembly routine which will fault if it hits
       an unmapped page. However, to strictly respect kKernelVABase, we should
       restrict max_len to the distance to kKernelVABase. */
    uint64 max_allowed = kKernelVABase - user_src;
    if (max_len > max_allowed) {
        max_len = max_allowed;
    }

    return __uaccess_strncpy(kernel_dst, reinterpret_cast<const char*>(user_src), max_len);
}
