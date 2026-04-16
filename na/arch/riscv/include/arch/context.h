/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Context Switch Structure (RISC-V 64)
 *
 * Holds only callee-saved registers for voluntary (non-preemptive)
 * context switches between kernel threads / tasks.
 *
 * Used by: arch::context_switch() in swtch.S
 * Reference: docs/specs/arch_abstraction.md §3.1
 */

#include <lume/types.h>

namespace arch {

struct Context {
    uint64 ra;      // 0:  Return address
    uint64 sp;      // 8:  Stack pointer
    uint64 s[12];   // 16: s0-s11 (callee-saved registers)
};

static_assert(sizeof(Context) == 112);

// Assembly-implemented context switch.
// Saves current CPU registers to old_ctx, loads next_ctx into CPU.
// Defined in arch/riscv/trap/swtch.S
extern "C" void context_switch(Context* old_ctx, Context* next_ctx);

}  // namespace arch
