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

/* ===== Text Section: executable code =====
 *
 * .init.text is merged into the main .text segment so PC-relative `la`
 * from regular code can call __init helpers without a thunk.  Linux
 * keeps a separate .init.text only to reclaim the pages after boot —
 * LumeOS doesn't yet reclaim, so the merge is harmless and avoids an
 * extra PT_LOAD entry. */
#define TEXT_SECTION                         \
    .text : AT(ADDR(.text) - PAGE_OFFSET) { \
        _stext = .;                         \
        *(.text .text.*)                    \
        *(.init.text .init.text.*)          \
        *(.fixup)                           \
        _etext = .;                         \
    } = 0

/* ===== Read-Only Data + C++ init_array + initramfs =====
 *
 * Layout invariants:
 *   - extable / init_array / driver_array / initramfs all live INSIDE
 *     .rodata between _srodata and _erodata so the VMM has one R-only
 *     mapping to manage.
 *   - The relocation table (.lume.reloc) is NOT in here — it lives in
 *     its own padded output section (see RELOC_SECTION) so that its
 *     two-pass-build size variance can't shift downstream offsets.
 *     (Putting it in .rodata caused a heisenbug where pre-link offsets
 *     used by gen_reloc.py didn't match post-link offsets after the
 *     reloc.o blob was inserted.)
 */
#define RODATA_SECTION                              \
    .rodata : AT(ADDR(.rodata) - PAGE_OFFSET) {     \
        _srodata = .;                               \
        *(.rodata .rodata.*)                        \
        *(.srodata .srodata.* .srodata.cst*)        \
        . = ALIGN(8);                               \
        __extable_start = .;                        \
        KEEP(*(.extable))                           \
        __extable_end = .;                          \
        INIT_ARRAY                                  \
        DRIVER_ARRAY                                \
        /* Embedded initramfs CPIO archive */       \
        . = ALIGN(8);                               \
        __initramfs_start = .;                      \
        KEEP(*(.init.ramfs))                        \
        __initramfs_end = .;                        \
        . = ALIGN(4096);                            \
        _erodata = .;                               \
    }

/* ===== .rel.dyn / .rela.dyn — Linker-emitted RELA relocations =====
 *
 * Mirrors arch/riscv/kernel/vmlinux.lds.S §101-109: the .rela.dyn
 * section sits BETWEEN init data and .rodata so it lands in a
 * read-only PT_LOAD segment alongside .text/.rodata.  The companion
 * dynamic-linker bookkeeping (.dynamic, .dynsym, .dynstr, .hash,
 * .gnu.hash) lives in the RW segment AFTER .data — Linux does the
 * same under #ifdef CONFIG_RELOCATABLE (§139-147). */
#define RELA_DYN_SECTION                                    \
    .rel.dyn : AT(ADDR(.rel.dyn) - PAGE_OFFSET) {           \
        *(.rel.dyn*)                                        \
    }                                                       \
    .rela.dyn : AT(ADDR(.rela.dyn) - PAGE_OFFSET) ALIGN(8) {\
        __rela_dyn_start = .;                               \
        *(.rela .rela*)                                     \
        __rela_dyn_end = .;                                 \
    }

/* ===== GOT — kept; everything else dynamic-linker is discarded =====
 *
 * Strict mirror of arch/riscv/kernel/vmlinux.lds.S in Linux: the only
 * dynamic-linker artefact the kernel keeps is `.got` (it's referenced
 * by every -fPIE compiled global access).  `.plt .dynamic .dynsym
 * .dynstr .hash .gnu.hash .interp .dynbss` are all sent to /DISCARD/
 * via the DISCARDS macro below — the kernel never invokes a dynamic
 * linker (head.S walks .rela.dyn directly).
 *
 * Keeping .plt was the cause of two distinct bugs:
 *   1. PLT trampoline target for an undefined symbol (selftest_reloc
 *      after we removed test_reloc.cc) was unresolved → jumps to a
 *      slot that re-jumps to itself → instruction page fault.
 *   2. .plt carries X permission; living in the same PT_LOAD as .data
 *      forces the load segment to RWX, which `ld` warns about.
 *
 * Sit in the same PT_LOAD as .data because .got is RW. */
#define GOT_SECTION                                                  \
    .got : AT(ADDR(.got) - PAGE_OFFSET) { *(.got*) }

/* ===== Embedded initramfs (CPIO archive) ===== */
#define INITRAMFS_SECTION                               \
    .init.ramfs : AT(ADDR(.init.ramfs) - PAGE_OFFSET) { \
        . = ALIGN(8);                                   \
        __initramfs_start = .;                          \
        KEEP(*(.init.ramfs))                            \
        __initramfs_end = .;                            \
    }

/* ===== C++ Global Constructor Table ===== */
#define INIT_ARRAY          \
    . = ALIGN(8);           \
    __init_array_start = .; \
    KEEP(*(.init_array .init_array.*)) \
    __init_array_end = .;

/* ===== Driver Registration Table ===== */
#define DRIVER_ARRAY                \
    . = ALIGN(8);                   \
    PROVIDE(__drivers_start = .);   \
    KEEP(*(.drivers))               \
    PROVIDE(__drivers_end = .);

/* ===== Initialized Read-Write Data =====
 *
 * .init.data is merged into .data for the same reason TEXT_SECTION
 * absorbs .init.text — LumeOS doesn't yet reclaim __init pages, so
 * splitting them gains nothing while costing a PT_LOAD entry. */
#define DATA_SECTION                            \
    .data : AT(ADDR(.data) - PAGE_OFFSET) {     \
        _sdata = .;                             \
        *(.data .data.*)                        \
        *(.init.data .init.data.*)              \
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

/* ===== Discard Unwanted Sections =====
 *
 * Mirrors arch/riscv/kernel/vmlinux.lds.S in Linux:
 *   /DISCARD/ : {
 *       *(.dynbss)
 *       *(.dynstr*)
 *       *(.dynamic*)
 *       *(.plt*)
 *       *(.interp*)
 *       *(.eh_frame)
 *       *(.note.GNU-stack)
 *   }
 *
 * Why each is safe to discard:
 *   .plt          — -Bsymbolic resolves all internal refs at link time;
 *                   any remaining PLT entry is an undefined symbol that
 *                   the kernel would have crashed on anyway.
 *   .dynamic etc. — kernel doesn't invoke a dynamic linker; head.S
 *                   walks __rela_dyn_start..__rela_dyn_end manually.
 *   .interp       — no PT_INTERP at runtime.
 *   .eh_frame*    — no C++ exceptions in kernel (-fno-exceptions).
 *   .note.*       — boot-time identification metadata, unused. */
#define DISCARDS                    \
    /DISCARD/ : {                   \
        *(.dynbss)                  \
        *(.dynstr*)                 \
        *(.dynamic*)                \
        *(.dynsym*)                 \
        *(.hash*) *(.gnu.hash*)     \
        *(.plt*)                    \
        *(.interp*)                 \
        *(.eh_frame .eh_frame_hdr)  \
        *(.note .note.*)            \
        *(.comment)                 \
    }

/* ===== Kernel Image Boundary ===== */
#define KERNEL_END          \
    . = ALIGN(4096);        \
    _kernel_end = .;

#endif /* _LUME_LUMEOS_LDS_H */
