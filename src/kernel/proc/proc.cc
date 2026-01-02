#include "kernel/proc.h"
#include "kernel/proc_def.h"
#include "kernel/runqueue.h"
#include "kernel/cpu.h"
#include "kernel/spinlock.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"
#include "kernel/trap.h"
#include "kernel/riscv.h"
#include "kernel/slab.h"
#include "drivers/uart.h"
#include "fs/fs.h"
#include "fs/file.h"
#include "lib/string.h"

// #define NPROC 64
#define NCPU 8

extern "C" void swtch(struct Context *old_ctx, struct Context *new_ctx);
extern char uservec[], trampoline[];
extern "C" void usertrap();
extern "C" void userret(uint64, uint64);
extern char initcode_start[], initcode_end[];

// struct Proc procs[NPROC];
struct Proc *proc_list_head = nullptr;
struct Proc *initproc = nullptr;
struct Spinlock proc_mem_lock;
struct cpu cpus[NCPU];
struct RunQueue runqueues[NCPU];


static int nextpid = 1;


struct cpu *mycpu()
{
    int id = r_tp();
    return &cpus[id];
}


void RunQueue::init(const char *name)
{
    lock.init(name);
    count = 0;
    for (int i = 0; i < N_PRIO; i++)
    {
        heads[i] = nullptr;
        tails[i] = nullptr;
    }
}

void RunQueue::enqueue(struct Proc *p)
{
    if (p->priority < 0 || p->priority >= N_PRIO)
        p->priority = PRIO_MIN;
    p->next = nullptr;
    if (heads[p->priority] == nullptr)
    {
        heads[p->priority] = p;
        tails[p->priority] = p;
    }
    else
    {
        tails[p->priority]->next = p;
        tails[p->priority] = p;
    }
    count++;
}

struct Proc *RunQueue::dequeue()
{
    for (int i = 0; i < N_PRIO; i++)
    {
        if (heads[i])
        {
            struct Proc *p = heads[i];
            heads[i] = p->next;
            if (!heads[i])
                tails[i] = nullptr;
            p->next = nullptr;
            count--;
            return p;
        }
    }
    return nullptr;
}

struct Proc *RunQueue::steal()
{
    for (int i = N_PRIO - 1; i >= 0; i--)
    {
        if (heads[i])
        {
            struct Proc *p = heads[i];
            heads[i] = p->next;
            if (!heads[i])
                tails[i] = nullptr;
            p->next = nullptr;
            count--;
            return p;
        }
    }
    return nullptr;
}

//  Trap Return Functions

void usertrapret()
{
    struct Proc *p = myproc();

    intr_off();

    // Set stvec to point to uservec in the trampoline
    // When an interrupt occurs in user mode, the CPU will jump here
    uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    w_stvec(trampoline_uservec);

    // Fill in the Trapframe, used when uservec saves the kernel state
    p->tf->kernel_satp = r_satp();
    p->tf->kernel_sp = (uint64)p->kstack + PGSIZE;
    p->tf->kernel_trap = (uint64)usertrap;
    p->tf->kernel_hartid = r_tp();

    // Set SSTATUS
    // SPP = 0 (return to User Mode)
    // SPIE = 1 (enable interrupts)
    unsigned long x = r_sstatus();
    x &= ~SSTATUS_SPP;
    x |= SSTATUS_SPIE;
    w_sstatus(x);

    // Set SEPC to the user program counter
    w_sepc(p->tf->epc);

    // Prepare user page table SATP
    uint64 satp = MAKE_SATP(p->pagetable);

    // Calculate the virtual address of userret in the trampoline
    uint64 fn = TRAMPOLINE + ((uint64)userret - (uint64)trampoline);

    // Jump to userret, with parameters being the TRAPFRAME address and the user page table SATP
    ((void (*)(uint64, uint64))fn)(TRAPFRAME, satp);
}


void forkret()
{

    struct cpu *c = mycpu();
    c->runqueue->lock.release();

    Drivers::uart_puts("[Proc] forkret: jumping to user.\n");

    // Enter user mode
    usertrapret();
}

//  ProcManager Implementation

