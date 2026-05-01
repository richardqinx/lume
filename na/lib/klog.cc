/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * klog.cc — Kernel logging subsystem implementation
 *
 * Implements the ring buffer, spinlock-protected writes, log level
 * filtering, and synchronous console output.
 *
 * Phase 2 TODO: async flush via kernel thread (see docs/specs/klog.md)
 */

#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/console.h>
#include <lume/atomic.h>
#include <kernel/sync/spinlock.h>
#include <arch/cpu.h>

/* Forward declaration — mpaland/printf */
extern "C" int vsnprintf_(char* buffer, size_t count,
                           const char* format, __builtin_va_list va);

/* ========================================================================
 * Ring Buffer State
 * ======================================================================== */

struct KlogEntryHdr {
    uint32 seq;
    uint32 len;
    uint64 ts;
    uint16 cpu;
    uint8 level;
    uint8 subsys;
    uint16 reserved;
};

static struct {
    char     data[KLOG_BUF_SIZE];
    uint32   head;           /* Next write position */
    uint32   tail;           /* Next read position (for /proc/kmsg) */
    uint32   console_tail;   /* Next position to flush to console */
    uint32   dropped;
    lume::atomic<uint32> seq;
    uint64   subsys_mask;
    Spinlock lock;
    KlogLevel console_level; /* Messages <= this level go to UART */
    bool     initialized;
    bool     panic_mode;
} g_klog;

/* ========================================================================
 * Level name table
 * ======================================================================== */

static const char* klog_level_name(KlogLevel level)
{
    static const char* names[] = {
        "EMERG", "ALERT", "CRIT", "ERR",
        "WARN",  "NOTICE", "INFO", "DEBUG"
    };
    if (level <= KLOG_DEBUG) {
        return names[level];
    }
    return "?";
}

static const char* klog_subsys_name(KlogSubsys subsys)
{
    static const char* names[] = {
        "GEN",
        "SCHED",
        "TRAP",
        "IRQ",
        "TIMER",
        "VMM",
        "PMM",
        "SLAB",
        "FS",
        "DRV",
        "TEST",
    };
    if (subsys < KLOG_SUBSYS_MAX) {
        return names[subsys];
    }
    return "?";
}

/* ========================================================================
 * Ring Buffer Operations
 * ======================================================================== */

/* Write a byte to the ring buffer. Overwrites oldest data on overflow. */
static inline uint32 min_u32(uint32 a, uint32 b)
{
    return (a < b) ? a : b;
}

static void ring_write_bytes(const void* src, uint32 len)
{
    const char* p = reinterpret_cast<const char*>(src);
    for (uint32 i = 0; i < len; ++i) {
        g_klog.data[(g_klog.head + i) & (KLOG_BUF_SIZE - 1)] = p[i];
    }
    g_klog.head += len;
}

static void ring_read_bytes(uint32 pos, void* dst, uint32 len)
{
    char* out = reinterpret_cast<char*>(dst);
    for (uint32 i = 0; i < len; ++i) {
        out[i] = g_klog.data[(pos + i) & (KLOG_BUF_SIZE - 1)];
    }
}

static void ring_drop_oldest(uint32 needed)
{
    uint32 min_tail = min_u32(g_klog.tail, g_klog.console_tail);

    while (KLOG_BUF_SIZE - (g_klog.head - min_tail) < needed) {
        KlogEntryHdr hdr;
        ring_read_bytes(min_tail, &hdr, sizeof(hdr));

        uint32 entry = sizeof(hdr) + hdr.len;
        if (entry == 0 || entry > KLOG_BUF_SIZE) {
            min_tail++;
            g_klog.dropped++;
            continue;
        }
        min_tail += entry;
        g_klog.dropped++;
    }

    if (g_klog.tail < min_tail) {
        g_klog.tail = min_tail;
    }
    if (g_klog.console_tail < min_tail) {
        g_klog.console_tail = min_tail;
    }
}

/* ========================================================================
 * Console Output (synchronous)
 * ======================================================================== */

