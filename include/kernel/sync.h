#pragma once
#include "common/types.h"
#include "kernel/spinlock.h"
#include "kernel/proc_def.h"


struct WaitQueue
{
    Spinlock lock;
    struct Proc *head;
    struct Proc *tail;

    void init(const char *name);
    void sleep();
    void wakeup();
    void wakeup_all();
};

struct Semaphore
{
    int value;
    WaitQueue wq;
    Spinlock lock;

    void init(int val, const char *name);
    void wait();
    void post();
};

struct CondVar
{
    WaitQueue wq;

    void init(const char *name);
    void wait(Spinlock *mutex_lock);
    void signal();
    void broadcast();
};