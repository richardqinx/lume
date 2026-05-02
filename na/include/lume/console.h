/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

extern "C" void early_putc(char c);
extern "C" void early_puts(const char* s);

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
