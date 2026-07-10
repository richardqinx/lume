// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */
#include "common/types.h"
#include "kernel/config.h"
#include "kernel/spinlock.h"
#include "kernel/proc.h"
#include "kernel/sbi.h"

#define INTERVAL 1000000

namespace Timer
{
    uint64 ticks;
    Spinlock tickslock;

    uint64 get_time()
    {
        uint64 time;
        asm volatile("rdtime %0" : "=r"(time));
        return time;
    }

    void set_next_trigger()
    {
        SBI::set_timer(get_time() + INTERVAL);
    }

    void init()
    {
        set_next_trigger();

        uint64 sie;
        asm volatile("csrr %0, sie" : "=r"(sie));
        sie |= (1L << 5);
        asm volatile("csrw sie, %0" : : "r"(sie));
    }

    void tick()
    {
        tickslock.acquire();
        ticks++;
        ProcManager::wakeup(&ticks);
        tickslock.release();
        set_next_trigger();
    }

    uint64 get_ticks()
    {
        tickslock.acquire();
        uint64 t = ticks;
        tickslock.release();
        return t;
    }

    Spinlock *get_lock()
    {
        return &tickslock;
    }

    void *get_tick_chan()
    {
        return &ticks;
    }
}