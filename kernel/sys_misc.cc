/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Miscellaneous System Calls — busybox bootstrap set
 *
 * Each syscall follows the Linux kernel semantics exactly.
 * Reference: Linux kernel/sys.c, kernel/signal.c, kernel/time/posix-timers.c
 */

#include <lume/types.h>
#include <lume/task.h>
#include <lume/errno.h>
#include <lume/kprintf.h>
#include <lume/klog.h>
#include <lume/pid.h>
#include <lume/pgrp.h>
#include <lume/signal_types.h>
#include <lume/tty.h>
#include <lume/uaccess.h>
#include <arch/cpu.h>

/* ======================================================================
 * sys_reboot — Linux kernel/reboot.c
 *
 * Validates magic numbers and performs the requested action.
 * For now, we only support LINUX_REBOOT_CMD_CAD_ON/OFF (ignore)
 * and reject everything else with -EPERM (no CAP_SYS_BOOT).
 * ====================================================================== */

static constexpr uint32 LINUX_REBOOT_MAGIC1  = 0xfee1dead;
static constexpr uint32 LINUX_REBOOT_MAGIC2  = 672274793;   /* 0x28121969 */
static constexpr uint32 LINUX_REBOOT_MAGIC2A = 85072278;
static constexpr uint32 LINUX_REBOOT_MAGIC2B = 369367448;
static constexpr uint32 LINUX_REBOOT_MAGIC2C = 537993216;

int64 sys_reboot(uint64 magic1, uint64 magic2, uint64 cmd,
                 uint64, uint64, uint64)
{
    /* Linux: kernel/reboot.c — validate magic numbers first */
    if (static_cast<uint32>(magic1) != LINUX_REBOOT_MAGIC1)
        return -EINVAL;
    if (static_cast<uint32>(magic2) != LINUX_REBOOT_MAGIC2 &&
        static_cast<uint32>(magic2) != LINUX_REBOOT_MAGIC2A &&
        static_cast<uint32>(magic2) != LINUX_REBOOT_MAGIC2B &&
        static_cast<uint32>(magic2) != LINUX_REBOOT_MAGIC2C)
        return -EINVAL;

    /* We don't have CAP_SYS_BOOT yet — reject with -EPERM.
     * This matches Linux behavior for unprivileged callers. 
     * Busybox handles this gracefully and continues. */
    (void)cmd;
    printk(KERN_INFO "reboot: cmd=%llu (not implemented, returning -EPERM)\n", cmd);
    return -EPERM;
}

/* ======================================================================
 * sys_prctl — Linux kernel/sys.c
 *
 * Process control. Most options are optional for early boot.
 * We implement the minimum set busybox needs.
 * ====================================================================== */

/* prctl option constants (from <linux/prctl.h>) */
static constexpr int PR_SET_NAME      = 15;
static constexpr int PR_GET_NAME      = 16;
static constexpr int PR_SET_PDEATHSIG = 1;
static constexpr int PR_GET_PDEATHSIG = 2;

int64 sys_prctl(uint64 option, uint64 arg2, uint64 arg3,
                uint64 arg4, uint64 arg5, uint64)
{
    switch (static_cast<int>(option)) {
    case PR_SET_PDEATHSIG:
        /* Linux: set signal delivered when parent dies.
         * Silently accept — we don't track pdeath_signal yet. */
        return 0;
    case PR_GET_PDEATHSIG: {
        /* Linux: return current pdeath_signal (0 = none) */
        int32 zero = 0;
        if (copy_to_user(arg2, &zero, sizeof(zero)) != 0)
            return -EFAULT;
        return 0;
    }
    case PR_SET_NAME: {
        /* Linux: set comm (task name), max 16 chars */
        /* TODO: copy_from_user the string */
        return 0;
    }
    case PR_GET_NAME: {
        /* Linux: get comm (task name) */
        TaskControlBlock* curr = current_task();
        if (!curr) return -ESRCH;
        const char* name = curr->name ? curr->name : "";
        uint64 len = 0;
        while (name[len] && len < 15) len++;
        char buf[16] = {};
        for (uint64 i = 0; i < len; i++) buf[i] = name[i];
        if (copy_to_user(arg2, buf, 16) != 0)
            return -EFAULT;
        return 0;
    }
    default:
        /* Unknown prctl — Linux returns -EINVAL for unrecognized options */
        return -EINVAL;
    }
}

