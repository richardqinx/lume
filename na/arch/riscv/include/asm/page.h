/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _ASM_RISCV_PAGE_H
#define _ASM_RISCV_PAGE_H

/*
 * RISC-V page / virtual-memory layout constants.
 *
 * Mirrors the subset of Linux arch/riscv/include/asm/page.h that LumeOS's
 * early boot path needs:
 *   - PAGE_SIZE / PAGE_SHIFT / PAGE_MASK
 *   - PAGE_OFFSET (start of the higher-half direct map)
 *   - KERNEL_LINK_ADDR (link-time VA of _start)
 *   - SV39 PTE flag bits
 *   - PTRS_PER_PGD (512 for SV39)
 *
 * Values match Linux RISC-V SV39 defaults so that struct kernel_mapping
 * (filled by setup_vm in arch/riscv/mm/init.cc) carries the same numeric
 * relations Linux's mm/init.c maintains.
 */

#define PAGE_SHIFT      12
#define PAGE_SIZE       (1UL << PAGE_SHIFT)
#define PAGE_MASK       (~(PAGE_SIZE - 1))

/* Higher-half base of the kernel direct map.  Bottom of the SV39 supervisor
 * address space minus the unmapped guard region.  Identical to Linux's
 * CONFIG_PAGE_OFFSET default on RV64. */
#define PAGE_OFFSET     0xFFFFFFC000000000UL

/* Where _start was linked.  OpenSBI hands control to PHYS_BASE; the kernel
 * runs at KERNEL_LINK_ADDR after relocate_enable_mmu jumps to higher-half. */
#define PHYS_BASE       0x80200000UL
#define KERNEL_LINK_ADDR 0xFFFFFFC080200000UL

/* SATP mode field — SV39 = 8, shifted to bits [63:60]. */
#define SATP_MODE_SV39  (8UL << 60)

#define PTRS_PER_PGD    512

/* 1 GB superpage size — entry.S used to build the early page table with
 * these; setup_vm in arch/riscv/mm/init.cc now does the same. */
#define PGDIR_SHIFT     30
#define PGDIR_SIZE      (1UL << PGDIR_SHIFT)
#define PGDIR_MASK      (~(PGDIR_SIZE - 1))

/* SV39 PTE flag bits (one byte). */
#define _PAGE_PRESENT   (1UL << 0)  /* aka VALID — historic Linux name */
#define _PAGE_READ      (1UL << 1)
#define _PAGE_WRITE     (1UL << 2)
#define _PAGE_EXEC      (1UL << 3)
#define _PAGE_USER      (1UL << 4)
#define _PAGE_GLOBAL    (1UL << 5)
#define _PAGE_ACCESSED  (1UL << 6)
#define _PAGE_DIRTY     (1UL << 7)

#define PAGE_KERNEL_EXEC \
        (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC | \
         _PAGE_ACCESSED | _PAGE_DIRTY)

#endif /* _ASM_RISCV_PAGE_H */
