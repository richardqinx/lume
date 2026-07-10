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

#include <arch/cpu.h>
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
#include <lume/signal_nr.h>
#include <lume/smp.h>
#include <arch/trapframe.h>  /* TrapFrame: cross-layer data contract */
#include <arch/extable.h>    /* search_extable: kernel fault recovery */

/* ========================================================================
 * trap_handle() — MI-layer dispatcher for traps
 *
 * Called by MD layer after scause → TrapInfo translation.
 * ======================================================================== */

static TrapStats g_trap_stats = {};

static uint32 trap_cause_index(TrapCause cause)
{
    uint32 raw = static_cast<uint32>(cause);

    /* Exceptions 0-7 map directly to indices 0-7 */
    if (raw <= 7) {
        return raw;
    }
    /* IRQs 16-18 map to indices 8-10 */
    if (raw >= 16 && raw <= 18) {
        return raw - 16 + 8;
    }
    /* Unknown / out-of-range */
    return 11;
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

    /* ---- Kernel exception handling ----
     * Interrupts are always allowed through. For exceptions:
     * - Page faults: handled in the switch below (extable fixup path)
     * - Other exceptions: try extable, then panic.
     *
     * This replaces the old blanket kernel_panic, enabling
     * copy_from_user/copy_to_user to safely fault on user pages. */
    if (info.origin == TrapOrigin::FromKernel &&
        info.cls != TrapClass::Interrupt) {

        /* Page faults are dispatched in the switch — let them through */
        bool is_page_fault =
            (info.cause == TrapCause::PageFaultLoad ||
             info.cause == TrapCause::PageFaultStore ||
             info.cause == TrapCause::PageFaultExec);

        if (!is_page_fault) {
            /* Non-page-fault kernel exception: try extable fixup */
            uint64 fixup = search_extable(info.epc);
            if (fixup != 0) {
                tf->epc = fixup;
                return;
            }
            kprintf("[trap] fatal kernel exception: cause=%u epc=0x%llx val=0x%llx\n",
                    static_cast<unsigned>(info.cause), info.epc, info.val);
            kernel_panic("unrecoverable kernel exception");
        }
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
                kprintf("[trap] user SIGSEGV (MAPERR) epc=0x%llx addr=0x%llx\n",
                        info.epc, info.val);
                force_sig_fault(SIGSEGV, 1 /* SEGV_MAPERR */, info.val);
            } else if (ret == -ENOMEM) {
                kprintf("[trap] user SIGKILL (OOM) epc=0x%llx addr=0x%llx\n",
                        info.epc, info.val);
                force_sig_fault(SIGKILL, 0, info.val);
            } else if (ret < 0) {
                kprintf("[trap] user SIGSEGV (ACCERR) epc=0x%llx addr=0x%llx\n",
                        info.epc, info.val);
                force_sig_fault(SIGSEGV, 2 /* SEGV_ACCERR */, info.val);
            }
            break;
        }

        /* Kernel page fault — try exception table fixup.
         * This is the path used by copy_from_user/copy_to_user when
         * accessing unmapped or faulting user addresses from S-mode. */
        {
            uint64 fixup = search_extable(info.epc);
            if (fixup != 0) {
                tf->epc = fixup;
                break;
            }
        }
        kprintf("[trap] kernel page fault: epc=0x%llx addr=0x%llx\n",
                info.epc, info.val);
        {
            TaskControlBlock* curr = current_task();
            if (curr) {
                kprintf("[trap] pid=%d state=%d\n",
                        curr->pid, static_cast<int>(curr->state));
                kprintf("[trap] tf->epc=%llx tf->ra=%llx tf->sp=%llx\n",
                        tf->epc, tf->ra, tf->sp);
            }
        }
        kernel_panic("unhandled kernel page fault (no extable entry)");
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
        /* S-mode software interrupt = IPI from another hart */
        smp_handle_ipi();
        break;

    /* ---- Fatal exceptions ---- */
    case TrapCause::IllegalInst:
        if (info.origin == TrapOrigin::FromUser) {
            kprintf("[trap] user illegal instruction at epc=0x%llx stval=0x%llx\n",
                    info.epc, info.val);
            force_sig_fault(SIGILL, 1 /* ILL_ILLOPC */, info.epc);
        } else {
            kprintf("[trap] illegal instruction at epc=0x%llx\n", info.epc);
            kernel_panic("illegal instruction in kernel mode");
        }
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

    /* Process pending signals before returning to user mode */
    if (info.origin == TrapOrigin::FromUser) {
        do_signal(tf);
    }

    /* Preemption check on return from any interrupt.
     * This is the kernel's equivalent of Linux's retint_kernel path:
     * if a timer tick (or IPI) set need_resched, we must call schedule()
     * before returning — otherwise the idle loop never yields to
     * runnable tasks like PID 1. */
    if (info.cls == TrapClass::Interrupt) {
        sched_check_preempt();
    }
}
