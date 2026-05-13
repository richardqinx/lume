/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test Runner
 *
 * Entry point that invokes all registered self-test suites.
 * Called from kernel_main() after all subsystem initialization.
 */

#include <lume/selftest.h>

/* Individual test suite entry points */
void selftest_pmm();
void selftest_slab();
void selftest_spinlock();
void selftest_rbtree();
void selftest_vmm();
void selftest_fdt();
void selftest_vma();
void selftest_atomic();
void selftest_trap();
void selftest_sched();
void selftest_klog();
void selftest_random();
void selftest_reloc();
void selftest_waitqueue();
void selftest_uaccess();
void selftest_sys_mm();

void selftest_run_all()
{
    kprintf("\n========================================\n");
    kprintf("  Boot Self-Test Suite\n");
    kprintf("========================================\n");

    selftest_spinlock();
    selftest_pmm();
    selftest_slab();
    selftest_rbtree();
    selftest_vmm();
    selftest_vma();
    selftest_atomic();
    selftest_fdt();
    selftest_trap();
    selftest_sched();
    selftest_klog();
    selftest_random();
    selftest_reloc();
    selftest_waitqueue();
    selftest_uaccess();
    selftest_sys_mm();

    kprintf("========================================\n");
    kprintf("  All self-tests PASSED\n");
    kprintf("========================================\n\n");
}
