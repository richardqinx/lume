#include "kernel/proc.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"
#include "drivers/uart.h"
#include "kernel/trap.h"
#include "common/types.h"
#include "kernel/riscv.h"
#include "kernel/config.h"
#include "kernel/spinlock.h"
#include "lib/string.h"

#define NPROC 10
#define NCPU 8

extern "C" void swtch(struct Context *old_ctx, struct Context *new_ctx);
extern char uservec[];
extern "C" void userret(uint64, uint64);
extern char trampoline[];

struct Proc procs[NPROC];
struct Context main_context; // The main_context here should actually be one per CPU, but it's temporarily kept for compatibility with single-core logic
struct Proc *current_proc = nullptr;
struct Spinlock proc_lock;

struct cpu cpus[NCPU];

int nextpid = 1;

extern char initcode_start[];
extern char initcode_end[];

struct Proc *myproc()
{
    // Keep a simple implementation for now, should be changed later to:
    // push_off();
    // struct cpu *c = mycpu();
    // struct Proc *p = c->proc;
    // pop_off();
    // return p;
    return current_proc;
}

void usertrapret()
{
    struct Proc *p = myproc();

    intr_off();

    uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    w_stvec(trampoline_uservec);

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
    proc_lock.release();

    Drivers::uart_puts("[Proc] forkret: jumping to user.\n");
    usertrapret();
}

static Proc *allocproc()
{
    struct Proc* p;
    proc_lock.acquire();
    for (p = procs; p < &procs[NPROC]; p++)
    {
        if (p->state == UNUSED)
        {
            goto found;
        }
    }

    proc_lock.release();
    return 0;

found:
    p->state = USED;
    p->pid = nextpid++;

    if ((p->tf = (struct Trapframe *)PMM::alloc_page()) == 0)
    {
        p->state = UNUSED;
        proc_lock.release();
        return 0;
    }
    if ((p->kstack = PMM::alloc_page()) == 0)
    {
        PMM::free_page(p->tf);
        p->state = UNUSED;
        proc_lock.release();
        return 0;
    }
    memset(p->kstack, 0, PGSIZE);

    memset(&p->context, 0, sizeof(p->context));
    p->context.ra = (uint64)forkret;
    p->context.sp = (uint64)p->kstack + PGSIZE;

    proc_lock.release();
    return p;
}

static void freeproc(struct Proc *p)
{
    if (p->tf)
        PMM::free_page(p->tf);
    p->tf = 0;

    if (p->kstack)
        PMM::free_page(p->kstack);
    p->kstack = 0;

    if (p->pagetable)
        VM::uvmfree(p->pagetable, p->sz);
    p->pagetable = 0;

    p->sz = 0;
    p->pid = 0;
    p->parent = 0;
    p->name[0] = 0;
    p->chan = 0;
    p->state = UNUSED;
}

int fork()
{
    int pid;
    struct Proc *np;
    struct Proc *p = myproc();

    if ((np = allocproc()) == 0)
    {
        return -1;
    }

    np->pagetable = VM::uvmcreate();

    if (VM::uvmcopy(p->pagetable, np->pagetable, p->sz) < 0)
    {
        freeproc(np);
        proc_lock.release(); // Maybe a bug
        return -1;
    }
    np->sz = p->sz;

    if (VM::mappages(np->pagetable, TRAPFRAME, PGSIZE,
                     (uint64)np->tf, PTE_R | PTE_W) < 0)
    {
        freeproc(np);
        return -1;
    }

    *(np->tf) = *(p->tf);

    np->tf->a0 = 0;

    strcpy(np->name, p->name);
    np->parent = p;

    proc_lock.acquire();
    np->state = RUNNABLE;
    pid = np->pid;
    proc_lock.release();

    return pid;
}

namespace ProcManager
{
    void init()
    {
        proc_lock.init("proc");

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
        strcpy(p->name, name);

        Drivers::uart_puts("[Proc] Created thread: ");
        Drivers::uart_puts(name);
        Drivers::uart_puts("\n");
    }

