// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Richard Qin
//
// arch/riscv/kernel/asm-offsets.c — emit struct field offsets and
// scalar constants for consumption by assembly sources (head.S etc.).
//
// 1:1 with Linux arch/riscv/kernel/asm-offsets.c.  The Makefile
// compiles this to an .s file (not .o) and runs
// scripts/extract-asm-offsets.sed over the output to produce
// include/generated/asm-offsets.h.
//
// Adding a new offset: include the struct's header, add an OFFSET()
// or DEFINE() line below, rebuild.  head.S can then reference the
// generated #define directly.

#include <lume/kbuild.h>
#include <lume/kernel_map.h>

void asm_offsets(void)
{
    COMMENT("LumeOS asm-offsets — struct kernel_mapping field offsets");
    OFFSET(KERNEL_MAP_VIRT_ADDR,            kernel_mapping, virt_addr);
    OFFSET(KERNEL_MAP_VIRT_OFFSET,          kernel_mapping, virt_offset);
    OFFSET(KERNEL_MAP_PHYS_ADDR,            kernel_mapping, phys_addr);
    OFFSET(KERNEL_MAP_SIZE,                 kernel_mapping, size);
    OFFSET(KERNEL_MAP_VA_PA_OFFSET,         kernel_mapping, va_pa_offset);
    OFFSET(KERNEL_MAP_PAGE_OFFSET,          kernel_mapping, page_offset);
    OFFSET(KERNEL_MAP_VA_KERNEL_PA_OFFSET,  kernel_mapping, va_kernel_pa_offset);
}
