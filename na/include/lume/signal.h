/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Signal Infrastructure — Core signal delivery API
 *
 * Provides the interface between trap handling, signal delivery,
 * and user-space signal handler execution.
 *
 * Reference: Linux include/linux/sched/signal.h
 */

#include <lume/types.h>

struct TaskControlBlock;
struct sighand_struct;
namespace arch { struct TrapFrame; }

/* ------------------------------------------------------------------
 * sighand_struct lifecycle (Linux kernel/fork.c:copy_sighand pattern)
 * ------------------------------------------------------------------ */

sighand_struct* alloc_sighand();
sighand_struct* copy_sighand(sighand_struct* parent);
void            get_sighand(sighand_struct* sh);
void            put_sighand(sighand_struct* sh);

/*
 * force_sig_fault — Deliver a fault-induced signal to the current task.
 *
 * Called from trap handler when a user-mode exception cannot be resolved.
 * Bypasses the blocked mask and enqueues the signal.
 *
 * @signo:  Signal number (SIGSEGV, SIGBUS, SIGILL, SIGFPE, etc.)
 * @code:   si_code for siginfo_t (e.g., SEGV_MAPERR, SEGV_ACCERR)
 * @addr:   Fault address (stval / badaddr)
 */
void force_sig_fault(int signo, int code, uint64 addr);

/*
 * do_signal — Process pending signals before returning to user mode.
 *
 * Called at the end of trap_handle() when origin == FromUser.
 * If a signal is pending and a handler is registered, constructs
 * a signal frame on the user stack and redirects epc.
 *
 * @tf:  TrapFrame to modify if signal delivery is needed.
 */
void do_signal(arch::TrapFrame* tf);

/*
 * signal_pending — Check if the task has unblocked pending signals.
 *
 * Used by blocking syscalls (e.g., n_tty_read) to detect whether
 * they should return -EINTR.
 */
bool signal_pending(TaskControlBlock* task);

