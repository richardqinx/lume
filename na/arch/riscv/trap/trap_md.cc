/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Trap MD Layer (RISC-V 64)
 *
 * All architecture-specific trap logic lives here:
 *   - scause/stval reading (CSR access)
 *   - scause → MI TrapCause translation
 *   - RISC-V specific fixups (ecall epc += 4, ebreak epc += 2)
 *   - stvec setup (trap_init / trap_init_ap)
 *   - kernel_trap_handler (traps from S-mode)
 *
 * MI layer (kernel/trap.cc) contains ZERO arch-specific code.
 *
 * Reference: docs/specs/trap.md §7
 */

#include <lume/trap.h>
#include <lume/irq.h>
#include <lume/klog.h>
#include <lume/console.h>
#include <lume/kprintf.h>
#include <lume/sched.h>
#include <lume/task.h>
#include <arch/trap.h>
#include <arch/trapframe.h>
#include <arch/cpu.h>
#include <arch/extable.h>

/* PLIC interface (drivers/plic.cc) */
uint32 plic_claim();
void plic_complete(uint32 irq);

/* trap_vector.S: assembly entry point */
extern "C" void trap_vector();

/* ========================================================================
 * scause → TrapCause translation (RISC-V specific)
 * ======================================================================== */

static TrapCause scause_to_trap_cause(uint64 scause)
{
    if (arch::trap::is_interrupt(scause)) {
        switch (arch::trap::cause_code(scause)) {
        case IRQ_S_TIMER:    return TrapCause::IrqTimer;
        case IRQ_S_SOFTWARE: return TrapCause::IrqSoftware;
        case IRQ_S_EXTERNAL: return TrapCause::IrqExternal;
        default:             return TrapCause::Unknown;
        }
    }

    /* Exception (synchronous) */
    switch (scause) {
    case EXC_INST_PAGE_FAULT:   return TrapCause::PageFaultExec;
    case EXC_LOAD_PAGE_FAULT:   return TrapCause::PageFaultLoad;
    case EXC_STORE_PAGE_FAULT:  return TrapCause::PageFaultStore;
    case EXC_ECALL_FROM_U:      return TrapCause::Syscall;
    case EXC_ILLEGAL_INST:      return TrapCause::IllegalInst;
    case EXC_BREAKPOINT:        return TrapCause::Breakpoint;

    case EXC_INST_ACCESS_FAULT:
    case EXC_LOAD_ACCESS_FAULT:
    case EXC_STORE_ACCESS_FAULT:
        return TrapCause::AccessFault;

    case EXC_INST_MISALIGNED:
    case EXC_LOAD_MISALIGNED:
    case EXC_STORE_MISALIGNED:
        return TrapCause::AlignFault;

    default:
        return TrapCause::Unknown;
    }
}

TrapCause trap_translate_scause(uint64 scause)
{
    return scause_to_trap_cause(scause);
}

static TrapOrigin origin_from_sstatus(uint64 sstatus)
{
    constexpr uint64 kSstatusSPP = (1ULL << 8);
    return (sstatus & kSstatusSPP) ? TrapOrigin::FromKernel
                                   : TrapOrigin::FromUser;
}

static TrapClass classify_trap(uint64 scause, TrapCause cause)
{
    if (arch::trap::is_interrupt(scause)) {
        return TrapClass::Interrupt;
    }
    if (cause == TrapCause::Syscall) {
        return TrapClass::Syscall;
    }
    if (cause == TrapCause::Unknown) {
        return TrapClass::Unknown;
    }
    return TrapClass::Exception;
}

static TrapInfo build_trap_info(arch::TrapFrame* tf,
                                uint64 scause,
                                uint64 stval,
                                TrapOrigin origin)
{
    TrapInfo info{};
    info.cause = scause_to_trap_cause(scause);
    info.cls = classify_trap(scause, info.cause);
    info.origin = origin;
    info.val = stval;
    info.epc = tf ? tf->epc : 0;
    info.scause = scause;
    return info;
}

/* ========================================================================
 * trap_dispatch — user-mode trap entry (called from trap_vector.S)
 *
 * Reads RISC-V CSRs, translates to MI TrapCause, applies arch-specific
 * fixups, then calls MI trap_handle().
 * ======================================================================== */

extern "C" void trap_dispatch(arch::TrapFrame* tf)
{
    uint64 scause = arch::trap::get_cause();
    uint64 stval  = arch::trap::get_value();

    TrapOrigin origin = origin_from_sstatus(tf->sstatus);
    TrapInfo info = build_trap_info(tf, scause, stval, origin);

    /* Save trapframe in TCB for syscall handlers (like fork) */
    TaskControlBlock* curr = current_task();
    if (curr) {
        curr->trapframe = tf;
    }

    /* RISC-V ecall fix: ecall does not increment sepc.
     * Advance epc so sret returns to the instruction AFTER ecall. */
    if (info.cause == TrapCause::Syscall) {
        tf->epc += 4;
        info.epc = tf->epc;
    }

    /* RISC-V ebreak fix: advance past the C.EBREAK instruction (2 bytes).
     * This is arch-specific because instruction size depends on the ISA. */
    if (info.cause == TrapCause::Breakpoint) {
        tf->epc += 2;
        info.epc = tf->epc;
    }

    /* Call MI-layer dispatcher (zero inline assembly from here on) */
    trap_handle(tf, info);
}

/* ========================================================================
 * kernel_trap_handler — traps taken while already in S-mode
 *
 * For Phase 2, only timer and external interrupts are expected.
 * Exceptions in S-mode are always fatal.
 *
 * This belongs in MD because it reads scause directly.
 * ======================================================================== */

extern "C" void kernel_trap_handler(arch::TrapFrame* tf)
{
    uint64 scause = arch::trap::get_cause();
    uint64 stval  = arch::trap::get_value();

    if (scause == EXC_LOAD_PAGE_FAULT || scause == EXC_STORE_PAGE_FAULT) {
        uint64 fixup = search_extable(tf->epc);
        if (fixup != 0) {
            /* Exception table entry found: redirect execution to fixup code */
            tf->epc = fixup;
            return;
        }
    }

    TrapInfo info = build_trap_info(tf, scause, stval, TrapOrigin::FromKernel);
    trap_handle(tf, info);
}

/* kernelvec assembly is in trap_vector.S */
extern "C" void kernelvec();

/* ========================================================================
 * trap_init() — BSP: set stvec, init IrqManager
 * ======================================================================== */

void trap_init()
{
    g_irq_manager.init();
    arch::trap::set_vector(reinterpret_cast<uint64>(&kernelvec));
}

/* ========================================================================
 * trap_init_ap() — AP: set this CPU's stvec
 * ======================================================================== */

void trap_init_ap()
{
    arch::trap::set_vector(reinterpret_cast<uint64>(&kernelvec));
}

