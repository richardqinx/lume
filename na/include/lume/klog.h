/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Kernel Logging Subsystem
 *
 * All kernel output goes through klog(), which formats messages into
 * a fixed-size ring buffer and optionally emits them to the console.
 *
 * Architecture:
 *   vsnprintf_()          ← pure formatting (mpaland/printf)
 *       ↓
 *   KlogBuffer (ring)     ← all messages stored here
 *       ↓
 *   early_putc() (sync)   ← current: synchronous UART output
 *   klogd thread (async)  ← future: background flush thread
 *   /proc/kmsg            ← future: userspace dmesg interface
 *
 * Reference: docs/specs/klog.md
 */

#include <lume/types.h>

/* ========================================================================
 * Log Levels (matches Linux kern_levels.h ordering)
 * ======================================================================== */

enum KlogLevel : uint8 {
    KLOG_EMERG   = 0,   /* System is unusable */
    KLOG_ALERT   = 1,   /* Action must be taken immediately */
    KLOG_CRIT    = 2,   /* Critical conditions */
    KLOG_ERR     = 3,   /* Error conditions */
    KLOG_WARN    = 4,   /* Warning conditions */
    KLOG_NOTICE  = 5,   /* Normal but significant condition */
    KLOG_INFO    = 6,   /* Informational */
    KLOG_DEBUG   = 7,   /* Debug-level messages */
};

/* Log subsystems (bitmask-friendly) */
enum KlogSubsys : uint8 {
    KLOG_SUBSYS_GENERIC = 0,
    KLOG_SUBSYS_SCHED   = 1,
    KLOG_SUBSYS_TRAP    = 2,
    KLOG_SUBSYS_IRQ     = 3,
    KLOG_SUBSYS_TIMER   = 4,
    KLOG_SUBSYS_VMM     = 5,
    KLOG_SUBSYS_PMM     = 6,
    KLOG_SUBSYS_SLAB    = 7,
    KLOG_SUBSYS_FS      = 8,
    KLOG_SUBSYS_DRIVER  = 9,
    KLOG_SUBSYS_TEST    = 10,
    KLOG_SUBSYS_MAX     = 11,
};

/* Default: show everything up to INFO. DEBUG is compile-gated. */
#ifndef KLOG_DEFAULT_LEVEL
#define KLOG_DEFAULT_LEVEL  KLOG_INFO
#endif

/* Ring buffer size: 2^KLOG_BUF_SHIFT bytes (default 64KB) */
#ifndef KLOG_BUF_SHIFT
#define KLOG_BUF_SHIFT 16
#endif

#define KLOG_BUF_SIZE (1U << KLOG_BUF_SHIFT)

/* Maximum length of a single log message (stack-allocated) */
#define KLOG_LINE_MAX 256

struct KlogStats {
    uint32 head;
    uint32 tail;
    uint32 console_tail;
    uint32 dropped;
    uint32 seq;
};

struct KlogRateLimit {
    uint64 last_ts;
    uint32 interval;
    uint32 burst;
    uint32 printed;
    uint32 suppressed;
};

#ifdef __cplusplus
extern "C" {
#endif

/* ========================================================================
 * Initialization
 * ======================================================================== */

/* Initialize the ring buffer and console backend. Call once from BSP. */
void klog_init(void);

/* ========================================================================
 * Core API
 * ======================================================================== */

/* Write a leveled log message. Formats into ring buffer, then
 * synchronously flushes to console if level <= current threshold. */
__attribute__((format(printf, 2, 3)))
void klog(KlogLevel level, const char* fmt, ...);

__attribute__((format(printf, 3, 4)))
void klog_ex(KlogLevel level, KlogSubsys subsys, const char* fmt, ...);

/* Linux-style printk interface */
__attribute__((format(printf, 1, 2)))
int printk(const char* fmt, ...);
int vprintk(const char* fmt, __builtin_va_list va);

/* Set runtime log level filter. Messages above this level are
 * still stored in the ring buffer but not printed to console. */
void klog_set_level(KlogLevel level);

void klog_set_subsys_mask(uint64 mask);
void klog_enable_subsys(KlogSubsys subsys);
void klog_disable_subsys(KlogSubsys subsys);

/* ========================================================================
 * Ring Buffer Read (for future dmesg / /proc/kmsg)
 * ======================================================================== */

/* Read up to 'size' bytes from the ring buffer into 'buf'.
 * Returns number of bytes read. Non-destructive peek. */
int klog_read(char* buf, int size);

/* Read and consume entries (advances tail). */
int klog_read_consume(char* buf, int size);

/* Flush pending entries to console (advances console tail). */
void klog_flush(void);

bool klog_ratelimit(KlogRateLimit* rl, uint64 now);

void klog_stats(KlogStats* out);

/* ========================================================================
 * Convenience Macros
 * ======================================================================== */

#define pr_emerg(fmt, ...)  klog_ex(KLOG_EMERG,  KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)
#define pr_alert(fmt, ...)  klog_ex(KLOG_ALERT,  KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)
#define pr_crit(fmt, ...)   klog_ex(KLOG_CRIT,   KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)
#define pr_err(fmt, ...)    klog_ex(KLOG_ERR,    KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)
#define pr_warn(fmt, ...)   klog_ex(KLOG_WARN,   KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)
#define pr_notice(fmt, ...) klog_ex(KLOG_NOTICE, KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)
#define pr_info(fmt, ...)   klog_ex(KLOG_INFO,   KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)

#define pr_emerg_s(subsys, fmt, ...)  klog_ex(KLOG_EMERG,  subsys, fmt, ##__VA_ARGS__)
#define pr_alert_s(subsys, fmt, ...)  klog_ex(KLOG_ALERT,  subsys, fmt, ##__VA_ARGS__)
#define pr_crit_s(subsys, fmt, ...)   klog_ex(KLOG_CRIT,   subsys, fmt, ##__VA_ARGS__)
#define pr_err_s(subsys, fmt, ...)    klog_ex(KLOG_ERR,    subsys, fmt, ##__VA_ARGS__)
#define pr_warn_s(subsys, fmt, ...)   klog_ex(KLOG_WARN,   subsys, fmt, ##__VA_ARGS__)
#define pr_notice_s(subsys, fmt, ...) klog_ex(KLOG_NOTICE, subsys, fmt, ##__VA_ARGS__)
#define pr_info_s(subsys, fmt, ...)   klog_ex(KLOG_INFO,   subsys, fmt, ##__VA_ARGS__)

#ifdef KLOG_ENABLE_DEBUG
#define pr_debug(fmt, ...)  klog_ex(KLOG_DEBUG,  KLOG_SUBSYS_GENERIC, fmt, ##__VA_ARGS__)
#else
#define pr_debug(fmt, ...)  do {} while (0)
#endif

/* Linux kernel loglevel prefixes */
#define KERN_SOH    "\001"
#define KERN_EMERG  KERN_SOH "0"
#define KERN_ALERT  KERN_SOH "1"
#define KERN_CRIT   KERN_SOH "2"
#define KERN_ERR    KERN_SOH "3"
#define KERN_WARNING KERN_SOH "4"
#define KERN_NOTICE KERN_SOH "5"
#define KERN_INFO   KERN_SOH "6"
#define KERN_DEBUG  KERN_SOH "7"

/* Boot stage log (thin wrapper over printk) */
#define BOOT_STAGE(n, desc) \
    printk(KERN_INFO "STAGE%u %s\n", (unsigned)(n), (desc))

extern "C" [[noreturn]] void kernel_panic(const char* msg, const char* detail = nullptr);

#ifdef __cplusplus
}
#endif
