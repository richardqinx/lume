/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * tty_uart.cc — UART → tty_driver adapter
 *
 * Bridges the 16550A UART hardware to the TTY subsystem.
 *
 * TX: Calls early_putc() for each character (same as before).
 * RX: Registers a PLIC IRQ handler. On UART RX interrupt,
 *     reads available bytes and feeds them to the line discipline
 *     via tty_receive_buf().
 *
 * QEMU virt UART:
 *   - IRQ 10 on the PLIC
 *   - 16550A register layout at the base address discovered from FDT
 */

#include <lume/tty.h>
#include <lume/irq.h>
#include <lume/addr.h>
#include <lume/fdt.h>
#include <lume/vmm.h>
#include <lume/errno.h>
#include <lume/klog.h>

#ifndef ENOIOCTLCMD
#define ENOIOCTLCMD 515
#endif

extern "C" void early_putc(char c);

/* 16550A register offsets */
static constexpr int UART_RBR = 0;  /* Receive Buffer Register */
static constexpr int UART_THR = 0;  /* Transmit Holding Register */
static constexpr int UART_IER = 1;  /* Interrupt Enable Register */
static constexpr int UART_IIR = 2;  /* Interrupt Identification Register */
static constexpr int UART_FCR = 2;  /* FIFO Control Register */
static constexpr int UART_LCR = 3;  /* Line Control Register */
static constexpr int UART_MCR = 4;  /* Modem Control Register */
static constexpr int UART_LSR = 5;  /* Line Status Register */

/* LSR bits */
static constexpr uint8 UART_LSR_DR   = 0x01;  /* Data Ready */
static constexpr uint8 UART_LSR_THRE = 0x20;  /* TX Holding Register Empty */

/* IER bits */
static constexpr uint8 UART_IER_RDI  = 0x01;  /* Received Data Available */

/* MCR bits */
static constexpr uint8 UART_MCR_DTR  = 0x01;  /* Data Terminal Ready */
static constexpr uint8 UART_MCR_RTS  = 0x02;  /* Request To Send */
static constexpr uint8 UART_MCR_OUT2 = 0x08;  /* Auxiliary output 2 — gates the
                                                 IRQ pin on PC-style 16550A.
                                                 Without this the UART
                                                 internally asserts but does
                                                 NOT propagate to the PLIC. */

/* QEMU virt default UART IRQ */
static constexpr uint32 UART_IRQ = 10;

/* UART MMIO base (virtual address) */
static volatile uint8* g_uart_base;
static tty_struct* g_uart_tty;

/* ================================================================== */
/*  UART MMIO helpers                                                 */
/* ================================================================== */

static inline uint8 uart_read(int reg)
{
    return g_uart_base[reg];
}

static inline void uart_write(int reg, uint8 val)
{
    g_uart_base[reg] = val;
}

static inline bool uart_rx_ready()
{
    return (uart_read(UART_LSR) & UART_LSR_DR) != 0;
}

static inline char uart_rx_char()
{
    return static_cast<char>(uart_read(UART_RBR));
}

/* ================================================================== */
/*  UART RX interrupt handler                                         */
/* ================================================================== */

static void uart_irq_handler(uint32 /*irq*/, void* arg)
{
    auto* tty = static_cast<tty_struct*>(arg);

    /* Read all available bytes from the FIFO */
    char buf[16];
    int count = 0;

    while (uart_rx_ready() && count < 16) {
        buf[count++] = uart_rx_char();
    }

    if (count > 0) {
        tty_receive_buf(tty, buf, count);
    }
}

/* ================================================================== */
/*  tty_driver_ops for UART                                           */
/* ================================================================== */

static int uart_tty_open_op(tty_struct* /*tty*/)
{
    return 0;
}

static void uart_tty_close_op(tty_struct* /*tty*/)
{
    /* Nothing to do */
}

static int uart_tty_write_op(tty_struct* /*tty*/, const char* buf, int count)
{
    for (int i = 0; i < count; i++) {
        early_putc(buf[i]);
    }
    return count;
}

