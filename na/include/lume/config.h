/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * LumeOS Global Compile-Time Configuration
 *
 * All kernel-wide tuning constants live here.
 * Architecture-specific constants live in <arch/config.h>.
 *
 * This header is safe to include from both C++ and assembly files.
 * Assembly-visible constants use #define; C++ code gets typed constexpr.
 *
 * Reference: docs/specs/00_conventions.md §1.3
 */

/* These macros are shared with assembly (entry.S) */
#define LUME_MAX_CPUS   8
#define LUME_PAGE_SIZE  4096

#ifndef __ASSEMBLER__

#include <lume/types.h>

/* Maximum number of CPUs supported by the kernel.
 * Compile-time limit for static arrays (boot stacks, per-cpu data).
 * Actual CPU count is detected at runtime via FDT. */
inline constexpr int kMaxCpus = LUME_MAX_CPUS;

/* Virtual memory page size (4KB, matching SV39 base page). */
inline constexpr uint64 kPageSize = LUME_PAGE_SIZE;

#endif /* __ASSEMBLER__ */