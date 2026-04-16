/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Trap Vector Entry / Exit (RISC-V 64, S-mode)
 *
 * On trap entry (interrupt / exception / ecall):
 *   sscratch holds the TrapFrame pointer (set up by kernel before sret).
 *   We swap sscratch <-> tp, save all 31 GPRs + sstatus + sepc into TrapFrame,
 *   then load kernel metadata (sp, satp, tp, trap handler) and jump to C++.
 *
 * On trap return (userret):
 *   Restore all GPRs + sstatus + sepc from TrapFrame, swap sscratch <-> tp,
 *   then sret back to user mode.
 *
 * Layout must match arch::TrapFrame in arch/riscv/include/arch/trapframe.h
 * Reference: docs/specs/arch_abstraction.md §7.2
 */

#include <arch/trapframe.h>

    .section .text
    .globl trap_vector
    .globl userret
    .align 4

/*
 * trap_vector — unified S-mode trap entry point (Direct mode)
 *
 * Precondition: sscratch = pointer to current task's TrapFrame
 */
trap_vector:
    /* Step 1: swap sscratch <-> tp.  Now tp = TrapFrame*, sscratch = old tp */
    csrrw tp, sscratch, tp

    /* Step 2: save all 31 general-purpose registers into TrapFrame */
    sd ra,  TF_RA(tp)
    sd sp,  TF_SP(tp)
    sd gp,  TF_GP(tp)
    /* tp (x4) is in sscratch — save it later */
    sd t0,  TF_T0(tp)
    sd t1,  TF_T1(tp)
    sd t2,  TF_T2(tp)
    sd s0,  TF_S0(tp)
    sd s1,  TF_S1(tp)
    sd a0,  TF_A0(tp)
    sd a1,  TF_A1(tp)
    sd a2,  TF_A2(tp)
    sd a3,  TF_A3(tp)
    sd a4,  TF_A4(tp)
    sd a5,  TF_A5(tp)
    sd a6,  TF_A6(tp)
    sd a7,  TF_A7(tp)
    sd s2,  TF_S2(tp)
    sd s3,  TF_S3(tp)
    sd s4,  TF_S4(tp)
    sd s5,  TF_S5(tp)
    sd s6,  TF_S6(tp)
    sd s7,  TF_S7(tp)
    sd s8,  TF_S8(tp)
    sd s9,  TF_S9(tp)
    sd s10, TF_S10(tp)
    sd s11, TF_S11(tp)
    sd t3,  TF_T3(tp)
    sd t4,  TF_T4(tp)
    sd t5,  TF_T5(tp)
    sd t6,  TF_T6(tp)

    /* Save the real tp (user's tp) which is now in sscratch */
    csrr t0, sscratch
    sd t0, TF_TP(tp)

    /* Step 3: save sstatus */
    csrr t0, sstatus
    sd t0, TF_SSTATUS(tp)

    /* Step 4: save sepc (interrupted PC) */
    csrr t0, sepc
    sd t0, TF_EPC(tp)

    /* Step 5: load kernel context from TrapFrame metadata */
    ld sp, TF_KERNEL_SP(tp)         /* switch to kernel stack */
    ld t1, TF_KERNEL_SATP(tp)       /* kernel page table */
    ld t2, TF_KERNEL_CPUID(tp)      /* CPU ID for tp */
    ld t3, TF_KERNEL_TRAP(tp)       /* C++ trap_handler address */

    /* Switch to kernel page table */
    csrw satp, t1

    /* Step 6: flush TLB after page table switch */
    sfence.vma zero, zero

    /* Set tp = CPU ID (kernel convention) */
    mv tp, t2

    /* Step 7: jump to C++ trap_handler */
    jalr t3


/*
 * userret — return to user mode
 *
 * Called from C++ as: userret(TrapFrame* tf)
 *   a0 = pointer to TrapFrame (with user satp already written by caller)
 *
 * Precondition: interrupts must be disabled by caller.
 */
userret:
    /* a0 = TrapFrame pointer, use it as base */

    /* Step 1: write back epc -> sepc */
    ld t0, TF_EPC(a0)
    csrw sepc, t0

    /* Step 2: write back sstatus */
    ld t0, TF_SSTATUS(a0)
    csrw sstatus, t0

    /* Step 3: caller is responsible for switching satp to user page table
     * and flushing TLB before calling userret. */

    /* Store TrapFrame address into sscratch for next trap entry */
    csrw sscratch, a0

    /* Use a0 as base to restore all registers */
    mv tp, a0

    /* Step 4: restore all 31 general-purpose registers */
    ld ra,  TF_RA(tp)
    ld sp,  TF_SP(tp)
    ld gp,  TF_GP(tp)
    /* defer tp restore — we're using it as base */
    ld t0,  TF_T0(tp)
    ld t1,  TF_T1(tp)
    ld t2,  TF_T2(tp)
    ld s0,  TF_S0(tp)
    ld s1,  TF_S1(tp)
    ld a0,  TF_A0(tp)
    ld a1,  TF_A1(tp)
    ld a2,  TF_A2(tp)
    ld a3,  TF_A3(tp)
    ld a4,  TF_A4(tp)
    ld a5,  TF_A5(tp)
    ld a6,  TF_A6(tp)
    ld a7,  TF_A7(tp)
    ld s2,  TF_S2(tp)
    ld s3,  TF_S3(tp)
    ld s4,  TF_S4(tp)
    ld s5,  TF_S5(tp)
    ld s6,  TF_S6(tp)
    ld s7,  TF_S7(tp)
    ld s8,  TF_S8(tp)
    ld s9,  TF_S9(tp)
    ld s10, TF_S10(tp)
    ld s11, TF_S11(tp)
    ld t3,  TF_T3(tp)
    ld t4,  TF_T4(tp)
    ld t5,  TF_T5(tp)
    ld t6,  TF_T6(tp)

    /* Step 5: restore user tp (swap sscratch <-> tp) */
    /* sscratch currently = TrapFrame address, tp = TrapFrame address */
    /* We need: tp = user's tp, sscratch = TrapFrame address */
    /* Load user tp from TrapFrame first, but we can't use any temp reg now.
     * Use the sscratch swap trick: */
    ld tp,  TF_TP(tp)

    /* sscratch already holds TrapFrame address (set above with csrw) */

    /* Step 6: sret — return to user mode */
    sret
