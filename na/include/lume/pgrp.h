/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Process Group / Session infrastructure.
 *
 * Linux models pgrp/session via struct pid + PIDTYPE_PGID/PIDTYPE_SID hlists.
 * We use a simpler design that supports the same operations cheaply:
 *
 *   - Each thread group owns one signal_struct (refcount-shared with
 *     CLONE_THREAD siblings).
 *   - signal_struct carries pgid/sid and is the linked-list node on a
 *     fixed-size pgrp hash table.
 *   - kill(pid<=0), tty_signal_pgrp, orphan checks all walk one bucket.
 *
 * Concurrency: g_pgrp_lock protects every bucket and the pgrp_link of
 * every signal_struct on a bucket.  signal_struct::lock is a finer-grain
 * lock for fields that change without re-hashing (e.g. tty pointer).
 *
 * Reference: Linux include/linux/pid.h, kernel/pid.c
 */

#include <lume/types.h>
#include <lume/list.h>
#include <kernel/sync/spinlock.h>

struct signal_struct;
struct TaskControlBlock;

/* ================================================================== */
/*  Subsystem init                                                    */
/* ================================================================== */

void pgrp_init();

/* ================================================================== */
/*  signal_struct lifecycle                                           */
/* ================================================================== */

/*
 * Allocate a new signal_struct for `leader`, with sid=pgid=leader_pid,
 * refcount=1, attached to pgrp `leader_pid`.  Returns nullptr on OOM.
 */
signal_struct* alloc_signal_struct(int32 leader_pid,
                                   TaskControlBlock* leader);

/*
 * Allocate a child signal_struct inheriting pgid/sid/tty from `parent`.
 * The new struct is attached to the parent's pgrp and starts with
 * refcount=1.  Used by fork (non-CLONE_THREAD).
 */
signal_struct* fork_signal_struct(signal_struct* parent,
                                  TaskControlBlock* child_leader);

/* Increment refcount (CLONE_THREAD share). */
void get_signal_struct(signal_struct* sig);

/*
 * Decrement refcount; on last drop, detach from pgrp hash and free.
 * Pass the task that's dropping the reference so we can manage
 * leader pointers if the leader exits while sub-threads remain.
 */
void put_signal_struct(signal_struct* sig);

/* ================================================================== */
/*  Pgrp operations (assume signal_struct is allocated)               */
/* ================================================================== */

/*
 * Move a signal_struct from its current pgrp to `new_pgid`.
 * Used by setpgid / setsid.  Takes g_pgrp_lock internally.
 */
void change_pgid(signal_struct* sig, int32 new_pgid);

/*
 * Invoke `fn(sig)` for every signal_struct whose pgid == target.
 * Holds g_pgrp_lock for the entire walk — fn must not block, sleep,
 * or take locks that order before g_pgrp_lock.
 *
 * Template-y but kept in header to avoid a function-ptr indirection;
 * keep callsites lean.
 */
template <typename F>
void for_each_pgrp_member(int32 target_pgid, F&& fn);

/*
 * Count the number of signal_structs in `pgid`.  Used by setsid
 * preflight (can't create a session if you're already a pgrp leader
 * with members) and orphan checks.
 */
int pgrp_member_count(int32 pgid);

/* ================================================================== */
/*  Implementation details exposed for the template above             */
/* ================================================================== */

constexpr int kPgrpHashShift = 6;
constexpr int kPgrpHashSize  = 1 << kPgrpHashShift;  /* 64 buckets */
constexpr int kPgrpHashMask  = kPgrpHashSize - 1;

extern list_node g_pgrp_hash[kPgrpHashSize];
extern Spinlock  g_pgrp_lock;

inline int pgrp_hash_idx(int32 pgid) {
    return static_cast<int>(static_cast<uint32>(pgid)) & kPgrpHashMask;
}

#include <lume/signal_types.h>

template <typename F>
void for_each_pgrp_member(int32 target_pgid, F&& fn)
{
    LockGuard guard(g_pgrp_lock);
    list_node* bucket = &g_pgrp_hash[pgrp_hash_idx(target_pgid)];
    list_node* node = bucket->next;
    while (node != bucket) {
        list_node* nxt = node->next;   /* fn may not unlink, but be safe */
        auto* sig = list_entry<signal_struct, &signal_struct::pgrp_link>(node);
        if (sig->pgid == target_pgid)
            fn(sig);
        node = nxt;
    }
}
