/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Kernel Panic — minimal fatal error handler.
 *
 * Before console_init(): silent death (no UART).
 * After console_init():  prints message then halts.
 *
 * Reference: docs/specs/global_init.md §6
 */

#include <lume/types.h>
#include <lume/addr.h>
#include <arch/cpu.h>
#include <lume/console.h>

extern "C" [[noreturn]] void kernel_panic(const char* msg, const char* detail) {
    arch::cpu::intr_off();

    early_puts("\n*** KERNEL PANIC: ");
    if (msg) {
        early_puts(msg);
    }
    if (detail) {
        early_puts(": ");
        early_puts(detail);
    }
    early_puts(" ***\n");

    while (true) {
        arch::cpu::halt_until_interrupt();
    }
}
