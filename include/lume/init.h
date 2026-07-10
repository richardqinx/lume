/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _LUME_INIT_H
#define _LUME_INIT_H

/*
 * Boot-time section markers.
 *
 * Mirrors the subset of Linux include/linux/init.h that LumeOS uses:
 *
 *   __init      mark a function as boot-only — emitted into .init.text,
 *               which the kernel can later free once setup_arch /
 *               start_kernel have finished (LumeOS doesn't yet reclaim
 *               this memory, but the segment lives so future versions
 *               can without source changes).
 *   __initdata  same for data, emitted into .init.data.
 *   asmlinkage  ABI marker for C functions called from assembly.  On
 *               RISC-V the default C ABI matches the assembly calling
 *               convention, so this is empty (matches Linux RISC-V).
 *
 * No attempt is made to mirror Linux's COMMAND_LINE_SIZE / saved_command_line
 * machinery — that belongs in a future <lume/setup.h>.
 */

#define __init      __attribute__((section(".init.text")))
#define __initdata  __attribute__((section(".init.data")))

#ifndef asmlinkage
#define asmlinkage  /* RISC-V: empty, ABI already matches */
#endif

#endif /* _LUME_INIT_H */
