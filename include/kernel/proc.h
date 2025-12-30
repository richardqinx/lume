#pragma once
#include "common/types.h"
#include "kernel/trap.h"
#include "kernel/spinlock.h"

// Context structure, used for context switching
struct Context
{
    uint64 ra;
    uint64 sp;

    // Callee-saved registers
    uint64 s0;
    uint64 s1;
    uint64 s2;
    uint64 s3;
    uint64 s4;
    uint64 s5;
    uint64 s6;
    uint64 s7;
    uint64 s8;
    uint64 s9;
    uint64 s10;
    uint64 s11;
};

// Process State Enumeration
enum ProcState
{
    UNUSED,
    USED,
    SLEEPING,
    RUNNABLE,
    RUNNING,
    ZOMBIE,
};

// Process Control Block (PCB)
struct Proc
{
    struct Context context;
    struct Trapframe *tf;

    uint64 *pagetable;

    enum ProcState state;
    int pid;

    void *kstack;
    char name[16];
    uint64 sz;

    struct Proc *parent;
    void *chan;
    int xstate;

    // Implement later
};

// CPU status structure
struct cpu
{
    struct Proc *proc;      // Processes currently running on this CPU
    struct Context context; // Save the scheduler context here
    int noff;               // Depth of push_off()
    int intena;             // Interrupt enable status before closing
};

namespace ProcManager
{
    void init();
    void scheduler();
    void yield();

    void create_kernel_thread(void (*func)(), const char *name);

    void user_init();
    void exit(int status);
    int wait(uint64 addr);

    void sleep(void *chan, Spinlock *lk);
    void wakeup(void *chan);
}

void forkret();
struct Proc *myproc();
void usertrapret();
int fork();