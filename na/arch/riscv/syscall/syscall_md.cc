/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Syscall MD Layer — RISC-V Register Extraction
 *
 * Extracts syscall number (a7) and arguments (a0-a5) from the TrapFrame,
 * calls the MI dispatcher, and writes the return value back to a0.
 *
 * Reference: docs/specs/syscall.md §5
 */

#include <lume/syscall.h>
#include <arch/trapframe.h>

void syscall_dispatch_md(arch::TrapFrame* tf)
{
    uint64 nr = tf->a[7];   /* RISC-V ABI: syscall number in a7 */

    uint64 args[6] = {
        tf->a[0], tf->a[1], tf->a[2],
        tf->a[3], tf->a[4], tf->a[5],
    };

    int64 ret = syscall_dispatch(nr, args);

    tf->a[0] = static_cast<uint64>(ret);  /* Return value in a0 */
}
