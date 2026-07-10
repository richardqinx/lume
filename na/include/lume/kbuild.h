/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _LUME_KBUILD_H
#define _LUME_KBUILD_H

/*
 * Helpers for arch/<arch>/kernel/asm-offsets.c — 1:1 with Linux
 * include/linux/kbuild.h.
 *
 * Trick: each DEFINE/OFFSET emits an inline-asm ".ascii" directive
 * containing a literal "->" prefix.  When the file is compiled with
 *
 *     $(CC) -S asm-offsets.c -o asm-offsets.s
 *
 * the resulting assembly contains lines like
 *
 *     ->KERNEL_MAP_VIRT_ADDR $0 offsetof(struct kernel_mapping, virt_addr)
 *
 * scripts/extract-asm-offsets.sed then rewrites those into proper
 * `#define KERNEL_MAP_VIRT_ADDR 0` lines for inclusion from head.S.
 *
 * The benefit over hand-written #defines is that struct layout changes
 * are caught at build time: rearrange a field and the asm offset
 * changes automatically.
 */

#define DEFINE(sym, val) \
    asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))

#define BLANK() \
    asm volatile("\n.ascii \"->\"" : : )

#define OFFSET(sym, str, mem) \
    DEFINE(sym, offsetof(struct str, mem))

#define COMMENT(x) \
    asm volatile("\n.ascii \"->#" x "\"")

#endif /* _LUME_KBUILD_H */
