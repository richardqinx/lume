/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * LumeOS Kernel Entry Point (RISC-V 64)
 *
 * This file implements the earliest boot sequence:
 *   1. RISC-V Linux Boot Protocol Image Header (64 bytes)
 *   2. BSP/AP synchronization
 *   3. BSS zeroing (BSP only)
 *   4. Early page table setup (1GB superpages for identity + higher-half)
 *   5. MMU enable and higher-half trampoline
 *   6. C++ global constructor invocation
 *   7. Jump to kernel_main()
 *
 * Register contract on entry (from OpenSBI / GRUB / U-Boot):
 *   a0 = CPU ID (Hart ID)
 *   a1 = FDT physical base address
 *
 * Reference: docs/specs/linker_and_entry.md
 */

#include <lume/config.h>

#define PAGE_OFFSET     0xFFFFFFC000000000
#define BOOT_STACK_SIZE 8192

/* SV39 PTE flags */
#define PTE_V   (1 << 0)    /* Valid */
#define PTE_R   (1 << 1)    /* Readable */
#define PTE_W   (1 << 2)    /* Writable */
#define PTE_X   (1 << 3)    /* Executable */
#define PTE_A   (1 << 6)    /* Accessed */
#define PTE_D   (1 << 7)    /* Dirty */

/* SATP mode field for SV39 */
#define SATP_SV39  (8UL << 60)

/* LumeOS compressed image header constants */
#define LUME_COMP_NONE 0
#define LUME_HDR_SIZE 80
#define LUME_HDR_MAGIC 0x4C554D45434F4D50 /* "LUMECOMP" */
#define LUME_HDR_OFF 64
#define LUME_HDR_FLAGS_OFF 14
#define LUME_HDR_FLAG_STAGE3_DONE 0x1

/* ========================================================================
 * Section: .head.text — RISC-V Linux Boot Protocol Image Header
 * Must be at byte 0 of the kernel binary.
 * ======================================================================== */
    .section .head.text, "ax"
    .globl _start
_start:
    /* code0 (u32, offset 0): executable jump for OpenSBI bare boot */
    j       real_start
    /* code1 (u32, offset 4): reserved */
    .word   0
    /* text_offset (u64, offset 8): load offset from RAM base */
    .dword  0x200000
    /* image_size (u64, offset 16): will be filled post-link, 0 = unknown */
    .dword  0
    /* flags (u64, offset 24): bit 0: 0=LE, 1=BE */
    .dword  0
    /* version (u32, offset 32): header version 0.2 */
    .word   0x0002
    /* res1 (u32, offset 36) */
    .word   0
    /* res2 (u64, offset 40) */
    .dword  0
    /* magic (u64, offset 48): RISCV_IMAGE_MAGIC "RISCV\0\0\0" LE */
    .dword  0x5643534952
    /* magic2 (u32, offset 56): RISCV_IMAGE_MAGIC2 "RSC\x05" LE */
    .word   0x05435352
    /* res3 (u32, offset 60): reserved for PE/COFF */
    .word   0

    /* LumeOS compressed kernel header (80 bytes) */
    .align  3
    .globl __lume_image_header
__lume_image_header:
    .dword  LUME_HDR_MAGIC          /* magic */
    .word   1                       /* version */
    .half   LUME_HDR_SIZE           /* header_size */
    .half   0                       /* flags */
    .word   LUME_COMP_NONE          /* compression */
    .word   0                       /* reserved0 */
    .dword  __lume_image_end - _start  /* uncompressed_size */
    .dword  0                       /* compressed_size */
    .dword  0                       /* load_phys_base (0 = auto) */
    .dword  __lume_reloc_start - _start /* reloc_offset */
    .dword  __lume_reloc_end - __lume_reloc_start /* reloc_size */
    .dword  _ebss - _start            /* payload_offset (when compressed) */
    .word   0                       /* header_crc32 */
    .word   0                       /* payload_crc32 */

/* ========================================================================
 * real_start: Actual boot logic begins here (all CPUs land here)
 * ======================================================================== */
    .text
    .globl real_start
