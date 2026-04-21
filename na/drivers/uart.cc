/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * uart.cc — 16550a UART driver (early console)
 *
 * Implements the early UART output mapping required by panic and kernel_main.
 */

#include <lume/console.h>
#include <lume/fdt.h>
#include <lume/vmm.h>
#include <lume/addr.h>
#include <arch/config.h>

static uint64 g_uart_pa = arch::kDefaultUartPA;

extern "C" void early_putc(char c) {
    if (!g_uart_pa) return;
    volatile auto* uart = reinterpret_cast<volatile uint8*>(pa_to_va(g_uart_pa));
    *uart = static_cast<uint8>(c);
}

extern "C" void early_puts(const char* s) {
    while (*s) early_putc(*s++);
}

void console_early_init(uint64 fdt_paddr) {
    uint64 pa = 0;
    FdtManager::early_scan_uart(fdt_paddr, &pa);
    if (pa != 0) {
        g_uart_pa = pa;
    }
}

void console_init() {
    /*
     * Once vmm_init() activates the new page table, the 1GB identity map is dropped.
     * The UART must be explicitly registered into the active page table.
     */
    if (g_uart_pa != 0) {
        vmm_map_kernel_mmio(g_uart_pa, 0x1000);
    }
}
