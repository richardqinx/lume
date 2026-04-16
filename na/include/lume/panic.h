/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Kernel Panic — fatal error handler.
 *
 * Prints the message (if UART is ready), disables interrupts,
 * and enters an infinite wfi loop. Never returns.
 *
 * Implementation will be provided by lib/kprintf.cc or a
 * dedicated panic module. For now this header declares the interface.
 */

extern "C" [[noreturn]] void kernel_panic(const char* msg, const char* detail = nullptr);
