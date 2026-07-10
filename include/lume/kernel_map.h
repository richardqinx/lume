/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _LUME_KERNEL_MAP_H
#define _LUME_KERNEL_MAP_H

/*
 * struct kernel_mapping — where the kernel image lives in physical and
 * virtual memory.  Field names and order match Linux's
 * arch/riscv/include/asm/page.h struct kernel_mapping so that:
 *
 *   1.  arch/riscv/kernel/head.S can do  `la a1, kernel_map`  then
 *       `REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)` and read the virtual
 *       address.  The KERNEL_MAP_* asm constants come from
 *       <generated/asm-offsets.h>, produced by arch/riscv/kernel/
 *       asm-offsets.c at build time — re-order the struct and the
 *       asm offsets follow automatically.
 *
 *   2.  arch/riscv/mm/init.c (Linux origin) populates the same fields
 *       with the same semantics so no source edits are needed.
 */

#ifndef __ASSEMBLY__

#include <lume/types.h>

#ifdef __cplusplus
extern "C" {
#endif

struct kernel_mapping {
    unsigned long virt_addr;
    unsigned long virt_offset;
    uintptr_t     phys_addr;
    uintptr_t     size;
    unsigned long va_pa_offset;
    unsigned long page_offset;
    unsigned long va_kernel_pa_offset;
};

extern struct kernel_mapping kernel_map;

#ifdef __cplusplus
}
#endif

#else  /* __ASSEMBLY__ */

/* Assembly sees only the field offsets, picked up from the generated
 * header.  Including the C struct above would be a parse error. */
#include <generated/asm-offsets.h>

#endif /* __ASSEMBLY__ */

#endif /* _LUME_KERNEL_MAP_H */
