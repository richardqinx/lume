#pragma once
#include "kernel/spinlock.h"
#include "kernel/proc_def.h"

struct RunQueue
{
    Spinlock lock;
    struct Proc *heads[N_PRIO];
    struct Proc *tails[N_PRIO];
    uint64 count;

    void init(const char *name);
    void enqueue(struct Proc *p);
    struct Proc *dequeue();
    struct Proc *steal();
};