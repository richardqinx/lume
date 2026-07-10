/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * System Call Interface — Machine-Independent Layer
 *
 * Defines the unified syscall handler signature and the MI dispatch function.
 * MD layer (arch/riscv/syscall/syscall_md.cc) extracts registers into args[6]
 * and calls syscall_dispatch().
 *
 * Reference: docs/specs/syscall.md §4
 */

#include <lume/types.h>

/* Unified syscall handler signature.
 * All arguments and return value are register-width (uint64).
 * Individual sys_* functions cast internally. */
using SyscallHandler = int64 (*)(uint64, uint64, uint64,
                                  uint64, uint64, uint64);

/* MI-layer syscall dispatcher.
 * Called by MD layer after extracting syscall number and arguments.
 * Returns the syscall result (negative errno on error). */
int64 syscall_dispatch(uint64 nr, uint64 args[6]);

/* Register all implemented syscall handlers into the jump table.
 * Called from kernel_main() after sched_init(). */
void syscall_init();

/* MD-layer entry point — called from trap handler on TrapCause::Syscall.
 * Extracts registers from TrapFrame, calls syscall_dispatch, writes result. */
namespace arch {
struct TrapFrame;
}
void syscall_dispatch_md(arch::TrapFrame* tf);
