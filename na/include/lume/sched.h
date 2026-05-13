/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Scheduler Public Interface
 *
 * Linux-style sched_class core with per-CPU runqueues.
 * Phase 2: O(1) bitmap class is the default scheduling class.
 *
 * Reference: docs/specs/scheduler.md
 */

#include <lume/types.h>
#include <lume/config.h>

struct TaskControlBlock;

/* ========================================================================
 * Scheduler Constants — driven by CONFIG_xxx (see scripts/Kconfig.mk)
 * ======================================================================== */

inline constexpr int kNumPriorities    = CONFIG_NR_PRIORITIES;
inline constexpr int kDefaultPriority  = CONFIG_DEFAULT_PRIORITY;
inline constexpr int kDefaultTimeSlice = CONFIG_DEFAULT_TIMESLICE;
inline constexpr int kIdlePriority     = CONFIG_IDLE_PRIORITY;

/* ========================================================================
 * Initialization
 * ======================================================================== */

/* BSP: initialize all RunQueues, create BSP idle thread and boot TCB. */
void sched_init();

/* AP: create per-CPU idle thread and boot TCB. */
void sched_init_ap();

/* ========================================================================
 * Core Scheduling
 * ======================================================================== */

/* Main scheduling entry point. Picks the next task and context-switches.
 * Called voluntarily (yield, sleep, exit) or from trap return path. */
void schedule();

/* Timer tick handler. Delegates to current task's sched_class.
 * Called from MI trap layer in interrupt context. */
void sched_tick();

/* Check if rescheduling is needed (called before returning to user mode). */
void sched_check_preempt();

/* Voluntarily yield the current time slice. */
void sched_yield();

/* ========================================================================
 * Task Queue Management (used by task.cc, waitqueue.cc)
 * ======================================================================== */

/* Make a task runnable: add it to its CPU's RunQueue. */
void sched_enqueue(TaskControlBlock* task);

/* Mark a task as sleeping: remove it from the RunQueue. */
void sched_dequeue(TaskControlBlock* task);

/* ========================================================================
 * Time Slice Policy
 * ======================================================================== */

/* Convert priority level to time slice length.
 * Higher priority (lower number) → longer time slice. */
int32 priority_to_timeslice(uint8 priority);
