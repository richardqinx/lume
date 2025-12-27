#include "kernel/trap.h"
#include "common/types.h"
#include "drivers/uart.h"
#include "kernel/proc.h"
#include "kernel/timer.h"
#include "kernel/syscall.h"
#include "kernel/riscv.h"

extern void usertrapret();
extern void forkret();

void panic(const char *s)
{
    Drivers::uart_puts("\n\n!!! KERNEL PANIC !!!\n");
    Drivers::uart_puts(s);
    Drivers::uart_puts("\nSystem Halted.\n");
    while (1)
        ;
}

namespace Trap
{
    void init()
    {
        uint64 stvec_val = (uint64)kernelvec;
        asm volatile("csrw stvec, %0" : : "r"(stvec_val));

        uint64 sstatus;
        asm volatile("csrr %0, sstatus" : "=r"(sstatus));
        sstatus &= ~(1L << 1);
        asm volatile("csrw sstatus, %0" : : "r"(sstatus));

        Drivers::uart_puts("[Trap] Initialized stvec to: ");
        Drivers::print_hex(stvec_val);
        Drivers::uart_puts("\n");
    }

    extern "C" void kerneltrap(struct Trapframe *tf)
    {
        uint64 scause, stval, sepc;

        asm volatile("csrr %0, scause" : "=r"(scause));
        asm volatile("csrr %0, stval" : "=r"(stval));
        asm volatile("csrr %0, sepc" : "=r"(sepc));

        if (scause & (1L << 63))
        {
            uint64 cause_code = scause & 0x7FFFFFFFFFFFFFFFL;
            switch (cause_code)
            {
            case 1:
                Drivers::uart_puts("[IRQ] Software Interrupt (Unexpected)\n");
                break;

            case 5:
                Drivers::uart_puts("[IRQ] Timer Interrupt\n");
                Timer::set_next_trigger();
                ProcManager::yield();
                break;
            
            case 9:
                Drivers::uart_puts("[IRQ] External Interrupt\n");
                break;

            default:
                Drivers::uart_puts("[IRQ] Unknown Interrupt: ");
                Drivers::print_hex(cause_code);
                Drivers::uart_puts("\n");
                break;
            }
        }
        else
        {
            switch (scause)
            {
            case 8:
                Drivers::uart_puts("[Syscall] ecall from Kernel Mode? Panic.\n");
                panic("Kernel Ecall");
                break;

            case 12:
            case 13:
            case 15:
                Drivers::uart_puts("\n--- PAGE FAULT ---\n");
                Drivers::uart_puts("Cause Code: ");
                Drivers::print_hex(scause);
                Drivers::uart_puts("\n");
                Drivers::uart_puts("Fault Addr (stval): ");
                Drivers::print_hex(stval);
                Drivers::uart_puts("\n");
                Drivers::uart_puts("Instruction (sepc): ");
                Drivers::print_hex(sepc);
                Drivers::uart_puts("\n");

                if (stval == 0)
                {
                    panic("Null Pointer Dereference!");
                }
                else if (stval < 0x80000000)
                {
                    panic("Invalid Low Memory Access!");
                }
                else
                {
                    panic("Segmentation Fault (Unmapped Area)");
                }
                break;

            case 2:
                Drivers::uart_puts("\n--- ILLEGAL INSTRUCTION ---\n");
                Drivers::uart_puts("Instruction (sepc): ");
                Drivers::print_hex(sepc);
                Drivers::uart_puts("\n");
                panic("CPU encountered an unknown opcode");
                break;

            default:
                Drivers::uart_puts("\n--- UNHANDLED EXCEPTION ---\n");
                Drivers::uart_puts("Cause: ");
                Drivers::print_hex(scause);
                Drivers::uart_puts("\n");
                Drivers::uart_puts("sepc: ");
                Drivers::print_hex(sepc);
                Drivers::uart_puts("\n");
                panic("System Halt");
                break;
            }
        }
    }
}

extern "C" void usertrap()
{
    asm volatile("csrw stvec, %0" : : "r"(Trap::kernelvec));

    uint64 scause;
    asm volatile("csrr %0, scause" : "=r"(scause));

    struct Proc *p = myproc();
    
    extern struct Proc procs[];
    if (!p)
    {
        for (int i = 0; i < 10; ++i)
            if (procs[i].state == RUNNING)
                p = &procs[i];
    }

    uint64 sepc;
    asm volatile("csrr %0, sepc" : "=r"(sepc));
    p->tf->epc = sepc;

    if(scause == 8)
    {
        intr_on();
        p->tf->epc += 4;

        syscall();

        intr_off();
    }
    else if ((scause & (1L << 63)) && (scause & 0xF) == 5)
    {
        Drivers::uart_puts("\nTick\n");
        Timer::set_next_trigger();
        ProcManager::yield();
    }
    else
    {
        Drivers::uart_puts("Unexpected User Trap!\n");
        Drivers::print_hex(scause);
        while (1)
            ;
    }

    usertrapret();
}