static void console_emit(const char* s, int len)
{
    for (int i = 0; i < len; ++i) {
        early_putc(s[i]);
    }
}

static int klog_format_line(char* out, int out_size,
                            const KlogEntryHdr& hdr,
                            const char* msg, int msg_len)
{
    const char* lvl = klog_level_name(static_cast<KlogLevel>(hdr.level));
    const char* subsys = klog_subsys_name(static_cast<KlogSubsys>(hdr.subsys));

    int prefix = ksnprintf(out, out_size,
                           "[%s][cpu%u][%llu][%s] ",
                           lvl, (uint32)hdr.cpu,
                           (unsigned long long)hdr.ts, subsys);
    if (prefix < 0) {
        return 0;
    }

    int total = prefix;
    int avail = out_size - 1 - total;
    if (avail > 0) {
        int to_copy = (msg_len < avail) ? msg_len : avail;
        for (int i = 0; i < to_copy; ++i) {
            out[total + i] = msg[i];
        }
        total += to_copy;
    }

    if (total > 0 && out[total - 1] != '\n' && total < out_size - 1) {
        out[total++] = '\n';
    }

    out[total] = '\0';
    return total;
}

static int klog_read_internal(char* buf, int size, uint32* tail_ptr, bool consume)
{
    if (size <= 0) {
        return 0;
    }

    int written = 0;
    uint32 pos = *tail_ptr;

    while (pos != g_klog.head) {
        KlogEntryHdr hdr;
        ring_read_bytes(pos, &hdr, sizeof(hdr));
        uint32 raw_len = hdr.len;
        if (raw_len > KLOG_BUF_SIZE) {
            break;
        }
        uint32 copy_len = raw_len;
        if (copy_len > KLOG_LINE_MAX) {
            copy_len = KLOG_LINE_MAX;
        }

        char msg[KLOG_LINE_MAX + 1];
        ring_read_bytes(pos + sizeof(hdr), msg, copy_len);
        msg[copy_len] = '\0';

        char line[KLOG_LINE_MAX + 64];
        int line_len = klog_format_line(line, sizeof(line), hdr, msg,
                         static_cast<int>(copy_len));

        if (line_len <= 0 || written + line_len > size) {
            break;
        }

        for (int i = 0; i < line_len; ++i) {
            buf[written + i] = line[i];
        }
        written += line_len;

        pos += sizeof(hdr) + raw_len;
    }

    if (consume) {
        *tail_ptr = pos;
    }

    return written;
}

static void klog_vex(KlogLevel level, KlogSubsys subsys,
                     const char* fmt, __builtin_va_list va);

/* ========================================================================
 * Public API
 * ======================================================================== */

void klog_init(void)
{
    g_klog.head = 0;
    g_klog.tail = 0;
    g_klog.console_tail = 0;
    g_klog.dropped = 0;
    g_klog.seq.store(0, __ATOMIC_RELAXED);
    g_klog.subsys_mask = (1ULL << KLOG_SUBSYS_MAX) - 1;
    g_klog.console_level = static_cast<KlogLevel>(KLOG_DEFAULT_LEVEL);
    g_klog.initialized = true;
    g_klog.panic_mode = false;
    g_klog.lock.init("klog");
}

void klog(KlogLevel level, const char* fmt, ...)
{
    __builtin_va_list va;
    __builtin_va_start(va, fmt);
    klog_vex(level, KLOG_SUBSYS_GENERIC, fmt, va);
    __builtin_va_end(va);
}

void klog_ex(KlogLevel level, KlogSubsys subsys, const char* fmt, ...)
{
    __builtin_va_list va;
    __builtin_va_start(va, fmt);
    klog_vex(level, subsys, fmt, va);
    __builtin_va_end(va);
}

