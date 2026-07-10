/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/timer.h>
#include <lume/fdt.h>
#include <lume/sched.h>
#include <arch/cpu.h>
#include <arch/sbi.h>

#include <kernel/sync/spinlock.h>

uint64 g_jiffies = 0;
static uint64 g_timer_freq = 10000000;
static uint64 g_tick_interval = 0;

static list_node g_timer_list;
static Spinlock g_timer_lock;


void add_timer(TimerList* timer) {
    LockGuard guard(g_timer_lock);
    
    list_node* pos;
    list_for_each(pos, &g_timer_list) {
        TimerList* t = list_entry<TimerList, &TimerList::entry>(pos);
        if (t->expires > timer->expires) {
            break;
        }
    }
    
    timer->entry.prev = pos->prev;
    timer->entry.next = pos;
    pos->prev->next = &timer->entry;
    pos->prev = &timer->entry;
}

int del_timer(TimerList* timer) {
    LockGuard guard(g_timer_lock);
    if (timer->entry.next != nullptr && timer->entry.next != &timer->entry) {
        timer->entry.prev->next = timer->entry.next;
        timer->entry.next->prev = timer->entry.prev;
        timer->entry.init();
        return 1;
    }
    return 0;
}

int mod_timer(TimerList* timer, uint64 expires) {
    int ret = del_timer(timer);
    timer->expires = expires;
    add_timer(timer);
    return ret;
}

static void run_timers() {
    g_timer_lock.acquire();
    
    while (!g_timer_list.is_empty()) {
        TimerList* t = list_entry<TimerList, &TimerList::entry>(g_timer_list.next);
        if (t->expires > g_jiffies) {
            break;
        }
        
        t->entry.prev->next = t->entry.next;
        t->entry.next->prev = t->entry.prev;
        t->entry.init();
        
        g_timer_lock.release();
        t->function(t);
        g_timer_lock.acquire();
    }
    
    g_timer_lock.release();
}

static void timer_set_next() {
    arch::sbi::set_timer(arch::cpu::read_time() + g_tick_interval);
}

void timer_init() {
    DeviceNode* cpus = fdt_get_node_by_path("/cpus");
    if (cpus) {
        g_timer_freq = cpus->get_prop_u32("timebase-frequency", g_timer_freq);
    }
    
    // Default 100 Hz (10ms per tick)
    g_tick_interval = g_timer_freq / 100;
    
    g_timer_lock.init("timer_list");
    g_timer_list.init();
    
    timer_set_next();

    arch::cpu::timer_intr_on();
}


void timer_init_ap() {
    timer_set_next();
    arch::cpu::timer_intr_on();
}

extern "C" uint32 bsp_hart_id;

void timer_tick() {
    if (arch::cpu::id() == bsp_hart_id) {
        g_jiffies++;
        run_timers();
    }

    timer_set_next();
    sched_tick();
}


uint64 timer_get_freq() {
    return g_timer_freq;
}
