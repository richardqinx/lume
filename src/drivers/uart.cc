// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */
#include "drivers/uart.h"
#include "kernel/riscv.h"
#include "kernel/spinlock.h"
#include "kernel/proc.h"
#include "kernel/mm.h"
#include "lib/string.h"

namespace Drivers
{
    struct
    {
        Spinlock lock;
        char buf[128]; // Line buffer
        uint32 r;      // Read pointer (position taken by the user)
        uint32 w;      // Write pointer (position confirmed by Enter)
        uint32 e;      // Editing cursor (current typing position)
    } cons;

    // Circular buffer structure
    struct
    {
        Spinlock lock;
        char buf[UART_RX_BUF_SIZE];
        uint32 r; // read index
        uint32 w; // write index
    } uart_rx;

    Spinlock uart_tx_lock;

    void uart_init()
    {
        uart_rx.lock.init("uart_rx");
        cons.lock.init("console");
        uart_tx_lock.init("uart_tx");
        uart_rx.r = 0;
        uart_rx.w = 0;

        // Disable interrupts and configure
        *(volatile uint8 *)(UART0 + IER) = 0x00;

        // Enter baud rate setting mode (LCR_DLAB) = 0x80;
        *(volatile uint8 *)(UART0 + LCR) = 0x80;
        *(volatile uint8 *)(UART0 + 0) = 0x03; // DLL: 38.4K baud
        *(volatile uint8 *)(UART0 + 1) = 0x00; // DLM

        // Exit baud rate setting, set 8-bit word length, no parity
        *(volatile uint8 *)(UART0 + LCR) = 0x03;

        // Reset and enable FIFO
        *(volatile uint8 *)(UART0 + FCR) = 0x07;

        // Enable Receive Data Available Interrupt
        *(volatile uint8 *)(UART0 + IER) = 0x01;
    }

    void uart_putc(char c)
    {
        uart_tx_lock.acquire();
        while ((*(volatile uint8 *)(UART0 + LSR) & LSR_TX_IDLE) == 0)
            ;
        *(volatile uint8 *)(UART0 + THR) = c;
        uart_tx_lock.release();
    }

    void uart_puts(const char *s)
    {
        while (*s)
            uart_putc(*s++);
    }

    void uart_put_int(int val)
    {
        char buf[16];
        int i = 0;
        if (val == 0)
        {
            uart_puts("0");
            return;
        }
        if (val < 0)
        {
            uart_puts("-");
            val = -val;
        }
        while (val > 0)
        {
            buf[i++] = (val % 10) + '0';
            val /= 10;
        }
        while (i > 0)
        {
            uart_putc(buf[--i]);
        }
    }

    void print_hex(uint64 val)
    {
        char hex[] = "0123456789ABCDEF";
        uart_puts("0x");
        for (int i = 60; i >= 0; i -= 4)
        {
            uart_putc(hex[(val >> i) & 0xF]);
        }
    }

    void uart_intr()
    {
        uart_rx.lock.acquire();

        while (1)
        {
            if ((*(volatile uint8 *)(UART0 + LSR) & LSR_RX_READY) == 0)
                break;

            char c = *(volatile uint8 *)(UART0 + RHR);

            uart_rx.buf[uart_rx.w % UART_RX_BUF_SIZE] = c;
            uart_rx.w++;

            ProcManager::wakeup(&uart_rx);
        }

        uart_rx.lock.release();
    }

    // Modern console read: Line buffering + Editing Keys + Echo
    int console_read(uint64 target, int len)
    {
        struct Proc *p = myproc();
        int target_idx = 0;

        cons.lock.acquire();

        while (target_idx < len)
        {
            while (cons.r < cons.w)
            {
                char c = cons.buf[cons.r++ % sizeof(cons.buf)];
                cons.lock.release();

                if (VM::copyout(p->pagetable, target + target_idx, &c, 1) < 0)
                    return -1;

                target_idx++;
                if (c == '\n')
                    return target_idx;
                if (target_idx == len)
                    return target_idx;

                cons.lock.acquire();
            }

            uart_rx.lock.acquire();
            while (uart_rx.r == uart_rx.w)
            {
                if (p->xstate)
                {
                    uart_rx.lock.release();
                    cons.lock.release();
                    return -1;
                }
                cons.lock.release();
                ProcManager::sleep(&uart_rx, &uart_rx.lock);
                cons.lock.acquire();
            }

            char c = uart_rx.buf[uart_rx.r++ % UART_RX_BUF_SIZE];
            uart_rx.lock.release();

            if (c == 127 || c == '\b')
            {
                if (cons.e != cons.w)
                {
                    cons.e--;
                    uart_putc('\b');
                    uart_putc(' ');
                    uart_putc('\b');
                }
            }
            else
            {
                if (c == '\r')
                    c = '\n';

                uart_putc(c);

                cons.buf[cons.e++ % sizeof(cons.buf)] = c;

                if (c == '\n' || cons.e == cons.w + sizeof(cons.buf))
                {
                    cons.w = cons.e;
                    ProcManager::wakeup(&cons);
                }
            }
        }

        cons.lock.release();
        return target_idx;
    }
}