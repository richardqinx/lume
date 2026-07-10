/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * RISC-V kernel entry — Linux-aligned layout.
 *
 * Flow (mirrors arch/riscv/kernel/head.S in Linux):
 *
 *   _start                          [.head.text, byte 0 of image]
 *     · 64-byte Boot Protocol Image Header
 *     · j real_start
 *
 *   real_start                      [.text]
 *     · save a0 (hartid) / a1 (dtb_pa)
 *     · setup gp / per-hart sp
 *     · BSP/AP election via amoswap
 *     · BSP:   clear BSS, call setup_vm, then relocate_enable_mmu
 *     · AP:    spin-wait, then relocate_enable_mmu
 *
 *   relocate_enable_mmu  [C function, arch/riscv/mm/init.cc]
 *     · csrw satp <- trampoline_pg_dir
 *     · jump to higher-half VA
 *     · csrw satp <- early_pg_dir
 *     · slide sp/ra/gp to higher-half
 *     · call relocate_kernel  (walks .rela.dyn, patches R_RISCV_RELATIVE)
 *
 *   real_start (continued in higher-half)
 *     · BSP only: call early_cpp_init (walks .init_array)
 *     · call kernel_main(hartid, dtb_pa)
 *
 * Register contract from OpenSBI / U-Boot:
 *   a0 = hart ID
 *   a1 = FDT physical base
 */

#include <lume/config.h>

#define PAGE_OFFSET     0xFFFFFFC000000000
#define BOOT_STACK_SIZE 8192

/* ========================================================================
 * .head.text — RISC-V Boot Protocol Image Header
 *
 * Layout per Documentation/arch/riscv/boot-image-header.rst:
 *   code0/code1 (8 B)  : executable code, lands at PC after OpenSBI hand-off
 *   text_offset (8 B)  : load offset from RAM base
 *   image_size  (8 B)  : effective image size (0 = unknown)
 *   flags       (8 B)  : bit 0: endian
 *   version     (4 B)  : major.minor
 *   res1/res2   (4+8)  : reserved
 *   magic       (8 B)  : "RISCV\0\0\0"
 *   magic2      (4 B)  : "RSC\x05"
 *   res3        (4 B)  : PE/COFF reserved
 * ======================================================================== */
    .section .head.text, "ax"
    .globl _start
_start:
    j       real_start              /* code0 */
    .word   0                       /* code1 */
    .dword  0x200000                /* text_offset */
    .dword  0                       /* image_size (post-link) */
    .dword  0                       /* flags */
    .word   0x0002                  /* version 0.2 */
    .word   0                       /* res1 */
    .dword  0                       /* res2 */
    .dword  0x5643534952            /* magic "RISCV\0\0\0" */
    .word   0x05435352              /* magic2 "RSC\x05" */
    .word   0                       /* res3 */

/* ========================================================================
 * real_start — all harts land here at physical PC
 * ======================================================================== */
    .text
    .globl real_start
real_start:
    /* DEBUG: 'R<hartid>\n' — UART direct at 0x10000000, MMU off. */
    li      t0, 0x10000000
    li      t1, 'R'
    sb      t1, 0(t0)
    addi    t1, a0, '0'
    sb      t1, 0(t0)
    li      t1, '\n'
    sb      t1, 0(t0)

    /* Mask interrupts and supervisor pending bits. */
    csrw    sie, zero
    csrw    sip, zero

    /* gp for medany — relax must be disabled across the `la`. */
    .option push
    .option norelax
    la      gp, __global_pointer$
    .option pop

    /* per-hart boot stack: sp = boot_stack + (hartid + 1) * STACK_SIZE */
    la      t0, boot_stack
    li      t1, BOOT_STACK_SIZE
    addi    t2, a0, 1
    mul     t1, t1, t2
    add     sp, t0, t1

    /* Save hartid / dtb_pa in callee-saved regs preserved across calls. */
    mv      tp, a0                  /* tp = hartid */
    mv      s0, a1                  /* s0 = dtb_pa */

    /* BSP/AP election: first hart to swap bsp_elected 0→1 is BSP. */
    la      t0, bsp_elected
    li      t1, 1
    amoswap.w.aq t2, t1, (t0)
    bnez    t2, .Lap_wait           /* prev != 0 → we're an AP */

    /* === BSP path === */
    la      t0, bsp_hart_id
    sw      a0, 0(t0)

    li      t3, 0x10000000
    li      t4, 'B'
    sb      t4, 0(t3)
    li      t4, '\n'
    sb      t4, 0(t3)

    /* Clear BSS — must precede setup_vm, which writes kernel_map. */
    la      t0, _sbss
    la      t1, _ebss
.Lbss_loop:
    bgeu    t0, t1, .Lbss_done
    sd      zero, 0(t0)
    addi    t0, t0, 8
    j       .Lbss_loop
.Lbss_done:

    li      t3, 0x10000000
    li      t4, 'V'
    sb      t4, 0(t3)
    li      t4, '\n'
    sb      t4, 0(t3)

    /* ---- BSP-only: pre-MMU PIC fixup of .rela.dyn ----
     *
     * The kernel is built with -fPIE -shared.  All global-data accesses
     * compile to GOT-indirect loads (auipc + ld), where the linker
     * emits each .got slot's initial value as the link-time VA and a
     * companion R_RISCV_RELATIVE entry in .rela.dyn.  At this point
     * we're running at the physical load address — those link-time VAs
     * are not yet mapped, so any global access would fault.
     *
     * Walk .rela.dyn in pure assembly (PC-relative only — no globals)
     * and patch every R_RISCV_RELATIVE slot to addend + (PA - LINK_VA).
     * After this, setup_vm can dereference kernel_map / early_pg_dir
     * / etc. via the GOT and get correct PA-side pointers.
     *
     * Mirrors Linux arch/riscv/kernel/head.S — same idea, same loop.
     *
     *   reloc:
     *     t0 = pa_offset = PA(_start) - KERNEL_LINK_ADDR  (negative)
     *     t1 = &__rela_dyn_start
     *     t2 = &__rela_dyn_end
     *     for each 24-byte rela in [t1, t2):
     *         t3 = r_offset; t4 = r_info; t5 = r_addend
     *         if (t4 & 0xFFFFFFFF) != R_RISCV_RELATIVE: skip
     *         slot_pa = r_offset + pa_offset
     *         *slot_pa = r_addend + pa_offset
     */
