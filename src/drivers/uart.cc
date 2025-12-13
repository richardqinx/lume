#include "drivers/uart.h"
#include "common/types.h"
#include "kernel/config.h"

// #define UART0_BASE          0x10000000L

#define UART_RBR            0x00 // Receiver Buffer Register (Read)
#define UART_THR            0x00 // Transmitter Holding Register (Write)
#define UART_IER            0x01 // Interrupt Enable Register
#define UART_FCR            0x02 // FIFO Control Register
#define UART_LCR            0x03 // Line Control Register
#define UART_LSR            0x05 // Line Status Register

#define UART_LSR_RX_READY   0x01
#define UART_LSR_TX_EMPTY   0x20

namespace Drivers{
    inline volatile uint8_t &reg(uint32_t offset)
    {
        return *reinterpret_cast<volatile uint8_t *>(g_uart_base + offset);
    }

    void uart_init()
    {
        
        if (g_uart_base == 0)
            return;

        reg(UART_IER) = 0x00;

        reg(UART_LCR) = 0x80;
        reg(0x00) = 0x03;
        reg(0x01) = 0x00;

        reg(UART_LCR) = 0x03;

        reg(UART_FCR) = 0x07; // Enable FIFO, clear TX/RX queues
    }

    void uart_putc(char c)
    {
        if (c == '\n')
        {
            uart_putc('\r');
        }

        while ((reg(UART_LSR) & UART_LSR_TX_EMPTY) == 0)
        {

        }

        reg(UART_THR) = c;
    }

    void uart_puts(const char *s)
    {
        while (*s)
        {
            uart_putc(*s++);
        }
    }

    void print_hex(uint64_t val)
    {
        char buf[20];
        const char *digits = "0123456789ABCDEF";
        buf[0] = '0';
        buf[1] = 'x';
        for (int i = 0; i < 16; i++)
        {
            buf[17 - i] = digits[val & 0xF];
            val >>= 4;
        }
        buf[18] = 0;
        Drivers::uart_puts(buf);
    }
}