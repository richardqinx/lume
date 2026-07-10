// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 */

#pragma once
#include "common/types.h"
#include "drivers/uart_color.h"
#include "kernel/fdt.h"

// UART register offsets (NS16550A)
#define RHR 0 // Receive Holding Register (read mode)
#define THR 0 // Transmit Holding Register (write mode)
#define IER 1 // Interrupt Enable Register
#define FCR 2 // FIFO Control Register
#define ISR 2 // Interrupt Status Register
#define LCR 3 // Line Control Register
#define LSR 5 // Line Status Register

#define LSR_RX_READY 0x01 // input is waiting to be read from RHR
#define LSR_TX_IDLE 0x20  // THR can accept another character to send

#define UART_RX_BUF_SIZE 128

// UART base address from FDT (use inline function to avoid macro issues)
static inline uint64 uart_base() { return g_devices.uart.base_addr; }

namespace Drivers
{
    void uart_init();
    void uart_intr();
    int console_read(uint64 target, int len);

    void uart_putc(char c);
    void uart_puts(const char *s);
    void uart_put_int(int value);
    void print_hex(uint64 value);
}