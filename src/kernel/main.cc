#include "drivers/uart.h"

extern "C" void kernel_main()
{

    Drivers::uart_init();

    Drivers::uart_puts("\n");
    Drivers::uart_puts("Modern DOS v1.0 [RISC-V 64]\n");
    Drivers::uart_puts("2025 Richard Qin\n");
    Drivers::uart_puts("\n");

    Drivers::uart_puts("A:\\> ");


    while (1)
    {

    }
}