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

static uint64 g_uart_pa = 0;
static uint64 g_uart_size = 0;
static bool g_runtime_mapping_ready = false;
static bool g_mmu_enabled = false;

extern "C" void console_set_mmu_enabled() {
    g_mmu_enabled = true;
}

extern "C" void early_putc(char c) {
    if (!g_uart_pa) return;

    /*
     * Before vmm_init() activates the final page table, UART MMIO is only
     * reachable via the bootstrap fixed direct map from entry.S.
     * After activation, switch to the runtime (possibly KASLR-slid) base.
     */
    uint64 uart_va = 0;
    if (g_runtime_mapping_ready) {
        uart_va = pa_to_va(phys_addr(g_uart_pa)).raw;
    } else if (!g_mmu_enabled) {
        uart_va = g_uart_pa;
    } else {
        uart_va = boot_pa_to_va(phys_addr(g_uart_pa)).raw;
    }

    volatile auto* uart = reinterpret_cast<volatile uint8*>(uart_va);
    *uart = static_cast<uint8>(c);
}

extern "C" void early_puts(const char* s) {
    while (*s) early_putc(*s++);
}

void console_early_init(uint64 fdt_paddr) {
    uint64 pa = 0;
    uint64 size = 0;
    FdtManager::early_scan_uart(fdt_paddr, &pa, &size);
    if (pa != 0) {
        g_uart_pa = pa;
        if (size != 0) g_uart_size = size;
    }
}

void console_init() {
    /*
     * Once vmm_init() activates the new page table, the 1GB identity map is dropped.
     * The UART must be explicitly registered into the active page table.
     */
    if (g_uart_pa != 0 && g_uart_size != 0) {
        vmm_map_kernel_mmio(g_uart_pa, g_uart_size);
    }
}

void console_use_runtime_mapping() {
    g_runtime_mapping_ready = true;
}