static void klog_vex(KlogLevel level, KlogSubsys subsys,
                     const char* fmt, __builtin_va_list va)
{
    if (subsys >= KLOG_SUBSYS_MAX) {
        subsys = KLOG_SUBSYS_GENERIC;
    }

    if (g_klog.initialized && ((g_klog.subsys_mask & (1ULL << subsys)) == 0)) {
        return;
    }

    char msg[KLOG_LINE_MAX + 1];
    int msg_len = vsnprintf_(msg, KLOG_LINE_MAX, fmt, va);

    if (msg_len < 0) {
        return;
    }
    if (msg_len > KLOG_LINE_MAX) {
        msg_len = KLOG_LINE_MAX;
    }
    msg[msg_len] = '\0';

    KlogEntryHdr hdr;
    hdr.seq = g_klog.seq.fetch_add(1, __ATOMIC_RELAXED);
    hdr.len = static_cast<uint32>(msg_len);
    hdr.ts = arch::cpu::read_time();
    hdr.cpu = static_cast<uint16>(arch::cpu::id());
    hdr.level = static_cast<uint8>(level);
    hdr.subsys = static_cast<uint8>(subsys);
    hdr.reserved = 0;

    bool do_console = (!g_klog.initialized || level <= g_klog.console_level);

    if (g_klog.initialized && !g_klog.panic_mode) {
        LockGuard guard(g_klog.lock);
        ring_drop_oldest(sizeof(hdr) + hdr.len);
        ring_write_bytes(&hdr, sizeof(hdr));
        ring_write_bytes(msg, hdr.len);
        if (do_console) {
            g_klog.console_tail = g_klog.head;
        }
    }

    if (do_console) {
        char line[KLOG_LINE_MAX + 64];
        int line_len = klog_format_line(line, sizeof(line), hdr, msg, hdr.len);
        if (line_len > 0) {
            console_emit(line, line_len);
        }
    }
}

void klog_set_level(KlogLevel level)
{
    g_klog.console_level = level;
}

void klog_set_subsys_mask(uint64 mask)
{
    g_klog.subsys_mask = mask;
}

void klog_enable_subsys(KlogSubsys subsys)
{
    if (subsys < KLOG_SUBSYS_MAX) {
        g_klog.subsys_mask |= (1ULL << subsys);
    }
}

void klog_disable_subsys(KlogSubsys subsys)
{
    if (subsys < KLOG_SUBSYS_MAX) {
        g_klog.subsys_mask &= ~(1ULL << subsys);
    }
}

int klog_read(char* buf, int size)
{
    if (!g_klog.initialized || size <= 0) {
        return 0;
    }

    LockGuard guard(g_klog.lock);
    return klog_read_internal(buf, size, &g_klog.tail, false);
}

int klog_read_consume(char* buf, int size)
{
    if (!g_klog.initialized || size <= 0) {
        return 0;
    }

    LockGuard guard(g_klog.lock);
    return klog_read_internal(buf, size, &g_klog.tail, true);
}

void klog_flush(void)
{
    if (!g_klog.initialized) {
        return;
    }

    LockGuard guard(g_klog.lock);

    uint32 pos = g_klog.console_tail;
    while (pos != g_klog.head) {
        KlogEntryHdr hdr;
        ring_read_bytes(pos, &hdr, sizeof(hdr));
        uint32 raw_len = hdr.len;
        if (raw_len > KLOG_BUF_SIZE) {
            break;
        }
        uint32 copy_len = raw_len;
        if (copy_len > KLOG_LINE_MAX) {
            copy_len = KLOG_LINE_MAX;
        }

        char msg[KLOG_LINE_MAX + 1];
        ring_read_bytes(pos + sizeof(hdr), msg, copy_len);
        msg[copy_len] = '\0';

        char line[KLOG_LINE_MAX + 64];
        int line_len = klog_format_line(line, sizeof(line), hdr, msg,
                                         static_cast<int>(copy_len));
        if (line_len > 0) {
            console_emit(line, line_len);
        }

        pos += sizeof(hdr) + raw_len;
    }

    g_klog.console_tail = pos;
}

