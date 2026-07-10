/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Process Group / Session Implementation
 *
 * Hash table of signal_struct objects keyed by pgid.  Lifecycle of
 * signal_struct mirrors Linux: one per thread group, refcounted across
 * CLONE_THREAD siblings, freed when the last task in the group exits.
 *
 * Reference: Linux kernel/pid.c, kernel/exit.c
 */

#include <lume/pgrp.h>
#include <lume/signal_types.h>
#include <lume/task.h>
#include <lume/new.h>
#include <lume/klog.h>

/* ================================================================== */
/*  Hash table state                                                  */
/* ================================================================== */

list_node g_pgrp_hash[kPgrpHashSize];
Spinlock  g_pgrp_lock;

void pgrp_init()
{
    for (auto& bucket : g_pgrp_hash) bucket.init();
    g_pgrp_lock.init("pgrp");
}

/* ================================================================== */
/*  Internal helpers (must be called with g_pgrp_lock held)           */
/* ================================================================== */

static void pgrp_attach_locked(signal_struct* sig, int32 pgid)
{
    sig->pgid = pgid;
    list_node* bucket = &g_pgrp_hash[pgrp_hash_idx(pgid)];
    sig->pgrp_link.prev = bucket->prev;
    sig->pgrp_link.next = bucket;
    bucket->prev->next = &sig->pgrp_link;
    bucket->prev = &sig->pgrp_link;
}

static void pgrp_detach_locked(signal_struct* sig)
{
    /* Unlink only if currently on a list — init() makes prev/next point
     * to self, which we treat as "not linked". */
    if (sig->pgrp_link.next == &sig->pgrp_link) return;
    sig->pgrp_link.prev->next = sig->pgrp_link.next;
    sig->pgrp_link.next->prev = sig->pgrp_link.prev;
    sig->pgrp_link.init();
}

/* ================================================================== */
/*  signal_struct allocation / refcount                               */
/* ================================================================== */

signal_struct* alloc_signal_struct(int32 leader_pid, TaskControlBlock* leader)
{
    auto* sig = new signal_struct;
    if (!sig) return nullptr;
    sig->init(leader_pid, leader);

    LockGuard guard(g_pgrp_lock);
    pgrp_attach_locked(sig, leader_pid);
    return sig;
}

signal_struct* fork_signal_struct(signal_struct* parent,
                                  TaskControlBlock* child_leader)
{
    if (!parent) return nullptr;

    auto* sig = new signal_struct;
    if (!sig) return nullptr;

    /* Copy identity from parent, then override leader and attach. */
    sig->lock.init("signal");
    sig->refcount     = 1;
    sig->leader       = child_leader;
    sig->tty_old_pgrp = 0;
    sig->pgrp_link.init();

    {
        LockGuard pg(parent->lock);
        sig->pgid = parent->pgid;
        sig->sid  = parent->sid;
        sig->tty  = parent->tty;
    }

    LockGuard guard(g_pgrp_lock);
    pgrp_attach_locked(sig, sig->pgid);
    return sig;
}

void get_signal_struct(signal_struct* sig)
{
    if (!sig) return;
    LockGuard guard(sig->lock);
    sig->refcount++;
}

void put_signal_struct(signal_struct* sig)
{
    if (!sig) return;

    uint32 remaining;
    {
        LockGuard guard(sig->lock);
        remaining = --sig->refcount;
    }
    if (remaining != 0) return;

    /* Last reference — detach from pgrp hash and free. */
    {
        LockGuard guard(g_pgrp_lock);
        pgrp_detach_locked(sig);
    }
    delete sig;
}

/* ================================================================== */
/*  Pgrp membership change                                            */
/* ================================================================== */

void change_pgid(signal_struct* sig, int32 new_pgid)
{
    if (!sig) return;
    LockGuard guard(g_pgrp_lock);
    if (sig->pgid == new_pgid) return;
    pgrp_detach_locked(sig);
    pgrp_attach_locked(sig, new_pgid);
}

int pgrp_member_count(int32 pgid)
{
    LockGuard guard(g_pgrp_lock);
    int n = 0;
    list_node* bucket = &g_pgrp_hash[pgrp_hash_idx(pgid)];
    for (list_node* node = bucket->next; node != bucket; node = node->next) {
        auto* sig = list_entry<signal_struct, &signal_struct::pgrp_link>(node);
        if (sig->pgid == pgid) n++;
    }
    return n;
}