#define R_RISCV_RELATIVE 3

    la      t0, _start                  /* PA of _start */
    li      t1, 0xFFFFFFC080200000      /* KERNEL_LINK_ADDR (asm/page.h) */
    sub     t0, t0, t1                  /* t0 = pa_offset (PA - LINK_VA) */

    la      t1, __rela_dyn_start
    la      t2, __rela_dyn_end
.Lrela_loop:
    bgeu    t1, t2, .Lrela_done
    ld      t3, 0(t1)                   /* r_offset */
    ld      t4, 8(t1)                   /* r_info */
    ld      t5, 16(t1)                  /* r_addend */
    /* r_info low 32 bits = type */
    li      t6, 0xFFFFFFFF
    and     t4, t4, t6
    li      t6, R_RISCV_RELATIVE
    bne     t4, t6, .Lrela_next
    /* slot_pa = r_offset + pa_offset */
    add     t3, t3, t0
    /* value = r_addend + pa_offset */
    add     t5, t5, t0
    sd      t5, 0(t3)
.Lrela_next:
    addi    t1, t1, 24                  /* sizeof(Elf64_Rela) */
    j       .Lrela_loop
.Lrela_done:

    /* Memory fence so subsequent loads see the patched slots. */
    fence   w, r

    li      t3, 0x10000000
    li      t4, 'P'
    sb      t4, 0(t3)
    li      t4, '\n'
    sb      t4, 0(t3)

    /* Call setup_vm(load_pa = PA of _start, dtb_pa = s0).
     * Both args physical at this point — MMU still off. */
    la      a0, _start
    mv      a1, s0
    call    setup_vm

    li      t3, 0x10000000
    li      t4, 'v'
    sb      t4, 0(t3)
    li      t4, '\n'
    sb      t4, 0(t3)

    /* Release APs once page tables are built. */
    la      t0, boot_sync_flag
    li      t1, 1
    amoswap.w.rl zero, t1, (t0)
    j       .Lenable_mmu

/* ========================================================================
 * AP path — spin until BSP signals readiness.
 * ======================================================================== */
.Lap_wait:
    la      t0, boot_sync_flag
.Lap_spin:
    lw      t1, 0(t0)
    beqz    t1, .Lap_spin
    fence   r, rw

    /* fall through */

/* ========================================================================
 * .Lenable_mmu — all harts: enable MMU, jump to higher-half, run reloc.
 *
 * relocate_enable_mmu does its own SATP write + higher-half jump in
 * C (with inline asm), then calls relocate_kernel.  After it returns,
 * we are at higher-half VA with sp / ra / gp slid up, and .rela.dyn
 * is applied (so .init_array pointers are valid).
 * ======================================================================== */
.Lenable_mmu:
    la      a0, early_pg_dir
    call    relocate_enable_mmu
    /* On return: PC, sp, ra, gp are all at higher-half VA. */

    li      t3, 0x10000000
    li      t4, 'M'
    sb      t4, 0(t3)
    li      t4, '\n'
    sb      t4, 0(t3)

    /* Mark MMU enabled for console / pmap layers that check this. */
    call    console_set_mmu_enabled

    /* BSP only: walk __init_array and call each C++ ctor. */
    la      t0, bsp_hart_id
    lw      t0, 0(t0)
    bne     tp, t0, .Lskip_cpp_init
    call    early_cpp_init
.Lskip_cpp_init:

    /* Hand off to kernel_main(hartid, dtb_pa). */
    mv      a0, tp
    mv      a1, s0
    call    kernel_main

    /* kernel_main should not return. */
.Lhalt:
    csrc    sstatus, 2
    wfi
    j       .Lhalt

/* ========================================================================
 * early_cpp_init — walk .init_array and call each constructor.
 *
 * Called only by BSP, after relocate_kernel has patched the function
 * pointers stored in __init_array.  Before relocate_kernel runs those
 * pointers are zero-filled by the linker.
 * ======================================================================== */
    .globl early_cpp_init
early_cpp_init:
    addi    sp, sp, -32
    sd      ra, 0(sp)
    sd      s1, 8(sp)
    sd      s2, 16(sp)

    la      s1, __init_array_start
    la      s2, __init_array_end
.Linit_loop:
    bgeu    s1, s2, .Linit_done
    ld      t0, 0(s1)
    jalr    ra, t0
    addi    s1, s1, 8
    j       .Linit_loop
.Linit_done:
    ld      ra, 0(sp)
    ld      s1, 8(sp)
    ld      s2, 16(sp)
    addi    sp, sp, 32
    ret

/* ========================================================================
 * Election state — in .data so explicit zero survives the BSP BSS clear
 * (these are read before BSS is cleared on the BSP, and concurrently by
 * APs while BSP is in the clear loop).
 * ======================================================================== */
    .section .data
    .align  2
    .globl  boot_sync_flag
boot_sync_flag:
    .word   0

    .globl  bsp_elected
bsp_elected:
    .word   0

    .globl  bsp_hart_id
bsp_hart_id:
    .word   0
