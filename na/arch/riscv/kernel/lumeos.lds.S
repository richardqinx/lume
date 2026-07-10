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

/* ===== RISC-V: page-table storage + per-CPU boot stacks in .bss =====
 *
 * Linux RISC-V layout (arch/riscv/kernel/vmlinux.lds.S):
 *   early_pg_dir       — first early page table built by setup_vm,
 *                        used for the rest of boot after MMU enable
 *   trampoline_pg_dir  — single-page table used only during the SATP
 *                        switch from physical to higher-half VA; its
 *                        identity + virt mappings of _start must both
 *                        be valid in the same instruction window
 *   fixmap_pg_dir      — covers the FIXADDR_START range used by the
 *                        early console (UART MMIO before kernel page
 *                        table proper is built)
 *
 * All three are allocated here so head.S can take their addresses without
 * a C definition; their PA == VA mapping covers them during setup_vm.
 */
#define ARCH_BSS_EXTRA                          \
    . = ALIGN(4096);                            \
    early_pg_dir = .;                           \
    . += 4096;                                  \
    trampoline_pg_dir = .;                      \
    . += 4096;                                  \
    fixmap_pg_dir = .;                          \
    . += 4096;                                  \
    /* Legacy name retained for any caller still referencing it; */ \
    /* points at the same first 4 KiB as early_pg_dir. */            \
    early_pgdir = early_pg_dir;                 \
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

    /* .rela.dyn lives between .text and .rodata so it ends up in the
     * read-only PT_LOAD segment.  Mirrors Linux vmlinux.lds.S where
     * .rela.dyn sits at the tail of init data, just before RO_DATA. */
    RELA_DYN_SECTION

    . = ALIGN(4096);

    RODATA_SECTION

    . = ALIGN(4096);

    DATA_SECTION

    . = ALIGN(8);

    /* .got lives right after .data in the RW PT_LOAD.  All other
     * dynamic-linker artefacts (.plt, .dynamic, .dynsym, .dynstr,
     * .hash, .gnu.hash, .interp, .dynbss) are discarded by the
     * DISCARDS macro — mirrors Linux arch/riscv/kernel/vmlinux.lds.S. */
    GOT_SECTION

    . = ALIGN(4096);

    /* End of file-backed image (BSS follows as NOBITS) */
    __lume_image_end = .;

    BSS_SECTION

    KERNEL_END

    DISCARDS
}
