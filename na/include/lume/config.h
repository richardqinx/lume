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
 * Values are injected by the build system via -DCONFIG_xxx flags
 * (see scripts/Kconfig.mk).  The #ifndef guards below provide
 * safe defaults so the header is self-contained for IDE analysis.
 *
 * Reference: docs/specs/00_conventions.md §1.3
 */

/* ================================================================
 * Defaults — only used when CONFIG_xxx is NOT supplied by -D flag.
 * In a normal build, scripts/Kconfig.mk always provides them.
 * ================================================================ */

#ifndef CONFIG_NR_CPUS
#define CONFIG_NR_CPUS          8
#endif

#ifndef CONFIG_PAGE_SIZE
#define CONFIG_PAGE_SIZE        4096
#endif

#ifndef CONFIG_MAX_ORDER
#define CONFIG_MAX_ORDER        11
#endif

#ifndef CONFIG_KERNEL_STACK_SIZE
#define CONFIG_KERNEL_STACK_SIZE 8192
#endif

#ifndef CONFIG_HZ
#define CONFIG_HZ               100
#endif

#ifndef CONFIG_NR_PRIORITIES
#define CONFIG_NR_PRIORITIES    32
#endif

#ifndef CONFIG_DEFAULT_PRIORITY
#define CONFIG_DEFAULT_PRIORITY (CONFIG_NR_PRIORITIES / 2)
#endif

#ifndef CONFIG_IDLE_PRIORITY
#define CONFIG_IDLE_PRIORITY    (CONFIG_NR_PRIORITIES - 1)
#endif

#ifndef CONFIG_DEFAULT_TIMESLICE
#define CONFIG_DEFAULT_TIMESLICE (CONFIG_HZ / 10)
#endif

#ifndef CONFIG_KASLR_POLICY_ID
#define CONFIG_KASLR_POLICY_ID  0   /* Default: basic KASLR policy */
#endif

#ifndef CONFIG_KASLR_LOG_LEVEL
#define CONFIG_KASLR_LOG_LEVEL  1   /* 0=off, 1=minimal, 2=debug */
#endif

/* ================================================================
 * Legacy compatibility aliases (shared with assembly)
 * ================================================================ */
#define LUME_MAX_CPUS   CONFIG_NR_CPUS
#define LUME_PAGE_SIZE  CONFIG_PAGE_SIZE

#ifndef __ASSEMBLER__

#include <lume/types.h>

/* Maximum number of CPUs supported by the kernel.
 * Compile-time limit for static arrays (boot stacks, per-cpu data).
 * Actual CPU count is detected at runtime via FDT. */
inline constexpr int kMaxCpus = CONFIG_NR_CPUS;

/* Virtual memory page size (4KB, matching SV39 base page). */
inline constexpr uint64 kPageSize = CONFIG_PAGE_SIZE;

/* KASLR policy ID and logging level (build-time configurable) */
inline constexpr uint32 kKaslrPolicyId = CONFIG_KASLR_POLICY_ID;
inline constexpr int kKaslrLogLevel = CONFIG_KASLR_LOG_LEVEL;

#endif /* __ASSEMBLER__ */