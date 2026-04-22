/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * RISC-V Kernel Linker Script Template
 *
 * This is a C-preprocessed linker script (.lds.S). The build system
 * runs it through CPP to produce the final vmlinux.lds which is
 * passed to the linker.
 *
 * Architecture-specific definitions:
 *   - OUTPUT_ARCH, ENTRY
 *   - PAGE_OFFSET, BASE_ADDRESS, PHYS_BASE
 *   - .head.text placement
 *   - GP anchor (__global_pointer$ for RISC-V medany)
 *   - early_pgdir and boot stacks in .bss
 *
 * Common section macros come from include/lume/vmlinux.lds.h
 *
 * Reference: docs/specs/linker_and_entry.md
 */

#include <lume/lumeos.lds.h>

/* ===== RISC-V Architecture Constants ===== */

OUTPUT_ARCH(riscv)

PAGE_OFFSET  = 0xFFFFFFC000000000;
BASE_ADDRESS = 0xFFFFFFC080200000;
PHYS_BASE    = 0x80200000;

ENTRY(_start)

/* ===== RISC-V: GP anchor in .data (medany model) ===== */
#define ARCH_DATA_EXTRA                         \
    . = ALIGN(16);                              \
    PROVIDE(__global_pointer$ = . + 0x800);     \
    *(.sdata .sdata.*)

/* ===== RISC-V: early page table + per-CPU boot stacks in .bss ===== */
#define ARCH_BSS_EXTRA                          \
    /* Early page table: 4KB aligned, used by entry.S before VMM */ \
    . = ALIGN(4096);                            \
    early_pgdir = .;                            \
    . += 4096;                                  \
    /* Per-CPU boot stacks: 8KB per CPU, max 8 CPUs */              \
    . = ALIGN(4096);                            \
    boot_stack = .;                             \
    . += 8192 * 8;                              \
    boot_stack_top = .;

/* ===== Layout ===== */

SECTIONS {
    . = BASE_ADDRESS;

    /* .head.text: Image Header (must be at byte 0 of the kernel image) */
    .head.text : AT(PHYS_BASE) {
        _start = .;
        KEEP(*(.head.text))
    }

    TEXT_SECTION

    . = ALIGN(4096);

    RODATA_SECTION

    . = ALIGN(4096);

    DATA_SECTION

    . = ALIGN(4096);

    BSS_SECTION

    KERNEL_END

    DISCARDS
}
