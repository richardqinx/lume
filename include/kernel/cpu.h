#pragma once
#include "common/types.h"
#include "kernel/proc_def.h"

struct RunQueue;

struct cpu
{
    struct Proc *proc;
    struct Context context;
    int noff;
    int intena;

    struct RunQueue *runqueue;
};


extern struct cpu cpus[];
struct cpu *mycpu();