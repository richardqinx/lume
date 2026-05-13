/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

/*
 * MI Timer Subsystem
 */

extern uint64 g_jiffies;

// BSP global initialization
void timer_init();

// AP per-CPU initialization
void timer_init_ap();

// Handle timer interrupt tick (called from TrapHandler)
void timer_tick();

// Get configured timebase frequency
uint64 timer_get_freq();
