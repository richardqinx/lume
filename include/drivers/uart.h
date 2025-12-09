#pragma once
typedef unsigned long long uint64_t;

namespace Drivers {
    void uart_init();
    void uart_putc(char c);
    void uart_puts(const char* s);
    void print_hex(uint64_t val);
}