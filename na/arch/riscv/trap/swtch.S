/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Context Switch & Kernel Thread Trampoline (RISC-V 64)
 *
 * context_switch: saves/restores callee-saved registers.
 * kthread_entry_trampoline: entry point for newly created kernel threads.
 *   After context_switch loads the new Context, execution lands here via
 *   Context.ra = kthread_entry_trampoline. The entry function and argument
 *   are in s0 and s1 respectively, set by sched_init/create_tcb.
 *
 * The trampoline calls the MI-layer kthread_entry(entry, arg).
 *
 * Reference: docs/specs/scheduler.md §6
 */

    .section .text

/* ========================================================================
 * void context_switch(Context* old_ctx, Context* next_ctx);
 *   a0 = old_ctx_ptr, a1 = next_ctx_ptr
 * ======================================================================== */
    .globl context_switch
    .align 2
context_switch:
    sd ra, 0(a0)
    sd sp, 8(a0)
    sd s0, 16(a0)
    sd s1, 24(a0)
    sd s2, 32(a0)
    sd s3, 40(a0)
    sd s4, 48(a0)
    sd s5, 56(a0)
    sd s6, 64(a0)
    sd s7, 72(a0)
    sd s8, 80(a0)
    sd s9, 88(a0)
    sd s10, 96(a0)
    sd s11, 104(a0)

    ld ra, 0(a1)
    ld sp, 8(a1)
    ld s0, 16(a1)
    ld s1, 24(a1)
    ld s2, 32(a1)
    ld s3, 40(a1)
    ld s4, 48(a1)
    ld s5, 56(a1)
    ld s6, 64(a1)
    ld s7, 72(a1)
    ld s8, 80(a1)
    ld s9, 88(a1)
    ld s10, 96(a1)
    ld s11, 104(a1)

    ret

/* ========================================================================
 * kthread_entry_trampoline
 *
 * Reached via context_switch when a new kthread is first scheduled.
 * Context was set up by create_tcb():
 *   s0 = entry function pointer
 *   s1 = argument pointer
 *
 * Calls the MI-layer C++ function:
 *   void kthread_entry(void (*entry)(void*), void* arg);
 * ======================================================================== */
    .globl kthread_entry_trampoline
    .align 2
kthread_entry_trampoline:
    mv a0, s0           /* a0 = entry function */
    mv a1, s1           /* a1 = argument */
    call kthread_entry  /* MI-layer C++ function */

    /* kthread_entry should never return, but if it does: */
    wfi
    j kthread_entry_trampoline + 12  /* loop on wfi */