bool klog_ratelimit(KlogRateLimit* rl, uint64 now)
{
    if (!rl) {
        return true;
    }

    if (rl->interval == 0 || rl->burst == 0) {
        return true;
    }

    if (now - rl->last_ts >= rl->interval) {
        rl->last_ts = now;
        rl->printed = 0;
        rl->suppressed = 0;
    }

    if (rl->printed < rl->burst) {
        rl->printed++;
        return true;
    }

    rl->suppressed++;
    return false;
}

void klog_stats(KlogStats* out)
{
    if (!out) {
        return;
    }

    out->head = g_klog.head;
    out->tail = g_klog.tail;
    out->console_tail = g_klog.console_tail;
    out->dropped = g_klog.dropped;
    out->seq = g_klog.seq.load(__ATOMIC_RELAXED);
}

/* ========================================================================
 * Kernel Panic — Fatal Error Handler
 *
 * Dumps all critical S-mode CSRs and the stack pointer to the console,
 * then halts the CPU.  Uses kprintf (NOT klog) to avoid deadlocking
 * if the panic was triggered while holding the klog spinlock.
 * ======================================================================== */

extern "C" [[noreturn]] void kernel_panic(const char* msg, const char* detail) {
    /* Disable interrupts immediately */
    arch::cpu::intr_off();

    g_klog.panic_mode = true;

    /* ---- Banner ---- */
    kprintf("\n\n");
    kprintf("========================================\n");
    kprintf("  *** KERNEL PANIC ***\n");
    kprintf("========================================\n");

    if (msg != nullptr) {
        kprintf("  Reason : %s", msg);
        if (detail != nullptr) {
            kprintf(": %s", detail);
        }
        kprintf("\n");
    }

    /* ---- Read S-mode CSRs ---- */
    uint64 sepc, scause, stval, sstatus, satp, stvec, sscratch, sp_val;

    __asm__ volatile("csrr %0, sepc"     : "=r"(sepc));
    __asm__ volatile("csrr %0, scause"   : "=r"(scause));
    __asm__ volatile("csrr %0, stval"    : "=r"(stval));
    __asm__ volatile("csrr %0, sstatus"  : "=r"(sstatus));
    __asm__ volatile("csrr %0, satp"     : "=r"(satp));
    __asm__ volatile("csrr %0, stvec"    : "=r"(stvec));
    __asm__ volatile("csrr %0, sscratch" : "=r"(sscratch));
    __asm__ volatile("mv   %0, sp"       : "=r"(sp_val));

    kprintf("\n--- S-mode CSR Dump ---\n");
    kprintf("  sepc      = 0x%016llx\n", sepc);
    kprintf("  scause    = 0x%016llx", scause);

    /* Decode scause for convenience */
    bool is_interrupt = (scause >> 63) != 0;
    uint64 cause_code = scause & 0x7FFFFFFFFFFFFFFFULL;
    if (is_interrupt) {
        kprintf("  (interrupt, code=%llu)\n", cause_code);
    } else {
        kprintf("  (exception, code=%llu)\n", cause_code);
    }

    kprintf("  stval     = 0x%016llx\n", stval);
    kprintf("  sstatus   = 0x%016llx", sstatus);
    kprintf("  [SIE=%llu SPP=%llu SPIE=%llu]\n",
            (sstatus >> 1) & 1,   /* SIE */
            (sstatus >> 8) & 1,   /* SPP */
            (sstatus >> 5) & 1);  /* SPIE */
    kprintf("  satp      = 0x%016llx", satp);
    uint64 satp_mode = satp >> 60;
    kprintf("  [mode=%llu]\n", satp_mode);
    kprintf("  stvec     = 0x%016llx\n", stvec);
    kprintf("  sscratch  = 0x%016llx\n", sscratch);
    kprintf("  sp        = 0x%016llx\n", sp_val);

    kprintf("  cpu_id    = %llu\n", arch::cpu::id());
    kprintf("  time      = %llu\n", arch::cpu::read_time());

    kprintf("========================================\n\n");

    /* Halt — spin forever with WFI to save power */
    while (true) {
        arch::cpu::halt_until_interrupt();
    }
}
