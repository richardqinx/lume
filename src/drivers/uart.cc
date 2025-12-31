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

namespace Drivers
{

    inline volatile uint8_t &reg(uint32_t offset)
    {
        return *reinterpret_cast<volatile uint8_t *>(g_uart_base + offset);
    }

    void uart_init()
    {
        if (g_uart_base == 0)
            return;

        reg(UART_IER) = 0x00; // Disable interrupt
        reg(UART_LCR) = 0x80; // Set baud rate (LATCH bit)
        reg(0x00) = 0x03;     // LSB
        reg(0x01) = 0x00;     // MSB
        reg(UART_LCR) = 0x03; // 8 bits, no parity, one stop bit
        reg(UART_FCR) = 0x07; // Enable FIFO, clear TX/RX queues
    }

    void uart_putc(char c)
    {
        if (g_uart_base == 0)
            return;

        if (c == '\n')
        {
            uart_putc('\r');
        }

        // Waiting for the send buffer to be empty
        while ((reg(UART_LSR) & UART_LSR_TX_EMPTY) == 0)
            ;

        reg(UART_THR) = c;
    }


    void uart_puts(const char *s)
    {
        while (*s)
        {
            uart_putc(*s++);
        }
    }

    void uart_put_int(int value)
    {
        if (value == 0)
        {
            uart_putc('0');
            return;
        }

        if (value < 0)
        {
            uart_putc('-');
            value = -value;
        }

        char buffer[16];
        int i = 0;
        while (value > 0)
        {
            buffer[i++] = (value % 10) + '0';
            value /= 10;
        }

        while (i > 0)
        {
            uart_putc(buffer[--i]);
        }
    }

    void print_hex(uint64 value)
    {
        uart_puts("0x");
        char hex[] = "0123456789abcdef";
        for (int i = 15; i >= 0; i--)
        {
            int nibble = (value >> (i * 4)) & 0xF;
            uart_putc(hex[nibble]);
        }
    }
}