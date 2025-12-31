#pragma once
#include "common/types.h"

namespace Drivers
{
    void uart_init();
    void uart_putc(char c);

    void uart_puts(const char *s);
    void uart_put_int(int value);
    void print_hex(uint64 value);
}