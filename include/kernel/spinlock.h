#pragma once
#include "common/types.h"

struct spinlock
{
    uint locked;

    char *name;
    int cpu_id;
};

namespace Spinlock
{
    void init(struct spinlock *lk, char *name);
    void acquire(struct spinlock *lk);
    void release(struct spinlock *lk);
    int holding(struct spinlock *lk);
    void push_off();
    void pop_off();
}