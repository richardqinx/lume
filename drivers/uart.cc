/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * uart.cc — 16550a UART driver + console registry
 *
 * Two roles:
 *   1. Early console: early_putc() for pre-init output (panic, kprintf)
 *   2. Runtime console: struct console registered with register_console().
 *      klog/printk route through console_write_all() → uart_console_write().
 *
 * The console registry is a simple linked list of struct console.
 * console_write_all() iterates the list and calls each console's write().
 * If no console is registered, it falls back to early_putc().
 *
 * Reference: Linux kernel/printk/printk.c, drivers/tty/serial/8250/
 */

#include <lume/console.h>
#include <lume/fdt.h>
#include <lume/vmm.h>
#include <lume/addr.h>
#include <arch/config.h>

/* ================================================================== */
/*  UART state                                                        */
/* ================================================================== */

static uint64 g_uart_pa = 0;
static uint64 g_uart_size = 0;
static bool g_runtime_mapping_ready = false;
static bool g_mmu_enabled = false;

/* ================================================================== */
/*  Early console (Phase 1)                                           */
/* ================================================================== */

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

/* ================================================================== */
/*  Console registry (Phase 2) — linked list of struct console        */
/* ================================================================== */

static list_node g_console_list;
static bool g_console_list_init = false;

void register_console(console* con)
{
    if (!con) return;

    if (!g_console_list_init) {
        g_console_list.init();
        g_console_list_init = true;
    }

    con->flags |= CON_ENABLED;
    con->list.init();

    /* Insert at tail */
    list_add_tail(&con->list, &g_console_list);
}

void unregister_console(console* con)
{
    if (!con) return;

    list_del_init(&con->list);
    con->flags &= ~CON_ENABLED;
}

bool console_drivers_registered()
{
    if (!g_console_list_init) return false;
    return !list_empty(&g_console_list);
}

void console_write_all(const char* s, int count)
{
    if (g_console_list_init && !list_empty(&g_console_list)) {
        list_node* pos;
        list_for_each(pos, &g_console_list) {
            auto* con = container_of(pos, console, list);
            if ((con->flags & CON_ENABLED) && con->write) {
                con->write(con, s, static_cast<unsigned int>(count));
            }
        }
    } else {
        /* Fallback: direct early_putc (pre-registration) */
        for (int i = 0; i < count; i++) {
            early_putc(s[i]);
        }
    }
}

/* ================================================================== */
/*  UART console driver                                               */
/* ================================================================== */

static void uart_console_write(console* /*con*/, const char* s, unsigned int count)
{
    for (unsigned int i = 0; i < count; i++) {
        if (s[i] == '\n') {
            early_putc('\r');
        }
        early_putc(s[i]);
    }
}

/*
 * uart_console must be initialized at RUNTIME, not with static
 * aggregate initializers. Reason: KASLR self-relocation processes
 * .rela.dyn entries for simple pointer variables, but may not cover
 * function pointer fields inside static aggregate initializers.
 * A static `{ .write = uart_console_write }` would store the
 * pre-relocation address, causing a crash when called.
 */
static console uart_console;

void uart_register_console()
{
    uart_console.name  = "ttyS";
    uart_console.write = uart_console_write;
    uart_console.setup = nullptr;
    uart_console.flags = CON_ENABLED | CON_BOOT;
    uart_console.index = 0;
    uart_console.data  = nullptr;
    uart_console.list.init();
    register_console(&uart_console);
}

