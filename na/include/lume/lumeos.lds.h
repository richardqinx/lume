/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Common Linker Script Macros (Machine-Independent)
 *
 * Shared section definitions that every architecture must emit.
 * Architecture-specific lumeos.lds.S files #include this header
 * and use these macros to avoid duplicating common boilerplate.
 *
 * Modeled after Linux include/asm-generic/vmlinux.lds.h
 * Reference: docs/specs/linker_and_entry.md
 */

#ifndef _LUME_LUMEOS_LDS_H
#define _LUME_LUMEOS_LDS_H

/* ===== Text Section: executable code ===== */
#define TEXT_SECTION                         \
    .text : AT(ADDR(.text) - PAGE_OFFSET) { \
        _stext = .;                         \
        *(.text .text.*)                    \
        _etext = .;                         \
    } = 0

/* ===== Read-Only Data + C++ init_array ===== */
#define RODATA_SECTION                              \
    .rodata : AT(ADDR(.rodata) - PAGE_OFFSET) {     \
        _srodata = .;                               \
        *(.rodata .rodata.*)                        \
        INIT_ARRAY                                  \
        _erodata = .;                               \
    }

/* ===== C++ Global Constructor Table ===== */
#define INIT_ARRAY          \
    . = ALIGN(8);           \
    __init_array_start = .; \
    KEEP(*(.init_array .init_array.*)) \
    __init_array_end = .;

/* ===== Initialized Read-Write Data ===== */
#define DATA_SECTION                            \
    .data : AT(ADDR(.data) - PAGE_OFFSET) {     \
        _sdata = .;                             \
        *(.data .data.*)                        \
        ARCH_DATA_EXTRA                         \
        _edata = .;                             \
    }

/* ===== BSS: Uninitialized Data ===== */
#define BSS_SECTION                             \
    .bss : AT(ADDR(.bss) - PAGE_OFFSET) {       \
        _sbss = .;                              \
        *(.bss .bss.*)                          \
        *(.sbss .sbss.*)                        \
        ARCH_BSS_EXTRA                          \
        _ebss = .;                              \
    }

/* ===== Discard Unwanted Sections ===== */
#define DISCARDS            \
    /DISCARD/ : {           \
        *(.eh_frame .eh_frame_hdr) \
        *(.note .note.*)    \
        *(.comment)         \
    }

/* ===== Kernel Image Boundary ===== */
#define KERNEL_END          \
    . = ALIGN(4096);        \
    _kernel_end = .;

#endif /* _LUME_LUMEOS_LDS_H */