    void yield()
    {
        struct Proc *p = myproc();
        proc_lock.acquire();
        if (p && p->state == RUNNING)
        {
            p->state = RUNNABLE;
            swtch(&p->context, &main_context);
        }
        proc_lock.release();
    }

    void scheduler()
    {
        struct Proc *p = nullptr;
        Drivers::uart_puts("[Proc] Scheduler started.\n");

        for (;;)
        {
            intr_on();

            proc_lock.acquire();

            for (p = procs; p < &procs[NPROC]; p++)
            {
                if (p->state == RUNNABLE)
                {
                    p->state = RUNNING;
                    current_proc = p;
                    // Switch context: from scheduler to process
                    swtch(&main_context, &p->context);
                    // The process returns here after yielding the CPU
                    current_proc = nullptr;
                }
            }
            proc_lock.release();
        }
    }

    void user_init()
    {
        struct Proc *p;

        p = allocproc();
        if (!p)
        {
            Drivers::uart_puts("user_init: failed\n");
            return;
        }

        p->pagetable = VM::uvmcreate();

        uint64 initcode_sz = initcode_end - initcode_start;
        VM::uvminit(p->pagetable, (uchar *)initcode_start, initcode_sz);
        p->sz = PGSIZE;

        if (VM::mappages(p->pagetable, TRAPFRAME, PGSIZE,
                         (uint64)p->tf, PTE_R | PTE_W) < 0)
        {
            Drivers::uart_puts("user_init: map trapframe failed\n");
            return;
        }

        
        p->tf->epc = 0;
        p->tf->sp = PGSIZE;

        strcpy(p->name, "initcode");

        
        proc_lock.acquire();
        p->state = RUNNABLE;
        proc_lock.release();

        Drivers::uart_puts("[Proc] user_init success. PID: 1\n");
    }

    void sleep(void *chan, struct Spinlock *lk)
    {
        struct Proc *p = myproc();
        if(lk != &proc_lock)
        {
            proc_lock.acquire();
            lk->release();
        }
        p->chan = chan;
        p->state = SLEEPING;

        swtch(&p->context, &main_context);

        p->chan = 0;

        if (lk != &proc_lock)
        {
            proc_lock.release();
            lk->acquire();
        }
    }

    void wakeup(void *chan)
    {
        for(struct Proc *p = procs; p < &procs[NPROC]; p++)
        {
            if (p->state == SLEEPING && p->chan == chan)
            {
                p->state = RUNNABLE;
            }
        }
    }

    void exit(int status)
    {
        struct Proc *p = myproc();
        struct Proc *initproc = &procs[0];

        if (p == initproc)
        {
            Drivers::uart_puts("init exiting!\n");
            while (1)
                ;
        }

        proc_lock.acquire();
        wakeup(p->parent);

        for (struct Proc *pp = procs; pp < &procs[NPROC]; pp++)
        {
            if (pp->parent == p)
            {
                pp->parent = initproc;
                wakeup(initproc);
            }
        }

        p->xstate = status;
        p->state = ZOMBIE;

        swtch(&p->context, &main_context);

        while(1);
    }

    int wait(uint64 addr)
    {
        struct Proc* np;
        int havekids, pid;
        struct Proc *p = myproc();

        proc_lock.acquire();

        for(;;)
        {
            havekids = 0;
            for (np = procs; np < &procs[NPROC]; np++)
            {
                if (np->parent == p)
                {
                    havekids = 1;
                    if (np->state == ZOMBIE)
                    {
                        // Found one
                        pid = np->pid;
                        if (addr != 0)
                        {
                            // copyout(p->pagetable, addr, (char*)&np->xstate, sizeof(np->xstate));
                            // 暂时不做 copyout
                        }
                        freeproc(np);
                        proc_lock.release();
                        return pid;
                    }
                }
            }
            if (!havekids || p->state == ZOMBIE)
            {
                proc_lock.release();
                return -1;
            }
            // sleep will atomically release proc_lock and sleep
            // When returning, it will reacquire proc_lock
            sleep(p, &proc_lock);
        }
    }



}