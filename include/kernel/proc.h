#pragma once
#include "common/types.h"
#include "kernel/proc_def.h"
#include "kernel/spinlock.h"

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

    int growproc(int n);
}

void forkret();
struct Proc *myproc();
void usertrapret();
int fork();