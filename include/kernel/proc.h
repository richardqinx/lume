#pragma once
#include "common/types.h"
#include "kernel/trap.h"

struct Context
{
    uint64 ra;
    uint64 sp;

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

enum ProcState{
    UNUSED,
    USED,
    SLEEPING,
    RUNNABLE,
    RUNNING,
    ZOMBIE,
};

struct Proc
{
    struct Context context;
    struct Trapframe *tf;

    uint64 *pagetable;

    enum ProcState state;
    int pid;

    void* kstack;
    char name[16];
    uint64 sz;

    //
};


namespace ProcManager
{
    void init();
    void scheduler();
    void yield();

    void create_kernel_thread(void (*func)(), const char *name);

    void user_init();
}

void forkret();
struct Proc *myproc();
void usertrapret();