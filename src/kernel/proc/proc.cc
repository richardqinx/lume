#include "kernel/proc.h"
#include "kernel/pmm.h"
#include "drivers/uart.h"

#define NPROC 10

void str_copy(char *dst, const char *src)
{
    while (*src)
        *dst++ = *src++;
    *dst = 0;
}

extern "C" void swtch(struct Context *old_ctx, struct Context *new_ctx);

struct Proc procs[NPROC];
struct Context main_context;

namespace ProcManager
{
    void init()
    {
        for (int i = 0; i < NPROC; i++)
        {
            procs[i].state = UNUSED;
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
        struct Proc *p = nullptr;
        for(int i = 0; i < NPROC; i++)
        {
            if (procs[i].state == RUNNING)
            {
                p = &procs[i];
                break;
            }
        }
        if(p)
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
            // int nothing_to_run = 1;

            intr_off();

            for (p = procs; p < &procs[NPROC]; p++)
            {
                if (p->state == RUNNABLE)
                {
                    // nothing_to_run = 0;

                    p->state = RUNNING;

                    intr_on();

                    swtch(&main_context, &p->context);

                    intr_off();
                }
            }
        }
    }
}