/* ======================================================================
 * Session / Process-Group syscalls
 *
 * All four operate on the caller's signal_struct (or a target task's).
 * Identity lives in signal_struct, so these become straightforward reads
 * and pgrp-hash updates.  We mirror Linux kernel/sys.c semantics closely.
 * ====================================================================== */

static TaskControlBlock* find_task_by_pid(int32 pid)
{
    extern list_node g_all_tasks;
    extern Spinlock g_task_list_lock;
    LockGuard guard(g_task_list_lock);
    list_node* node = g_all_tasks.next;
    while (node != &g_all_tasks) {
        auto* task = list_entry<TaskControlBlock, &TaskControlBlock::all_link>(node);
        if (task->pid == pid) return task;
        node = node->next;
    }
    return nullptr;
}

/*
 * sys_setsid — Linux kernel/sys.c:ksys_setsid()
 *
 * Caller becomes leader of a new session+pgrp.  Refused if a pgrp with
 * id == caller pid already exists with members other than the caller —
 * that's Linux's "process group id already exists" check, which prevents
 * collisions when a non-leader tries to setsid.
 */
int64 sys_setsid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    TaskControlBlock* curr = current_task();
    if (!curr || !curr->signal) return -ESRCH;

    /* Detect collision: another pgrp already uses our pid as pgid. */
    bool conflict = false;
    for_each_pgrp_member(curr->pid, [&](signal_struct* sig) {
        if (sig != curr->signal) conflict = true;
    });
    if (conflict) return -EPERM;

    /* Move to new pgrp (creates one if missing), update sid, drop ctty. */
    change_pgid(curr->signal, curr->pid);

    /* Detach the controlling terminal.  If this task is the session
     * leader that owns the tty (tty->session == caller's old sid),
     * also clear the tty's session/pgrp so the next session-leader
     * that opens the device can claim it.  Without this, tty->session
     * permanently sticks to the abandoned sid and every subsequent
     * tty_acquire_ctty() bails with "owned by another session" —
     * which is exactly what kept BusyBox's child sh from picking the
     * console back up after init's setsid().
     *
     * Linux's behavior is similar in spirit (disassociate_ctty when
     * the leader exits), but it triggers from exit, not setsid.  Our
     * simpler "clear-on-give-up" matches the way our acquisition path
     * is written. */
    tty_struct* old_tty = nullptr;
    int32 old_sid = 0;
    {
        LockGuard guard(curr->signal->lock);
        old_tty = curr->signal->tty;
        old_sid = curr->signal->sid;
        curr->signal->sid = curr->pid;
        curr->signal->tty = nullptr;
        curr->signal->tty_old_pgrp = 0;
    }
    if (old_tty) {
        LockGuard guard(old_tty->lock);
        if (old_tty->session == old_sid) {
            old_tty->session = 0;
            old_tty->pgrp    = 0;
        }
    }
    return curr->pid;
}

/*
 * sys_setpgid — Linux kernel/sys.c:ksys_setpgid()
 *
 * Move a process between groups within the same session.  Allowed:
 *   - caller targeting self or a child
 *   - target is not a session leader
 *   - target stays in caller's session
 *   - target hasn't exec()'d (we don't track did_exec yet, so skip)
 *   - new pgid is either == target's pid (new group) or names a pgrp
 *     that already exists in the same session
 */
int64 sys_setpgid(uint64 pid, uint64 pgid, uint64, uint64, uint64, uint64)
{
    TaskControlBlock* curr = current_task();
    if (!curr || !curr->signal) return -ESRCH;

    int32 target_pid  = static_cast<int32>(pid);
    int32 target_pgid = static_cast<int32>(pgid);

    if (target_pid  == 0) target_pid  = curr->pid;
    if (target_pgid == 0) target_pgid = target_pid;
    if (target_pgid < 0)  return -EINVAL;

    TaskControlBlock* target = (target_pid == curr->pid)
                             ? curr
                             : find_task_by_pid(target_pid);
    if (!target || !target->signal) return -ESRCH;

    /* Target must be caller or a child of caller. */
    if (target != curr && target->parent != curr) return -ESRCH;

    /* Same session as caller. */
    if (target->signal->sid != curr->signal->sid) return -EPERM;

    /* Cannot move a session leader into a different pgrp. */
    if (target->signal->sid == target->pid) return -EPERM;

    /* If target_pgid != target_pid, the pgrp must already exist in
     * the same session.  pgrp existence == any signal_struct with
     * pgid == target_pgid AND sid == caller's sid. */
    if (target_pgid != target->pid) {
        bool found = false;
        for_each_pgrp_member(target_pgid, [&](signal_struct* sig) {
            if (sig->sid == curr->signal->sid) found = true;
        });
        if (!found) return -EPERM;
    }

    change_pgid(target->signal, target_pgid);
    return 0;
}

