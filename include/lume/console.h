/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * console.h — Kernel console abstraction
 *
 * Two-phase design following Linux:
 *
 * Phase 1 (early boot):
 *   early_putc() → direct UART MMIO write. Used before MMU and
 *   before the console registry is ready. kprintf() and panic
 *   use this path.
 *
 * Phase 2 (runtime):
 *   struct console registered via register_console(). printk/klog
 *   emit through the console driver chain. Multiple consoles can
 *   be registered (e.g., UART + framebuffer).
 *
 * Reference: Linux include/linux/console.h
 */

#include <lume/types.h>
#include <lume/list.h>

/* ================================================================== */
/*  Early console (Phase 1 — direct UART access)                      */
/* ================================================================== */

extern "C" void early_putc(char c);
extern "C" void early_puts(const char* s);
extern "C" void console_set_mmu_enabled();

/* Early UART discovery via raw FDT parsing. */
void console_early_init(uint64 fdt_paddr);

/* Full console initialization. Maps MMIO. */
void console_init();

/*
 * Notify console that the runtime kernel page table is active.
 * After this point early_putc() must use runtime direct-map base
 * instead of the bootstrap fixed base.
 */
void console_use_runtime_mapping();

/* ================================================================== */
/*  struct console (Phase 2 — registered console drivers)             */
/* ================================================================== */

inline constexpr int CON_PRINTBUFFER = (1 << 0); /* Replay klog on register */
inline constexpr int CON_ENABLED     = (1 << 1);
inline constexpr int CON_BOOT        = (1 << 2); /* Early boot console */

struct console {
    const char*     name;
    void            (*write)(console* con, const char* s, unsigned int count);
    int             (*setup)(console* con, char* options);
    int             flags;
    int             index;
    void*           data;           /* driver private data */
    list_node       list;
};

/* Register / unregister a console driver */
void register_console(console* con);
void unregister_console(console* con);

/*
 * Write to all registered consoles.
 * Falls back to early_putc() if no console is registered.
 */
void console_write_all(const char* s, int count);

/* Check if any console is registered */
bool console_drivers_registered();
