/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * LumeOS Kernel Linker Script
 *
 * Memory Layout (SV39 Higher-Half Kernel):
 *   Virtual Base:  0xFFFFFFC080200000
 *   Physical Base: 0x80200000
 *   VA-PA Offset:  0xFFFFFFC000000000 (PAGE_OFFSET)
 *
 * The AT() directives produce correct LMA (Load Memory Address) so the
 * bootloader loads sections at their physical addresses while the kernel
 * code references their virtual addresses.
 *
 * Reference: docs/specs/linker_and_entry.md
 */

OUTPUT_ARCH(riscv)

PAGE_OFFSET  = 0xFFFFFFC000000000;
BASE_ADDRESS = 0xFFFFFFC080200000;
PHYS_BASE    = 0x80200000;

/* ELF entry point must be the PHYSICAL address because OpenSBI/QEMU
 * jumps to it before MMU is enabled. _start is at VMA, so we use
 * the computed physical equivalent. */
ENTRY(_start)

SECTIONS {
    . = BASE_ADDRESS;

    /* ===== .head.text: Image Header (must be at byte 0) ===== */
    .head.text : AT(PHYS_BASE) {
        _start = .;
        KEEP(*(.head.text))
    }

    /* ===== .text: Executable Code ===== */
    .text : AT(ADDR(.text) - PAGE_OFFSET) {
        _stext = .;
        *(.text .text.*)
        _etext = .;
    } = 0

    . = ALIGN(4096);

    /* ===== .rodata: Read-Only Data ===== */
    .rodata : AT(ADDR(.rodata) - PAGE_OFFSET) {
        _srodata = .;
        *(.rodata .rodata.*)

        /* C++ global constructor table (.init_array) */
        . = ALIGN(8);
        __init_array_start = .;
        KEEP(*(.init_array .init_array.*))
        __init_array_end = .;

        _erodata = .;
    }

    . = ALIGN(4096);

    /* ===== .data: Initialized Read-Write Data ===== */
    .data : AT(ADDR(.data) - PAGE_OFFSET) {
        _sdata = .;
        *(.data .data.*)

        /* GP anchor: RISC-V medany model uses gp-relative addressing
         * for .sdata/.sbss within +/- 2KB of __global_pointer$ */
        . = ALIGN(16);
        PROVIDE(__global_pointer$ = . + 0x800);
        *(.sdata .sdata.*)

        _edata = .;
    }

    . = ALIGN(4096);

    /* ===== .bss: Uninitialized Data (zeroed by entry.S) ===== */
    .bss : AT(ADDR(.bss) - PAGE_OFFSET) {
        _sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)

        /* Early page table: 4KB aligned, used by entry.S before VMM */
        . = ALIGN(4096);
        early_pgdir = .;
        . += 4096;

        /* Per-CPU boot stacks: 8KB per CPU, max 8 CPUs */
        . = ALIGN(4096);
        boot_stack = .;
        . += 8192 * 8;      /* NCPU_MAX = 8, BOOT_STACK_SIZE = 8KB */
        boot_stack_top = .;

        _ebss = .;
    }

    . = ALIGN(4096);

    /* ===== End of kernel image ===== */
    _kernel_end = .;

    /* Discard unwanted sections */
    /DISCARD/ : {
        *(.eh_frame .eh_frame_hdr)
        *(.note .note.*)
        *(.comment)
    }
}