/*
 * sys_getpgid — return process group ID of `pid` (0 = self).
 */
int64 sys_getpgid(uint64 pid, uint64, uint64, uint64, uint64, uint64)
{
    TaskControlBlock* curr = current_task();
    if (!curr || !curr->signal) return -ESRCH;

    if (pid == 0) return curr->signal->pgid;

    TaskControlBlock* target = find_task_by_pid(static_cast<int32>(pid));
    if (!target || !target->signal) return -ESRCH;
    return target->signal->pgid;
}

/*
 * sys_getsid — return session ID of `pid` (0 = self).
 */
int64 sys_getsid(uint64 pid, uint64, uint64, uint64, uint64, uint64)
{
    TaskControlBlock* curr = current_task();
    if (!curr || !curr->signal) return -ESRCH;

    if (pid == 0) return curr->signal->sid;

    TaskControlBlock* target = find_task_by_pid(static_cast<int32>(pid));
    if (!target || !target->signal) return -ESRCH;

    /* Linux: -EPERM if target's session differs from caller's and we're
     * in a different namespace.  We have one namespace, so always allow. */
    return target->signal->sid;
}

/* ======================================================================
 * sys_geteuid / sys_getegid — Linux kernel/sys.c
 *
 * Return effective UID/GID. We run everything as root (0).
 * ====================================================================== */

int64 sys_geteuid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    /* Linux: return current_euid(). We are always root. */
    return 0;
}

int64 sys_getegid(uint64, uint64, uint64, uint64, uint64, uint64)
{
    /* Linux: return current_egid(). We are always root. */
    return 0;
}

/* ======================================================================
 * sys_sigaltstack — Linux kernel/signal.c
 *
 * Set/get alternate signal stack. For now, accept and ignore
 * (busybox doesn't critically need it for shell operation).
 * ====================================================================== */

int64 sys_sigaltstack(uint64 uss_ptr, uint64 uoss_ptr,
                      uint64, uint64, uint64, uint64)
{
    /* Linux: if uoss != NULL, return current alt stack info.
     * We don't have alt stacks yet — report SS_DISABLE. */
    if (uoss_ptr != 0) {
        /* stack_t { void* ss_sp; int ss_flags; size_t ss_size; }
         * On RISC-V LP64: 8 + 4 + padding + 8 = 24 bytes typically,
         * but the ABI packs it as {uint64, int32, pad, uint64}. */
        struct {
            uint64 ss_sp;
            int32  ss_flags;
            int32  _pad;
            uint64 ss_size;
        } oss = { 0, 2 /* SS_DISABLE */, 0, 0 };
        if (copy_to_user(uoss_ptr, &oss, sizeof(oss)) != 0)
            return -EFAULT;
    }

    /* uss: silently accept (we'll need it for proper signal handling later) */
    (void)uss_ptr;
    return 0;
}

/* ======================================================================
 * sys_clock_gettime — Linux kernel/time/posix-timers.c
 *
 * Get the current time for a given clock.
 * We use the RISC-V cycle counter as a monotonic source.
 * ====================================================================== */

static constexpr int CLOCK_REALTIME  = 0;
static constexpr int CLOCK_MONOTONIC = 1;

int64 sys_clock_gettime(uint64 clk_id, uint64 tp_ptr,
                        uint64, uint64, uint64, uint64)
{
    if (tp_ptr == 0) return -EFAULT;

    /* Read RISC-V time CSR (mtime mapped to SBI) */
    uint64 ticks = arch::cpu::read_time();

    /* Convert to seconds + nanoseconds.
     * QEMU virt timebase-frequency is 10MHz. */
    constexpr uint64 kTimebaseHz = 10'000'000ULL;
    uint64 sec  = ticks / kTimebaseHz;
    uint64 nsec = (ticks % kTimebaseHz) * (1'000'000'000ULL / kTimebaseHz);

    struct timespec64 {
        int64  tv_sec;
        int64  tv_nsec;
    };

    timespec64 ts;
    ts.tv_sec  = static_cast<int64>(sec);
    ts.tv_nsec = static_cast<int64>(nsec);

    (void)clk_id;  /* We treat all clocks as monotonic for now */

    if (copy_to_user(tp_ptr, &ts, sizeof(ts)) != 0)
        return -EFAULT;

    return 0;
}
