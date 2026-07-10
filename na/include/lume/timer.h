/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

/*
 * MI Timer Subsystem
 */

#include <lume/list.h>

struct TimerList {
    list_node entry;
    uint64 expires;
    void (*function)(TimerList*);
    void* data;
    
    void init(void (*cb)(TimerList*)) {
        entry.init();
        function = cb;
        data = nullptr;
        expires = 0;
    }
};

extern uint64 g_jiffies;

void timer_init();

// AP per-CPU initialization
void timer_init_ap();

// Handle timer interrupt tick (called from TrapHandler)
void timer_tick();

// Get configured timebase frequency
uint64 timer_get_freq();

void add_timer(TimerList* timer);
int del_timer(TimerList* timer);
int mod_timer(TimerList* timer, uint64 expires);
