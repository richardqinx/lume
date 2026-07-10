/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _ASM_RISCV_PGTABLE_H
#define _ASM_RISCV_PGTABLE_H

/*
 * Early page-table construction API used by arch/riscv/mm/init.cc::setup_vm.
 *
 * Mirrors the create_pgd_mapping interface from Linux's
 * arch/riscv/mm/init.c — same name, same semantics:
 *
 *   create_pgd_mapping(pgdir, va, pa, sz, prot)
 *
 *     pgdir : root of the page table to populate
 *     va    : virtual address to map
 *     pa    : physical address to map to
 *     sz    : mapping size — must be a supported leaf size (PAGE_SIZE,
 *             2 MiB megapage, or 1 GiB gigapage)
 *     prot  : PTE flag bits (PAGE_KERNEL_EXEC etc., from <asm/page.h>)
 *
 * The boot-time variant in this file only supports gigapage (1 GiB)
 * mappings — that is all setup_vm needs for the early_pg_dir / trampoline_pg_dir
 * built before the slab allocator exists.  Finer-grained mappings come
 * later via vmm_init().
 */

#include <lume/types.h>
#include <asm/page.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct { unsigned long pgd; } pgd_t;

/* Linker-provided early page-table storage (defined in lumeos.lds.S
 * ARCH_BSS_EXTRA, lives in .bss so it's zero-initialized).  Allocating
 * them in the linker script — not in C — mirrors Linux and keeps the
 * symbols visible from head.S without a forward C decl mismatch. */
extern pgd_t early_pg_dir[PTRS_PER_PGD];
extern pgd_t trampoline_pg_dir[PTRS_PER_PGD];
extern pgd_t fixmap_pg_dir[PTRS_PER_PGD];

/* Install a single PGD entry mapping `va` → `pa` with size `sz` and PTE
 * flags `prot`.  Only sz == PGDIR_SIZE (1 GiB) is supported in this early
 * variant — vmm_init() takes over with create_pgd_mapping_pmd later. */
void create_pgd_mapping(pgd_t *pgdir, unsigned long va, unsigned long pa,
                        unsigned long sz, unsigned long prot);

#ifdef __cplusplus
}
#endif

#endif /* _ASM_RISCV_PGTABLE_H */