real_start:
    /* ---- Step 1: Disable interrupts ---- */
    csrw    sie, zero
    csrw    sip, zero

    /* ---- Step 2: Set up gp (global pointer) ---- */
    /* Critical for medany model: all global variable access goes through gp */
    .option push
    .option norelax
    la      gp, __global_pointer$
    .option pop

    /* ---- Step 3: Set up per-CPU boot stack ---- */
    /* sp = boot_stack + (cpu_id + 1) * BOOT_STACK_SIZE */
    la      t0, boot_stack
    li      t1, BOOT_STACK_SIZE
    addi    t2, a0, 1           /* t2 = cpu_id + 1 */
    mul     t1, t1, t2          /* t1 = (cpu_id + 1) * BOOT_STACK_SIZE */
    add     sp, t0, t1

    /* ---- Step 4: Store boot args (cpu_id and fdt_paddr) ---- */
    mv      tp, a0              /* tp = cpu_id */
    mv      s0, a1              /* s0 = fdt_paddr (preserved across all C++ calls) */
    /* ---- Step 5: BSP / AP divergence ---- */
    /* CPU 0 is the BSP; all others spin-wait */
    bnez    a0, .Lap_wait

/* ===================================================================
 * BSP-only path: Clear BSS, set up early page table, release APs
 * =================================================================== */
.Lbsp_init:
    /* ---- 5.1: Clear BSS ---- */
    la      t0, _sbss
    la      t1, _ebss
.Lbss_loop:
    bgeu    t0, t1, .Lbss_done
    sd      zero, 0(t0)
    addi    t0, t0, 8
    j       .Lbss_loop
.Lbss_done:


    /* ---- 5.2: Build early page table (1GB superpages) ---- */
    /*
     * SV39 root page table (512 entries x 8 bytes = 4KB)
     * We need 4 entries:
     *   [0]   = Identity map:    0x00000000 -> 0x00000000 (MMIO: UART, PLIC, CLINT)
     *   [2]   = Identity map:    0x80000000 -> 0x80000000 (RAM)
     *   [256] = Higher-half:     0xFFFFFFC000000000 -> 0x00000000 (MMIO via VA)
     *   [258] = Higher-half:     0xFFFFFFC080000000 -> 0x80000000 (RAM via VA)
     *
     * VPN[2] index = (VA >> 30) & 0x1FF
     *   0x00000000       -> 0     0xFFFFFFC000000000 -> 256
     *   0x80000000       -> 2     0xFFFFFFC080000000 -> 258
     */
    la      t0, early_pgdir

    /* PTE flags: V|R|W|X|A|D (1GB leaf superpage) */
    li      t2, (PTE_V | PTE_R | PTE_W | PTE_X | PTE_A | PTE_D)

    /* --- MMIO region: physical 0x00000000 --- */
    /* PPN = 0x00000000 >> 12 = 0, PTE = flags only */
    mv      t1, t2              /* PTE = 0 | flags */

    /* Entry [0]: Identity map MMIO */
    sd      t1, (0 * 8)(t0)

    /* Entry [256]: Higher-half MMIO (0xFFFFFFC000000000) */
    li      t3, (256 * 8)
    add     t3, t0, t3
    sd      t1, 0(t3)

    /* --- RAM region: physical 0x80000000 --- */
    li      t1, 0x80000         /* PPN = 0x80000000 >> 12 */
    slli    t1, t1, 10          /* PPN field in PTE */
    or      t1, t1, t2          /* t1 = complete PTE */

    /* Entry [2]: Identity map RAM */
    sd      t1, (2 * 8)(t0)

    /* Entry [258]: Higher-half RAM (0xFFFFFFC080000000) */
    li      t3, (258 * 8)
    add     t3, t0, t3
    sd      t1, 0(t3)


    /* ---- 5.3: Memory fence ---- */
    fence   rw, rw

    /* ---- 5.4: Release APs ---- */
    la      t0, boot_sync_flag
    li      t1, 1
    amoswap.w.rl zero, t1, (t0)
    j       .Lenable_mmu