static int uart_tty_write_room_op(tty_struct* /*tty*/)
{
    return TTY_BUF_SIZE;  /* Always room (blocking putc) */
}

static void uart_tty_put_char_op(tty_struct* /*tty*/, char ch)
{
    early_putc(ch);
}

static void uart_tty_flush_chars_op(tty_struct* /*tty*/)
{
    /* No buffering in early_putc, nothing to flush */
}

static int uart_tty_chars_in_buffer_op(tty_struct* /*tty*/)
{
    return 0;  /* No TX buffer */
}

static void uart_tty_flush_buffer_op(tty_struct* /*tty*/)
{
    /* No TX buffer to flush */
}

static int uart_tty_ioctl_op(tty_struct* /*tty*/, unsigned int /*cmd*/, uint64 /*arg*/)
{
    return -ENOIOCTLCMD;
}

static void uart_tty_hangup_op(tty_struct* /*tty*/)
{
    /* Disable UART RX interrupts */
    if (g_uart_base) {
        uart_write(UART_IER, 0);
    }
}

static const tty_driver_ops uart_ops = {
    .open           = uart_tty_open_op,
    .close          = uart_tty_close_op,
    .write          = uart_tty_write_op,
    .write_room     = uart_tty_write_room_op,
    .put_char       = uart_tty_put_char_op,
    .flush_chars    = uart_tty_flush_chars_op,
    .chars_in_buffer = uart_tty_chars_in_buffer_op,
    .flush_buffer   = uart_tty_flush_buffer_op,
    .ioctl          = uart_tty_ioctl_op,
    .throttle       = nullptr,
    .unthrottle     = nullptr,
    .hangup         = uart_tty_hangup_op,
};

const tty_driver uart_tty_driver = {
    .name        = "ttyS",
    .major       = 4,
    .minor_start = 64,
    .num         = 1,
    .ops         = &uart_ops,
};

/* ================================================================== */
/*  UART TTY init — discover base address, enable RX IRQ              */
/* ================================================================== */

void uart_tty_init(tty_struct* tty)
{
    g_uart_tty = tty;

    /* Discover UART base from FDT */
    DeviceNode* node = fdt_find_compatible("ns16550a");
    if (!node) {
        /* Try alternative compatible string */
        node = fdt_find_compatible("snps,dw-apb-uart");
    }

    uint64 uart_pa = 0;
    if (node) {
        uart_pa = node->get_prop_u64("reg", 0);
    }

    if (uart_pa == 0) {
        /* Fallback: QEMU virt default */
        uart_pa = 0x10000000;
    }

    g_uart_base = reinterpret_cast<volatile uint8*>(
        pa_to_va(phys_addr(uart_pa)).raw);

    /* Set FIFO control: enable FIFOs, clear RX/TX FIFOs, 1-byte trigger */
    uart_write(UART_FCR, 0x07);

    /* MCR: assert OUT2 (gates the IRQ pin on PC-style 16550A), plus
     * DTR/RTS for completeness.  Mirrors Linux drivers/tty/serial/8250/
     * 8250_port.c: serial8250_do_startup() does the same. */
    uart_write(UART_MCR, UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);

    /* Enable UART receive-data-available interrupt */
    uart_write(UART_IER, UART_IER_RDI);

    /* Register IRQ handler with PLIC */
    uint32 irq = UART_IRQ;
    if (node) {
        /* Try to get IRQ number from FDT */
        const FdtProperty* irq_prop = node->get_prop("interrupts");
        if (irq_prop && irq_prop->len >= 4) {
            const uint8* val = static_cast<const uint8*>(irq_prop->value);
            irq = (uint32(val[0]) << 24) | (uint32(val[1]) << 16) |
                  (uint32(val[2]) << 8) | val[3];
        }
    }

    g_irq_manager.register_handler(irq, uart_irq_handler, tty);
    g_irq_manager.enable(irq);

    printk(KERN_INFO "uart_tty_init: base=0x%llx irq=%u IER=0x%x LSR=0x%x\n",
           (unsigned long long)uart_pa, irq,
           uart_read(UART_IER), uart_read(UART_LSR));
}
