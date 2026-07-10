/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Signal Types — Linux-compatible structures for signal delivery
 *
 * Follows the RISC-V LP64 ABI layout so that user-space programs
 * compiled with musl / glibc see the correct struct sizes.
 *
 * Reference: Linux include/uapi/asm-generic/signal.h
 *            Linux include/uapi/asm-generic/siginfo.h
 */

#include <lume/types.h>
#include <lume/signal_nr.h>
#include <lume/list.h>
#include <kernel/sync/spinlock.h>

/* ================================================================== */
/*  Signal set (64-bit bitmap)                                        */
/* ================================================================== */

struct sigset_t {
    uint64 sig[_NSIG_WORDS];  /* _NSIG_WORDS = 1 on LP64 */

    void clear()                    { for (auto& s : sig) s = 0; }
    void fill()                     { for (auto& s : sig) s = ~0ULL; }
    void add(int signo)             { sig[(signo-1)/64] |= (1ULL << ((signo-1)%64)); }
    void del(int signo)             { sig[(signo-1)/64] &= ~(1ULL << ((signo-1)%64)); }
    bool has(int signo) const       { return (sig[(signo-1)/64] >> ((signo-1)%64)) & 1; }
    bool is_empty() const           { for (auto s : sig) if (s) return false; return true; }

    sigset_t operator&(const sigset_t& o) const {
        sigset_t r;
        for (int i = 0; i < _NSIG_WORDS; i++) r.sig[i] = sig[i] & o.sig[i];
        return r;
    }
    sigset_t operator|(const sigset_t& o) const {
        sigset_t r;
        for (int i = 0; i < _NSIG_WORDS; i++) r.sig[i] = sig[i] | o.sig[i];
        return r;
    }
    sigset_t operator~() const {
        sigset_t r;
        for (int i = 0; i < _NSIG_WORDS; i++) r.sig[i] = ~sig[i];
        return r;
    }
};

/* ================================================================== */
/*  siginfo_t (simplified, Linux UAPI compatible layout)              */
/* ================================================================== */

struct kernel_siginfo {
    int si_signo;
    int si_errno;
    int si_code;
    int _pad0;            /* alignment */

    union {
        /* kill() */
        struct {
            int32 _pid;
            int32 _uid;
        } _kill;

        /* SIGCHLD */
        struct {
            int32 _pid;
            int32 _uid;
            int   _status;
            long  _utime;
            long  _stime;
        } _sigchld;

        /* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP */
        struct {
            uint64 _addr;
        } _sigfault;

        /* Pad to 128 bytes total (Linux SI_MAX_SIZE) */
        char _pad[128 - 4*sizeof(int)];
    } _sifields;
};

/* ================================================================== */
/*  Signal action (kernel representation)                             */
/* ================================================================== */

/* sa_flags bits (Linux UAPI) */
inline constexpr uint64 SA_NOCLDSTOP  = 0x00000001;
inline constexpr uint64 SA_NOCLDWAIT  = 0x00000002;
inline constexpr uint64 SA_SIGINFO    = 0x00000004;
inline constexpr uint64 SA_RESTORER   = 0x04000000;
inline constexpr uint64 SA_ONSTACK    = 0x08000000;
inline constexpr uint64 SA_RESTART    = 0x10000000;
inline constexpr uint64 SA_NODEFER    = 0x40000000;
inline constexpr uint64 SA_RESETHAND  = 0x80000000;

/* Special handler values */
inline constexpr uint64 SIG_DFL = 0;
inline constexpr uint64 SIG_IGN = 1;
inline constexpr uint64 SIG_ERR = static_cast<uint64>(-1);

struct kernel_sigaction {
    uint64   sa_handler;      /* handler address or SIG_DFL/SIG_IGN */
    uint64   sa_flags;
    uint64   sa_restorer;     /* sigreturn trampoline (SA_RESTORER) */
    sigset_t sa_mask;         /* signals blocked during handler */
};

/* ================================================================== */
/*  Per-task signal state                                             */
/* ================================================================== */

/* Queued signal entry */
struct sigqueue {
    list_node list;
    kernel_siginfo info;
};

/* Pending signal set + queue */
struct sigpending {
    list_node list;           /* list of sigqueue entries */
    sigset_t  signal;         /* bitmap of pending signals */

