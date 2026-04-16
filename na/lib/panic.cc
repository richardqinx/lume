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
#include <arch/cpu.h>

// Minimal direct UART output (same as main.cc early boot)
// This can be used by other early-boot code before console_init()

constexpr uint64 kUart0VA = 0x10000000UL + 0xFFFFFFC000000000ULL;

extern "C" void early_putc(char c) {
    volatile auto* uart = reinterpret_cast<volatile uint8*>(kUart0VA);
    *uart = static_cast<uint8>(c);
}

extern "C" void early_puts(const char* s) {
    while (*s) early_putc(*s++);
}

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
