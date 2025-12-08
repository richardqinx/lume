#pragma once

namespace Drivers {
    void uart_init();
    void uart_putc(char c);
    void uart_puts(const char* s);
}