    void init() {
        list.init();
        signal.clear();
    }
};

/* Signal handler table (shared between threads via CLONE_SIGHAND).
 *
 * Linux pattern (kernel/fork.c:copy_sighand): one sighand_struct per
 * thread group by default, shared across CLONE_SIGHAND siblings,
 * refcounted, freed when the last referencing task exits.  Its
 * `siglock` guards BOTH the action table and every per-task `pending`
 * list of every task that references this sighand.  That single-lock
 * model is what lets send/dequeue/discard race-free without per-list
 * locks. */
struct sighand_struct {
    Spinlock         siglock;
    uint32           refcount;     /* # tasks sharing this sighand (≥1) */
    kernel_sigaction action[_NSIG];

    void init() {
        siglock.init("sighand");
        refcount = 1;
        for (auto& a : action) {
            a.sa_handler = SIG_DFL;
            a.sa_flags   = 0;
            a.sa_restorer = 0;
            a.sa_mask.clear();
        }
    }
};

/* ================================================================== */
/*  signal_struct — per-thread-group shared state                     */
/* ================================================================== */

struct TaskControlBlock;
struct tty_struct;

/*
 * Linux's signal_struct is the per-thread-group container holding:
 *   - Process group / session identity (pgid, sid)
 *   - Controlling terminal (tty)
 *   - Misc state shared across CLONE_THREAD siblings
 *
 * Refcount tracks the number of tasks in the thread group; when the last
 * task in the group exits, the signal_struct is freed.  Detachment from
 * the pgrp hash also happens at that point.
 *
 * `pgrp_link` makes this signal_struct a member of one pgrp bucket; the
 * pgrp subsystem walks the bucket to enumerate all thread groups whose
 * pgid hashes there.
 */
struct signal_struct {
    Spinlock           lock;
    uint32             refcount;       /* # tasks sharing this (≥1) */
    int32              pgid;           /* process group id */
    int32              sid;            /* session id */
    tty_struct*        tty;            /* controlling tty (or nullptr) */
    int32              tty_old_pgrp;   /* SIGHUP target on TIOCNOTTY */
    TaskControlBlock*  leader;         /* thread-group leader (pid==tgid) */
    list_node          pgrp_link;      /* on pgrp hash bucket */

    void init(int32 leader_pid, TaskControlBlock* tg_leader) {
        lock.init("signal");
        refcount     = 1;
        pgid         = leader_pid;
        sid          = leader_pid;
        tty          = nullptr;
        tty_old_pgrp = 0;
        leader       = tg_leader;
        pgrp_link.init();
    }
};

/* ================================================================== */
/*  Default signal dispositions                                       */
/* ================================================================== */

enum SigDefaultAction {
    SIG_ACT_TERM,    /* Terminate */
    SIG_ACT_IGN,     /* Ignore */
    SIG_ACT_CORE,    /* Terminate + core dump */
    SIG_ACT_STOP,    /* Stop process */
    SIG_ACT_CONT,    /* Continue if stopped */
};

/* Returns the default action for a standard signal */
inline SigDefaultAction sig_default_action(int sig)
{
    switch (sig) {
    case SIGCHLD:
    case SIGURG:
    case SIGWINCH:
        return SIG_ACT_IGN;

    case SIGCONT:
        return SIG_ACT_CONT;

    case SIGSTOP:
    case SIGTSTP:
    case SIGTTIN:
    case SIGTTOU:
        return SIG_ACT_STOP;

    case SIGQUIT:
    case SIGILL:
    case SIGTRAP:
    case SIGABRT:
    case SIGBUS:
    case SIGFPE:
    case SIGSEGV:
    case SIGXCPU:
    case SIGXFSZ:
    case SIGSYS:
        return SIG_ACT_CORE;

    default:
        return SIG_ACT_TERM;
    }
}

/* SIG_KERNEL_ONLY: cannot be caught or ignored */
inline bool sig_kernel_only(int sig)
{
    return sig == SIGKILL || sig == SIGSTOP;
}

/* ================================================================== */
/*  SigprocMask how values (Linux UAPI)                               */
/* ================================================================== */

inline constexpr int SIG_BLOCK   = 0;
inline constexpr int SIG_UNBLOCK = 1;
inline constexpr int SIG_SETMASK = 2;
