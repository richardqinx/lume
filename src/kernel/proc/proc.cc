#include "kernel/proc.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"
#include "drivers/uart.h"
#include "kernel/trap.h"
#include "common/types.h"
#include "kernel/riscv.h"
#include "kernel/config.h"

#define NPROC 10

extern "C" void swtch(struct Context *old_ctx, struct Context *new_ctx);
extern char uservec[];
extern "C" void userret(uint64, uint64);
extern char trampoline[];
extern void *memset(void *dst, int c, uint n);

struct Proc procs[NPROC];
struct Context main_context;
struct Proc *current_proc = nullptr;

void str_copy(char *dst, const char *src)
{
    while (*src)
        *dst++ = *src++;
    *dst = 0;
}

uchar initcode[] = {
    0x13, 0x05, 0x50, 0x05, // li a0, 85 ('U')
    0x93, 0x08, 0x10, 0x00, // li a7, 1  (SYS_putc)
    0x73, 0x00, 0x00, 0x00, // ecall
    0x6f, 0xf0, 0x5f, 0xff  // j loop (-12)
};

struct Proc *myproc()
{
    return current_proc;
}

void usertrapret()
{
    struct Proc *p = myproc();

    asm volatile("csrc sstatus, %0" : : "r"(SSTATUS_SIE));

    uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    asm volatile("csrw stvec, %0" : : "r"(trampoline_uservec));

    p->tf->kernel_satp = r_satp();
    p->tf->kernel_sp = (uint64)p->kstack + PGSIZE;
    p->tf->kernel_trap = (uint64)usertrap;
    p->tf->kernel_hartid = r_tp();

    unsigned long x = r_sstatus();
    x &= ~SSTATUS_SPP;
    x |= SSTATUS_SPIE;
    w_sstatus(x);

    w_sepc(p->tf->epc);

    uint64 satp = MAKE_SATP(p->pagetable);

    uint64 fn = TRAMPOLINE + ((uint64)userret - (uint64)trampoline);
    ((void (*)(uint64, uint64))fn)(TRAPFRAME, satp);
}

void forkret()
{
    //....



    usertrapret();
}

namespace ProcManager
{
    void init()
    {
        for (int i = 0; i < NPROC; i++)
        {
            procs[i].state = UNUSED;
            procs[i].kstack = 0;
        }
    }

    void create_kernel_thread(void (*func)(), const char *name)
    {
        struct Proc *p = nullptr;
        for(int i = 0; i < NPROC; i++)
        {
            if(procs[i].state == UNUSED)
            {
                p = &procs[i];
                p->pid = i + 1;
                break;
            }
        }

        if (!p)
        {
            Drivers::uart_puts("Error: No free process slots!\n");
            return;
        }

        p->kstack = PMM::alloc_page();
        if (!p->kstack)
        {
            Drivers::uart_puts("Error: Alloc kstack failed!\n");
            return;
        }

        p->context.ra = (uint64)func;

        p->context.sp = (uint64)p->kstack + 4096;

        p->state = RUNNABLE;
        str_copy(p->name, name);

        Drivers::uart_puts("[Proc] Created thread: ");
        Drivers::uart_puts(name);
        Drivers::uart_puts("\n");
    }

    void yield()
    {
        struct Proc *p = myproc();
        if (p && p->state == RUNNING)
        {
            p->state = RUNNABLE;
            swtch(&p->context, &main_context);
        }
    }

    void scheduler()
    {
        struct Proc *p = nullptr;
        Drivers::uart_puts("[Proc] Scheduler started.\n");

        for (;;)
        {
            int nothing_found = 1;

            intr_on();

            for (p = procs; p < &procs[NPROC]; p++)
            {
                if (p->state == RUNNABLE)
                {
                    nothing_found = 0;

                    p->state = RUNNING;

                    current_proc = p;

                    swtch(&main_context, &p->context);

                    current_proc = nullptr;
                }
            }
            if (nothing_found)
            {
                asm volatile("wfi");
            }
        }
    }

    void user_init()
    {
        struct Proc *p = nullptr;
        for(int i = 0; i < NPROC; ++i)
        {
            if(procs[i].state == UNUSED)
            {
                p = &procs[i];
                p->pid = i + 1;
                break;
            }
        }

        if (!p)
        {
            Drivers::uart_puts("user_init: no free procs\n");
            return;
        }

        p->kstack = PMM::alloc_page();
        if (p->kstack == 0)
        {
            Drivers::uart_puts("user_init: kstack alloc failed\n");
            return;
        }

        p->tf = (struct Trapframe*)PMM::alloc_page();

        if (p->tf == 0)
        {
            Drivers::uart_puts("user_init: tf alloc failed\n");
            return;
        }
        memset(p->tf, 0, PGSIZE);

        p->pagetable = VM::uvmcreate();

        // if (VM::mappages(p->pagetable, TRAMPOLINE, PGSIZE,
        //                  (uint64)trampoline, PTE_R | PTE_X) < 0)
        // {
        //     Drivers::uart_puts("user_init: map trampoline failed\n");
        //     return;
        // }

        if (VM::mappages(p->pagetable, TRAPFRAME, PGSIZE,
                         (uint64)p->tf, PTE_R | PTE_W) < 0)
        {
            Drivers::uart_puts("user_init: map trapframe failed\n");
            return;
        }

        VM::uvminit(p->pagetable, initcode, sizeof(initcode));
        p->sz = PGSIZE;

        p->tf->epc = 0;
        p->tf->sp = PGSIZE;

        memset(&p->context, 0, sizeof(p->context));
        p->context.ra = (uint64)forkret;
        p->context.sp = (uint64)p->kstack + PGSIZE;

        p->state = RUNNABLE;

        const char *name = "initcode";
        for (int i = 0; name[i] && i < 15; i++)
            p->name[i] = name[i];

        Drivers::uart_puts("[Proc] user_init success. PID: 1\n");
    }
}