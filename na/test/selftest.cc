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

void selftest_run_all()
{
    early_puts("\n========================================\n");
    early_puts("  Boot Self-Test Suite\n");
    early_puts("========================================\n");

    selftest_spinlock();
    selftest_pmm();
    selftest_slab();
    selftest_rbtree();
    selftest_vmm();
    selftest_vma();
    selftest_atomic();
    selftest_fdt();

    early_puts("========================================\n");
    early_puts("  All self-tests PASSED\n");
    early_puts("========================================\n\n");
}
