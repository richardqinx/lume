/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Trap MI Layer — Machine-Independent Semantic Dispatcher
 *
 * Receives a translated TrapCause from the MD layer and routes to
 * the appropriate handler.
 *
 * *** MI INVARIANT: This file contains ZERO inline assembly,
 *     ZERO arch-specific constants (no CSR reads, no scause codes). ***
 *     arch/trapframe.h is included because TrapFrame is the cross-layer
 *     data contract defined in docs/specs/arch_abstraction.md §3.2.
 *
 * Reference: docs/specs/trap.md §4
 */

#include <lume/trap.h>
#include <lume/irq.h>
#include <lume/console.h>
#include <lume/kprintf.h>
#include <lume/errno.h>
#include <lume/sched.h>
#include <lume/timer.h>
#include <lume/klog.h>
#include <lume/syscall.h>
#include <lume/task.h>
#include <lume/vmm.h>
#include <lume/signal.h>
#include <arch/trapframe.h>  /* TrapFrame: cross-layer data contract */

/* ========================================================================
 * trap_handle() — MI-layer dispatcher for traps
 *
 * Called by MD layer after scause → TrapInfo translation.
 * ======================================================================== */

static TrapStats g_trap_stats = {};

static uint32 trap_cause_index(TrapCause cause)
{
    switch (cause) {
    case TrapCause::PageFaultLoad:  return 0;
    case TrapCause::PageFaultStore: return 1;
    case TrapCause::PageFaultExec:  return 2;
    case TrapCause::Syscall:        return 3;
    case TrapCause::IllegalInst:    return 4;
    case TrapCause::Breakpoint:     return 5;
    case TrapCause::AccessFault:    return 6;
    case TrapCause::AlignFault:     return 7;
    case TrapCause::IrqTimer:       return 8;
    case TrapCause::IrqSoftware:    return 9;
    case TrapCause::IrqExternal:    return 10;
    case TrapCause::Unknown:
    default:
        return 11;
    }
}

static void trap_record(const TrapInfo& info)
{
    uint32 idx = trap_cause_index(info.cause);
    __atomic_fetch_add(&g_trap_stats.total, 1, __ATOMIC_RELAXED);
    __atomic_fetch_add(&g_trap_stats.by_cause[idx], 1, __ATOMIC_RELAXED);
    g_trap_stats.last_cause = info.cause;
    g_trap_stats.last_class = info.cls;
    g_trap_stats.last_origin = info.origin;
    g_trap_stats.last_val = info.val;
    g_trap_stats.last_epc = info.epc;
    g_trap_stats.last_scause = info.scause;
}

static VmFaultCause vm_fault_cause_from_trap(TrapCause cause)
{
    switch (cause) {
    case TrapCause::PageFaultStore:
        return VmFaultCause::Write;
    case TrapCause::PageFaultExec:
        return VmFaultCause::Exec;
    case TrapCause::PageFaultLoad:
    default:
        return VmFaultCause::Read;
    }
}

void trap_stats_get(TrapStats* out)
{
    if (!out) {
        return;
    }
    *out = g_trap_stats;
}

void trap_stats_reset()
{
    g_trap_stats = {};
}

void trap_handle(arch::TrapFrame* tf, const TrapInfo& info)
{
    trap_record(info);

    if (info.origin == TrapOrigin::FromKernel &&
        info.cls != TrapClass::Interrupt) {
        kprintf("[trap] kernel exception\n");
        kernel_panic("kernel exception");
    }

    switch (info.cause) {
    /* ---- Page Faults ---- */
    case TrapCause::PageFaultLoad:
    case TrapCause::PageFaultStore:
    case TrapCause::PageFaultExec:
        if (info.origin == TrapOrigin::FromUser) {
            TaskControlBlock* curr = current_task();
            if (!curr || !curr->mm) {
                kernel_panic("user page fault with no current mm");
            }

            int ret = vmm_handle_page_fault(curr->mm, info.val,
                                            vm_fault_cause_from_trap(info.cause));
            if (ret == -EFAULT) {
                task_kill_current(SIGSEGV);
            } else if (ret == -ENOMEM) {
                task_kill_current(SIGKILL);
            } else if (ret < 0) {
                task_kill_current(SIGSEGV);
            }
            break;
        }

        kprintf("[trap] kernel page fault\n");
        kernel_panic("unhandled page fault");
        break;

    /* ---- System Call ---- */
    case TrapCause::Syscall:
        syscall_dispatch_md(tf);
        break;

    /* ---- Interrupts ---- */
    case TrapCause::IrqTimer:
        /* Timer tick */
        timer_tick();
        break;

    case TrapCause::IrqExternal: {
        /* External interrupt: generic claim → dispatch → complete */
        uint32 irq = g_irq_manager.claim();
        if (irq != 0) {
            g_irq_manager.dispatch(irq);
            g_irq_manager.complete(irq);
        }
        break;
    }

    case TrapCause::IrqSoftware:
        /* IPI handling — Phase 2 stub */
        break;

    /* ---- Fatal exceptions ---- */
    case TrapCause::IllegalInst:
        kprintf("[trap] illegal instruction\n");
        /* Phase 2: panic. Phase 3: task_kill(SIGILL) */
        kernel_panic("illegal instruction in user mode");
        break;

    case TrapCause::AccessFault:
        kprintf("[trap] access fault\n");
        kernel_panic("access fault");
        break;

    case TrapCause::AlignFault:
        kprintf("[trap] alignment fault\n");
        kernel_panic("alignment fault");
        break;

    case TrapCause::Breakpoint:
        kprintf("[trap] breakpoint\n");
        /* ebreak advance is handled by MD layer (arch-specific instruction size) */
        break;

    case TrapCause::Unknown:
    default:
        kprintf("[trap] unknown trap\n");
        kernel_panic("unknown trap");
        break;
    }

    /* Check if rescheduling is needed before returning to user mode */
    if (info.origin == TrapOrigin::FromUser) {
        sched_check_preempt();
    }
}