static Proc *allocproc()
{
    struct Proc *p;
    proc_mem_lock.acquire();

    p = (struct Proc *)Slab::kmalloc(sizeof(struct Proc));

    if (!p)
    {
        proc_mem_lock.release();
        return 0;
    }

    memset(p, 0, sizeof(struct Proc));

    p->all_next = proc_list_head;
    p->all_prev = nullptr;
    if (proc_list_head)
        proc_list_head->all_prev = p;
    proc_list_head = p;


    p->state = USED;
    p->pid = nextpid++;
    p->priority = 0;
    p->cpu = mycpu();
    p->cwd = nullptr;
    for (int i = 0; i < NOFILE; i++)
        p->ofile[i] = nullptr;

    if ((p->tf = (struct Trapframe *)PMM::alloc_page()) == 0)
    {
        p->state = UNUSED;
        if (p->all_next)
            p->all_next->all_prev = p->all_prev;
        if (p->all_prev)
            p->all_prev->all_next = p->all_next;
        if (p == proc_list_head)
            proc_list_head = p->all_next;
        Slab::kfree(p);
        proc_mem_lock.release();
        return 0;
    }

    if ((p->kstack = PMM::alloc_page()) == 0)
    {
        PMM::free_page(p->tf);
        p->state = UNUSED;
        if (p->all_next)
            p->all_next->all_prev = p->all_prev;
        if (p->all_prev)
            p->all_prev->all_next = p->all_next;
        if (p == proc_list_head)
            proc_list_head = p->all_next;
        Slab::kfree(p);

        proc_mem_lock.release();
        return 0;
    }
    memset(p->kstack, 0, PGSIZE);

    memset(&p->context, 0, sizeof(p->context));

    // Set the context so that the next time this process is scheduled, it starts executing directly from forkret
    p->context.ra = (uint64)forkret;
    p->context.sp = (uint64)p->kstack + PGSIZE;
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
    for (int i = 0; i < NOFILE; i++)
    {
        if (p->ofile[i])
        {
            FileTable::close(p->ofile[i]);
            p->ofile[i] = nullptr;
        }
    }
    if (p->cwd)
    {
        VFS::iput(p->cwd);
        p->cwd = nullptr;
    }

    if (p->all_prev)
        p->all_prev->all_next = p->all_next;
    else
        proc_list_head = p->all_next;

    if (p->all_next)
        p->all_next->all_prev = p->all_prev;

    Slab::kfree(p);
}

int fork()
{
    struct Proc *np;
    struct Proc *p = myproc();

    if ((np = allocproc()) == 0)
        return -1;

    np->pagetable = VM::uvmcreate();
    np->sz = p->sz;
    if (VM::uvmcopy(p->pagetable, np->pagetable, p->sz) < 0)
    {
        freeproc(np);
        proc_mem_lock.release();
        return -1;
    }
    

    if (VM::mappages(np->pagetable, TRAPFRAME, PGSIZE, (uint64)np->tf, PTE_R | PTE_W) < 0)
    {
        freeproc(np);
        proc_mem_lock.release();
        return -1;
    }

    *(np->tf) = *(p->tf);
    np->tf->a0 = 0;
    strcpy(np->name, p->name);
    np->parent = p;
    np->priority = p->priority;

    for (int i = 0; i < NOFILE; i++)
    {
        if (p->ofile[i])
        {
            np->ofile[i] = FileTable::dup(p->ofile[i]);
        }
    }

    if (p->cwd)
    {
        np->cwd = VFS::idup(p->cwd);
    }

    proc_mem_lock.release();

    struct cpu *c = mycpu();
    c->runqueue->lock.acquire();
    np->state = RUNNABLE;
    c->runqueue->enqueue(np);
    c->runqueue->lock.release();

    return np->pid;
}

namespace ProcManager
{

    void init()
    {
        proc_mem_lock.init("proc_mem");

        proc_list_head = nullptr;

        for (int i = 0; i < NCPU; i++)
        {
            cpus[i].runqueue = &runqueues[i];
            cpus[i].runqueue->init("runqueue");
        }
    }

    void scheduler()
    {
        struct Proc *p;
        struct cpu *c = mycpu();
        c->proc = 0;
        Drivers::uart_puts("[Proc] Scheduler started (Per-CPU).\n");

        for (;;)
        {
            intr_on();

            // Get from the local queue
            c->runqueue->lock.acquire();
            p = c->runqueue->dequeue();
            c->runqueue->lock.release();

            // Work Stealing
            if (!p)
            {
                for (int i = 0; i < NCPU; i++)
                {
                    if ((uint64)i == r_tp())
                        continue;

                    struct cpu *victim = &cpus[i];
                    victim->runqueue->lock.acquire();
                    if (victim->runqueue->count > 0)
                        p = victim->runqueue->steal();
                    victim->runqueue->lock.release();
                    if (p)
                        break;
                }
            }

            if (p)
            {
                p->state = RUNNING;
                c->proc = p;

                c->runqueue->lock.acquire();
                swtch(&c->context, &p->context);
                c->runqueue->lock.release();

                c->proc = 0;
            }
        }
    }

    void yield()
    {
        struct Proc *p = myproc();
        struct cpu *c = mycpu();
        c->runqueue->lock.acquire();
        if (p && p->state == RUNNING)
        {
            p->state = RUNNABLE;
            if (p->priority < PRIO_MIN)
                p->priority++;
            c->runqueue->enqueue(p);
            swtch(&p->context, &c->context);
        }
        c->runqueue->lock.release();
    }

