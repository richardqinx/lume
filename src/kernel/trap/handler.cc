#include "kernel/trap.h"
#include "kernel/riscv.h"
#include "kernel/proc.h"
#include "drivers/uart.h"
#include "kernel/syscall.h"
#include "kernel/mm.h"
#include "kernel/timer.h"
#include "drivers/plic.h"
#include "drivers/virtio.h"
#include "lib/string.h"


extern "C" void kernelvec();

// Handle Function

void panic(const char *s)
{
    Drivers::uart_puts("\n\n!!! KERNEL PANIC !!!\n");
    Drivers::uart_puts(s);
    Drivers::uart_puts("\nSystem Halted.\n");
    while (1)
        ;
}

// Trap Implementation

namespace Trap
{
    void init()
    {
        Drivers::uart_puts("[Trap] Global init done.\n");
    }

    // Each CPU core needs to call this function when starting to set its own stvec
    void inithart()
    {
        w_stvec((uint64)kernelvec);

        // Ensure that the S-Mode interrupt enable bit (SIE) is cleared during initialization
        // Interrupt enabling will be done by the scheduler when the first process runs
        w_sstatus(r_sstatus() & ~SSTATUS_SIE);

        // Enable the external interrupt, clock interrupt, and software interrupt bits in S-Mode (in SIE register)
        uint64 sie = r_sie();
        sie |= SIE_SEIE | SIE_STIE | SIE_SSIE;
        w_sie(sie);

        Drivers::uart_puts("[Trap] Hart initialized (stvec set).\n");
    }

    // Device Interrupt Check
    int devintr()
    {
        uint64 scause = r_scause();

        bool is_interrupt = (scause & 0x8000000000000000L) != 0;
        uint64 code = scause & 0xff;

        if (is_interrupt && code == 9)
        {
            // Supervisor External Interrupt (IRQ 9)
            int irq = PLIC::claim();

            if (irq == 10)
            {
                Drivers::uart_intr();
                // Debug
                // Drivers::uart_puts("[Interrupt] UART Input detected!\n");
            }
            else if (irq >= 1 && irq <= 8)
            {
                VirtIO::intr();
                // Debug
                // Drivers::uart_puts("[Interrupt] VirtIO disk finished!\n");
            }

            if (irq > 0)
            {
                PLIC::complete(irq);
            }

            return 1;
        }
        else if (is_interrupt && code == 5)
        {
            // Supervisor Timer Interrupt (IRQ 5)
            Timer::set_next_trigger();
            // w_sip(r_sip() & ~2);
            return 2;
        }

        return 0;
    }
}

// Exception Handling Entry

extern "C" void kerneltrap(struct Trapframe *tf)
{
    uint64 sepc = r_sepc();
    uint64 sstatus = r_sstatus();
    uint64 scause = r_scause();

    if ((sstatus & SSTATUS_SPP) == 0)
        panic("kerneltrap: not from supervisor mode");

    if (intr_get() != 0)
        panic("kerneltrap: interrupts enabled");

    if (Trap::devintr() == 0)
    {
        Drivers::uart_puts("\n--- KERNEL EXCEPTION ---\n");
        Drivers::uart_puts("scause: ");
        Drivers::print_hex(scause);
        Drivers::uart_puts("\n");
        Drivers::uart_puts("sepc:   ");
        Drivers::print_hex(sepc);
        Drivers::uart_puts("\n");
        Drivers::uart_puts("stval:  ");
        Drivers::print_hex(r_stval());
        Drivers::uart_puts("\n");
        panic("kerneltrap exception");
    }

    w_sepc(sepc);
    w_sstatus(sstatus);
}

extern "C" void usertrap()
{
    // Drivers::uart_puts("[Debug] Entered usertrap!\n");
    int which_dev = 0;

    if ((r_sstatus() & SSTATUS_SPP) != 0)
        panic("usertrap: not from user mode");

    w_stvec((uint64)kernelvec);

    struct Proc *p = myproc();
    if (!p)
        panic("usertrap: no process");

    p->tf->epc = r_sepc();

    uint64 scause = r_scause();
    uint64 stval = r_stval();

    if (scause == 8) // Syscall
    {
        if (p->state == ZOMBIE)
            ProcManager::exit(-1);
        p->tf->epc += 4;
        intr_on();
        syscall();
        intr_off();
    }
    else if (scause == 15) // Store Page Fault
    {
        if (VM::handle_cow_fault(p->pagetable, PGROUNDDOWN(stval)) != 0)
        {
            Drivers::uart_puts("usertrap: cow failed at ");
            Drivers::print_hex(stval);
            Drivers::uart_puts("\n");
            p->state = ZOMBIE;
            ProcManager::exit(-1);
        }
    }
    else if ((which_dev = Trap::devintr()) != 0)
    {
        if (which_dev == 2)
        {
            ProcManager::yield();
        }
    }
    else
    {
        Drivers::uart_puts("\nusertrap(): unexpected scause ");
        Drivers::print_hex(scause);
        Drivers::uart_puts(" pid=");
        Drivers::uart_put_int(p->pid);
        Drivers::uart_puts(" sepc=");
        Drivers::print_hex(p->tf->epc);
        Drivers::uart_puts(" stval=");
        Drivers::print_hex(stval);
        Drivers::uart_puts("\n");
        p->state = ZOMBIE;
        ProcManager::exit(-1);
    }

    if (p->state == ZOMBIE)
        ProcManager::exit(-1);

    usertrapret();
}