/* ===================================================================
 * AP path: spin-wait until BSP signals readiness
 * =================================================================== */
.Lap_wait:
    la      t0, boot_sync_flag
.Lap_spin:
    lw      t1, 0(t0)
    beqz    t1, .Lap_spin
    fence   r, rw               /* Acquire: ensure we see BSP's writes */

/* ===================================================================
 * All CPUs: Enable MMU and jump to higher-half virtual addresses
 * =================================================================== */
.Lenable_mmu:


    /* ---- 6.1: Write satp = SV39 mode | (early_pgdir >> 12) ---- */
    /* NOTE: `la` at this point is PC-relative. Since we are still executing
     * at physical addresses, it yields the PHYSICAL address directly.
     * No VA-to-PA conversion needed. */
    la      t0, early_pgdir
    srli    t0, t0, 12          /* PPN = PA >> 12 */
    li      t1, SATP_SV39
    or      t0, t0, t1          /* satp = mode | PPN */
    csrw    satp, t0

    /* ---- 6.2: Flush TLB ---- */
    sfence.vma zero, zero

    /* ---- 6.3: Jump to higher-half virtual address ---- */
    /* Now we are executing via the identity map (PA == VA for 0x8...).
     * `la` is PC-relative (medany), so it yields a PHYSICAL address.
     * We must add PAGE_OFFSET to convert to the higher-half VA. */
    la      t0, .Lhigher_half
    li      t1, PAGE_OFFSET
    add     t0, t0, t1
    jr      t0

.Lhigher_half:
    /* We are now running at virtual addresses (0xFFFFFFC0...) !
     * The identity map is still active but will be removed by vmm_init(). */

    /* ---- 6.4: Fix sp and gp to virtual addresses ---- */
    /* sp was set up before MMU using PC-relative `la`, so it holds a
     * physical address. Add PAGE_OFFSET to convert to higher-half VA.
     * gp is similarly reloaded — now that PC is at VA, `la` resolves
     * correctly via PC-relative addressing. */
    li      t0, PAGE_OFFSET
    add     sp, sp, t0
    .option push
    .option norelax
    la      gp, __global_pointer$
    .option pop

    /* Mark MMU enabled for early console mapping logic */
    call    console_set_mmu_enabled

    /* ---- Step 7: BSP calls early_cpp_init ---- */
    bnez    tp, .Lskip_cpp_init

    /* BSP only: invoke C++ global constructors */
    call    early_cpp_init

.Lskip_cpp_init:

    /* All CPUs: enter kernel_main(cpu_id, fdt_paddr) */
    mv      a0, tp              /* a0 = cpu_id (from tp) */
    mv      a1, s0              /* a1 = fdt_paddr (from s0) */
    call    kernel_main

    /* kernel_main should never return; if it does, halt */
.Lhalt:
    csrc    sstatus, 2          /* Clear SIE */
    wfi
    j       .Lhalt


/* ========================================================================
 * early_cpp_init: Traverse .init_array and call global constructors
 * Called by BSP only, before kernel_main.
 * ======================================================================== */
    .globl early_cpp_init
early_cpp_init:
    /* Prologue: save ra and callee-saved regs we use as loop state */
    addi    sp, sp, -32
    sd      ra, 0(sp)
    sd      s1, 8(sp)
    sd      s2, 16(sp)

    la      s1, __init_array_start
    la      s2, __init_array_end
.Linit_loop:
    bgeu    s1, s2, .Linit_done
    ld      t0, 0(s1)           /* Load function pointer */
    jalr    ra, t0              /* Call constructor (sets ra = return addr) */
    addi    s1, s1, 8           /* Next entry */
    j       .Linit_loop
.Linit_done:
    /* Epilogue: restore and return */
    ld      ra, 0(sp)
    ld      s1, 8(sp)
    ld      s2, 16(sp)
    addi    sp, sp, 32
    ret


/* ========================================================================
 * BSS Data: boot_sync_flag
 * ======================================================================== */
    .section .bss
    .align  2
    .globl  boot_sync_flag
boot_sync_flag:
    .word   0
