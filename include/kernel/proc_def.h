#pragma once
#include "common/types.h"
#include "common/fcntl.h"

struct cpu;
struct Trapframe;
class Inode;
struct file;

enum ProcState
{
    UNUSED,
    USED,
    SLEEPING,
    RUNNABLE,
    RUNNING,
    ZOMBIE,
};

#define PRIO_MAX 0
#define PRIO_MIN 3
#define N_PRIO 4

// Context structure
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

    Inode *cwd;
    struct file *ofile[NOFILE];

    struct Proc *next;
    struct Proc *prev;

    struct Proc *all_next;
    struct Proc *all_prev;

    int priority;
    int ticks;
    struct cpu *cpu;
};