/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/timer.h>
#include <lume/fdt.h>
#include <lume/sched.h>
#include <arch/cpu.h>
#include <arch/sbi.h>

uint64 g_jiffies = 0;
static uint64 g_timer_freq = 10000000;
static uint64 g_tick_interval = 0;

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
    
    timer_set_next();
    arch::cpu::timer_intr_on();
}

void timer_init_ap() {
    timer_set_next();
    arch::cpu::timer_intr_on();
}

void timer_tick() {
    g_jiffies++;
    timer_set_next();
    sched_tick();
}

uint64 timer_get_freq() {
    return g_timer_freq;
}
