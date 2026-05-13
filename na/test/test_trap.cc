/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot self-tests for the Trap/IRQ subsystem.
 *
 * Tests MD→MI translation, IrqManager register/dispatch/unregister,
 * and stvec installation verification.
 */

#include <lume/types.h>
#include <lume/selftest.h>
#include <lume/trap.h>
#include <lume/irq.h>
#include <lume/errno.h>
#include <lume/console.h>
#include <arch/trap.h>

TrapCause trap_translate_scause(uint64 scause);

/* ========================================================================
 * IrqManager test helpers
 * ======================================================================== */

static volatile uint32 g_test_irq_fired = 0;
static volatile void*  g_test_irq_arg   = nullptr;

static void test_irq_handler(uint32 irq, void* arg)
{
    g_test_irq_fired = irq;
    g_test_irq_arg   = arg;
}

/* ========================================================================
 * Test cases
 * ======================================================================== */

static bool test_stvec_installed() {
    uint64 vec = arch::trap::get_vector();
    return vec != 0;
}

static bool test_scause_exception_translation() {
    /* Verify all exception causes map correctly */
    bool ok = true;
    ok = ok && (trap_translate_scause(EXC_LOAD_PAGE_FAULT)   == TrapCause::PageFaultLoad);
    ok = ok && (trap_translate_scause(EXC_STORE_PAGE_FAULT)  == TrapCause::PageFaultStore);
    ok = ok && (trap_translate_scause(EXC_INST_PAGE_FAULT)   == TrapCause::PageFaultExec);
    ok = ok && (trap_translate_scause(EXC_ECALL_FROM_U)      == TrapCause::Syscall);
    ok = ok && (trap_translate_scause(EXC_ILLEGAL_INST)      == TrapCause::IllegalInst);
    ok = ok && (trap_translate_scause(EXC_BREAKPOINT)        == TrapCause::Breakpoint);
    ok = ok && (trap_translate_scause(EXC_LOAD_ACCESS_FAULT) == TrapCause::AccessFault);
    ok = ok && (trap_translate_scause(EXC_INST_MISALIGNED)   == TrapCause::AlignFault);
    return ok;
}

static bool test_scause_interrupt_translation() {
    bool ok = true;
    ok = ok && (trap_translate_scause(SCAUSE_INTERRUPT | IRQ_S_TIMER)    == TrapCause::IrqTimer);
    ok = ok && (trap_translate_scause(SCAUSE_INTERRUPT | IRQ_S_SOFTWARE) == TrapCause::IrqSoftware);
    ok = ok && (trap_translate_scause(SCAUSE_INTERRUPT | IRQ_S_EXTERNAL) == TrapCause::IrqExternal);
    ok = ok && (trap_translate_scause(SCAUSE_INTERRUPT | 99)             == TrapCause::Unknown);
    return ok;
}

static bool test_scause_unknown() {
    /* ecall from S-mode should map to Unknown (we only handle U-mode ecall) */
    return trap_translate_scause(EXC_ECALL_FROM_S) == TrapCause::Unknown;
}

static bool test_irqmanager_register_dispatch() {
    IrqManager mgr;
    mgr.init();

    g_test_irq_fired = 0;
    g_test_irq_arg = nullptr;

    int dummy_arg = 42;
    int ret = mgr.register_handler(10, test_irq_handler, &dummy_arg);
    if (ret != 0) return false;

    /* Dispatch IRQ 10 — handler should be called */
    mgr.dispatch(10);

    if (g_test_irq_fired != 10) return false;
    if (g_test_irq_arg != &dummy_arg) return false;

    return true;
}

static bool test_irqmanager_unregister() {
    IrqManager mgr;
    mgr.init();

    g_test_irq_fired = 0;

    mgr.register_handler(5, test_irq_handler, nullptr);
    mgr.unregister_handler(5);

    /* Dispatch after unregister — handler should NOT be called */
    mgr.dispatch(5);

    return g_test_irq_fired == 0;
}

static bool test_irqmanager_double_register() {
    IrqManager mgr;
    mgr.init();

    int ret1 = mgr.register_handler(7, test_irq_handler, nullptr);
    int ret2 = mgr.register_handler(7, test_irq_handler, nullptr);

    return ret1 == 0 && ret2 == -EBUSY;
}

static bool test_irqmanager_invalid_irq() {
    IrqManager mgr;
    mgr.init();

    int ret = mgr.register_handler(999, test_irq_handler, nullptr);
    return ret == -EINVAL;
}

static bool test_irqmanager_has_handler() {
    IrqManager mgr;
    mgr.init();

    if (mgr.has_handler(10)) return false;  /* not yet registered */

    mgr.register_handler(10, test_irq_handler, nullptr);
    if (!mgr.has_handler(10)) return false;  /* now registered */

    mgr.unregister_handler(10);
    if (mgr.has_handler(10)) return false;  /* unregistered */

    return true;
}

static bool test_irqmanager_spurious_dispatch() {
    IrqManager mgr;
    mgr.init();

    g_test_irq_fired = 0;

    /* Dispatch an unregistered IRQ — should not crash or fire */
    mgr.dispatch(0);
    mgr.dispatch(63);

    return g_test_irq_fired == 0;
}

/* ========================================================================
 * Test runner
 * ======================================================================== */

void selftest_trap()
{
    st_begin("trap: stvec is installed");
    ST_ASSERT(test_stvec_installed());
    st_pass();

    st_begin("trap: scause exception translation");
    ST_ASSERT(test_scause_exception_translation());
    st_pass();

    st_begin("trap: scause interrupt translation");
    ST_ASSERT(test_scause_interrupt_translation());
    st_pass();

    st_begin("trap: scause unknown (ecall from S)");
    ST_ASSERT(test_scause_unknown());
    st_pass();

    st_begin("trap: IrqManager register/dispatch");
    ST_ASSERT(test_irqmanager_register_dispatch());
    st_pass();

    st_begin("trap: IrqManager unregister");
    ST_ASSERT(test_irqmanager_unregister());
    st_pass();

    st_begin("trap: IrqManager double register");
    ST_ASSERT(test_irqmanager_double_register());
    st_pass();

    st_begin("trap: IrqManager invalid IRQ");
    ST_ASSERT(test_irqmanager_invalid_irq());
    st_pass();

    st_begin("trap: IrqManager has_handler");
    ST_ASSERT(test_irqmanager_has_handler());
    st_pass();

    st_begin("trap: IrqManager spurious dispatch");
    ST_ASSERT(test_irqmanager_spurious_dispatch());
    st_pass();
}