    void user_init()
    {
        struct Proc *p = allocproc();
        if (!p)
            return;

        initproc = p;

        p->pagetable = VM::uvmcreate();

        uint64 initcode_sz = initcode_end - initcode_start;
        Drivers::uart_puts("[Proc] initcode size: ");
        Drivers::uart_put_int(initcode_sz);
        Drivers::uart_puts(" bytes\n");

        uint64 code_pages = PGROUNDUP(initcode_sz) / PGSIZE;

        for (uint64 i = 0; i < code_pages; i++)
        {
            void *mem = PMM::alloc_page();
            if (!mem)
            {
                Drivers::uart_puts("user_init: out of memory for code\n");
                return;
            }
            memset(mem, 0, PGSIZE);

            uint64 src_offset = i * PGSIZE;
            uint64 copy_len = PGSIZE;
            if (src_offset + copy_len > initcode_sz)
            {
                copy_len = initcode_sz - src_offset;
            }
            memmove(mem, (void *)(initcode_start + src_offset), copy_len);

            if (VM::mappages(p->pagetable, i * PGSIZE, PGSIZE, (uint64)mem, PTE_R | PTE_W | PTE_X | PTE_U) < 0)
            {
                Drivers::uart_puts("user_init: mappages code failed\n");
                return;
            }
        }

        uint64 stack_va = (code_pages + 1) * PGSIZE;

        void *stack = PMM::alloc_page();
        if (!stack)
            return;
        memset(stack, 0, PGSIZE);

        if (VM::mappages(p->pagetable, stack_va, PGSIZE, (uint64)stack, PTE_R | PTE_W | PTE_U) < 0)
            return;

        if (VM::mappages(p->pagetable, TRAPFRAME, PGSIZE, (uint64)p->tf, PTE_R | PTE_W) < 0)
            return;

        p->tf->epc = 0;
        p->tf->sp = stack_va + PGSIZE;
        p->sz = stack_va + PGSIZE;
        strcpy(p->name, "initcode");

        p->cwd = nullptr;

        proc_mem_lock.release();

        struct cpu *c = &cpus[0];
        c->runqueue->lock.acquire();
        p->state = RUNNABLE;
        c->runqueue->enqueue(p);
        c->runqueue->lock.release();

        Drivers::uart_puts("[Proc] user_init success. PID: 1\n");
        asm volatile("fence.i");
    }

    void sleep(void *chan, Spinlock *lk)
    {
        struct Proc *p = myproc();
        struct cpu *c = mycpu();

        if (lk && lk != &proc_mem_lock)
            lk->release();

        c->runqueue->lock.acquire();
        p->chan = chan;
        p->state = SLEEPING;
        swtch(&p->context, &c->context);
        p->chan = 0;
        c->runqueue->lock.release();

        if (lk && lk != &proc_mem_lock)
            lk->acquire();
    }

    void wakeup(void *chan)
    {
        for (struct Proc *p = proc_list_head; p != nullptr; p = p->all_next)
        {
            if (p->state == SLEEPING && p->chan == chan)
            {
                struct cpu *c = mycpu();
                c->runqueue->lock.acquire();
                p->state = RUNNABLE;
                c->runqueue->enqueue(p);
                c->runqueue->lock.release();
            }
        }
    }

    void exit(int status)
    {
        struct Proc *p = myproc();
        if (p == initproc)
            while (1)
                ;

        wakeup(p->parent);

        proc_mem_lock.acquire();

        for (struct Proc *pp = proc_list_head; pp != nullptr; pp = pp->all_next)
        {
            if (pp->parent == p)
            {
                pp->parent = initproc;
                wakeup(initproc);
            }
        }

        proc_mem_lock.release();

        p->xstate = status;

        struct cpu *c = mycpu();
        c->runqueue->lock.acquire();
        p->state = ZOMBIE;
        swtch(&p->context, &c->context);
        while (1)
            ;
    }

    int wait(uint64 addr)
    {

        struct Proc *np;
        int havekids, pid;
        struct Proc *p = myproc();
        for (;;)
        {
            havekids = 0;
            proc_mem_lock.acquire();

            for (np = proc_list_head; np != nullptr; np = np->all_next)
            {
                if (np->parent == p)
                {
                    havekids = 1;
                    if (np->state == ZOMBIE)
                    {

                        struct cpu *child_cpu = np->cpu;
                        if (child_cpu)
                        {
                            proc_mem_lock.release();
                            child_cpu->runqueue->lock.acquire();
                            child_cpu->runqueue->lock.release();
                            proc_mem_lock.acquire();
                        }

                        pid = np->pid;
                        if (addr != 0 && VM::copyout(p->pagetable, addr, (char *)&np->xstate, sizeof(np->xstate)) < 0)
                        {
                            proc_mem_lock.release();
                            return -1;
                        }
                        freeproc(np);
                        proc_mem_lock.release();
                        return pid;
                    }
                }
            }
            proc_mem_lock.release();

            if (!havekids || p->state == ZOMBIE)
                return -1;
            sleep(p, &proc_mem_lock);
        }
    }

    int growproc(int n)
    {
        uint64 sz;
        struct Proc *p = myproc();

        sz = p->sz;

        if (n > 0)
        {
            // Call VM::uvmalloc to allocate memory
            // Parameters: page table, old size, new size, permissions (PTE_W)
            if ((sz = VM::uvmalloc(p->pagetable, sz, sz + n, PTE_W | PTE_R | PTE_U)) == 0)
            {
                return -1;
            }
        }
        else if (n < 0)
        {
            sz = VM::uvmdealloc(p->pagetable, sz, sz + n);
        }

        p->sz = sz;
        return 0;
    }

    void create_kernel_thread(void (*func)(), const char *name)
    {
        (void)func;
        (void)name;
    }
}