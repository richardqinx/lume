/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _LUME_SETUP_H
#define _LUME_SETUP_H

/*
 * Boot-time interfaces called between assembly and C.
 *
 * Mirrors the subset of Linux include/linux/setup.h relevant to LumeOS's
 * Linux-aligned RISC-V boot flow:
 *
 *   setup_vm                  Build early_pg_dir / trampoline_pg_dir before
 *                             the MMU is enabled.  Filled kernel_map for
 *                             all subsequent code to consult.
 *   relocate_enable_mmu       Switch SATP, jump to higher-half, apply
 *                             .rela.dyn via relocate_kernel.
 *   relocate_kernel           Walk .rela.dyn, patch R_RISCV_RELATIVE
 *                             slots with addend + kaslr_offset.
 *
 * kernel_main (LumeOS's equivalent of Linux's start_kernel) is declared
 * in kernel/main.cc and re-declared in arch-side glue — kept local to
 * that file to avoid creating an artificial public API for the lone
 * call site in head.S.
 */

#include <lume/types.h>
#include <asm/pgtable.h>

#ifdef __cplusplus
extern "C" {
#endif

void setup_vm(uintptr_t load_pa, uintptr_t dtb_pa);
void relocate_enable_mmu(pgd_t *pgdir);
void relocate_kernel(void);

#ifdef __cplusplus
}
#endif

#endif /* _LUME_SETUP_H */
