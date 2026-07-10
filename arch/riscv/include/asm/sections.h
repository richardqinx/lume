/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _ASM_RISCV_SECTIONS_H
#define _ASM_RISCV_SECTIONS_H

/*
 * Linker-emitted symbols that bracket each section of the kernel image.
 *
 * The lumeos.lds.S linker script defines these as the start / end
 * addresses of contiguous regions.  Code that walks a section
 * (relocate_kernel walks .rela.dyn, the C++ ctor loop walks
 * .init_array, the VMM mapping code walks .text vs .rodata, ...)
 * imports the pair via this header.
 *
 * Mirrors Linux arch/riscv/include/asm/sections.h / asm-generic/sections.h.
 * Each name and pair is identical to Linux so that direct ports of mm/init.c
 * relocate_kernel logic compile unchanged against LumeOS.
 */

#ifdef __cplusplus
extern "C" {
#endif

extern char _start[];
extern char _kernel_end[];

extern char _stext[];
extern char _etext[];
extern char _srodata[];
extern char _erodata[];
extern char _sdata[];
extern char _edata[];
extern char _sbss[];
extern char _ebss[];

extern char __init_array_start[];
extern char __init_array_end[];

/* .rela.dyn — array of Elf64_Rela entries emitted by the linker under
 * `-shared -Bsymbolic`.  relocate_kernel walks this range and patches
 * each R_RISCV_RELATIVE slot. */
extern char __rela_dyn_start[];
extern char __rela_dyn_end[];

#ifdef __cplusplus
}
#endif

#endif /* _ASM_RISCV_SECTIONS_H */
