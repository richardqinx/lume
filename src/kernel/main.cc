#include "drivers/uart.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"

void print_hex(uint64_t val)
{
    char buf[17];
    buf[16] = 0;
    const char *digits = "0123456789ABCDEF";
    for (int i = 15; i >= 0; i--)
    {
        buf[i] = digits[val & 0xf];
        val >>= 4;
    }
    Drivers::uart_puts("0x");
    Drivers::uart_puts(buf);
}

extern "C" void kernel_main()
{

    Drivers::uart_init();
    Drivers::uart_puts("\n[Modern DOS Kernel] Booted in S-Mode.\n");
    Drivers::uart_puts("2025 Richard Qin\n");
    Drivers::uart_puts("\n");

    Drivers::uart_puts("[Kernel] Initializing PMM...\n");
    PMM::init();
    Drivers::uart_puts("[Kernel] PMM initialized.\n");

    Drivers::uart_puts("[Kernel] Testing alloc_page...\n");
    void *p1 = PMM::alloc_page();
    void *p2 = PMM::alloc_page();

    Drivers::uart_puts("Allocated Page 1: ");
    print_hex((uint64_t)p1);
    Drivers::uart_puts("\n");

    Drivers::uart_puts("Allocated Page 2: ");
    print_hex((uint64_t)p2);
    Drivers::uart_puts("\n");

    Drivers::uart_puts("[Kernel] Freeing Page 1...\n");
    PMM::free_page(p1);

    void *p3 = PMM::alloc_page();
    Drivers::uart_puts("Allocated Page 3: ");
    print_hex((uint64_t)p3);
    Drivers::uart_puts("\n");

    if (p3 == p1)
    {
        Drivers::uart_puts("[Test Passed] Reuse freed memory successfully.\n");
    }
    else
    {
        Drivers::uart_puts("[Test Failed] Memory leak or logic error.\n");
    }

    VM::kvminit();
    Drivers::uart_puts("[Boot] Kernel page table created.\n");

    VM::kvminithart();
    Drivers::uart_puts("[Boot] MMU ENABLED! We are now using virtual addresses.\n");

    while (1)
    {

    }
}