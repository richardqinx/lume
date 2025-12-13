#include "drivers/uart.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"
#include "kernel/trap.h"
#include "kernel/proc.h"
#include "kernel/timer.h"
#include "kernel/config.h"

void fdt_init(uint64 dtb);

void delay()
{
    for(volatile int i = 0; i < 1000000; i++)
    {

    }
}

void task_a()
{
    while(1)
    {
        Drivers::uart_putc('A');
        delay();
        // ProcManager::yield();
    }
}

void task_b()
{
    while (1)
    {
        Drivers::uart_putc('B');
        delay();
        // ProcManager::yield();
    }
    
}

extern "C" void kernel_main()
{

    fdt_init(g_dtb_addr);
    Drivers::uart_init();
    Drivers::uart_puts("\n[Lume OS Kernel] Booted in S-Mode.\n");
    Drivers::uart_puts("2025 Richard Qin\n");
    Drivers::uart_puts("\n");
    Drivers::uart_puts("\n[Boot] Kernel started.\n");

    PMM::init();
    Drivers::uart_puts("[Boot] PMM initialized.\n");

    VM::kvminit();
    Drivers::uart_puts("[Boot] Kernel page table created.\n");

    VM::kvminithart();
    Drivers::uart_puts("[Boot] MMU ENABLED! We are now using virtual addresses.\n");

    Trap::init();
    Drivers::uart_puts("[Boot] Trap Handler Installed.\n");

    Timer::init();
    Drivers::uart_puts("[Boot] Timer Interrupt Enabled.\n");

    ProcManager::init();
    Drivers::uart_puts("[Boot] ProcManager Initialized.\n");

    void task_a();
    void task_b();
    ProcManager::create_kernel_thread(task_a, "Task A");
    ProcManager::create_kernel_thread(task_b, "Task B");

    Drivers::uart_puts("[Kernel] Scheduler Starting...\n");
    ProcManager::scheduler();
}