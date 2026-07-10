/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Mutex — Linux-style sleeping mutex (no priority inheritance).
 *
 * Semantics mirror Linux kernel/locking/mutex.c:
 *  - Single owner (nullptr when free).
 *  - FIFO wait list — first waiter is the next owner.
 *  - Recursive acquire by the same task is FORBIDDEN (panic).
 *  - Owner MUST be the one to unlock.
 *  - lock() may sleep; MUST NOT be called from IRQ context, with
 *    preemption disabled, or while holding a spinlock.
 *  - try_lock() never sleeps; may be called from any context.
 *
 * Priority inheritance lives in a separate primitive (RtMutex, future)
 * just like Linux splits struct mutex / struct rt_mutex.
 *
 * Reference: docs/specs/mutex.md
 */

#include <lume/types.h>
#include <lume/list.h>
#include <kernel/sync/spinlock.h>

struct TaskControlBlock;

class Mutex {
public:
    void init(const char* name);

    /* Blocking acquire (uninterruptible). */
    void lock();

    /* Non-blocking attempt. Returns true if acquired. */
    bool try_lock();

    /* Release; only the owner may call (else panic). */
    void unlock();

    bool              is_locked()            const { return owner_ != nullptr; }
    bool              is_owned_by_current()  const;
    TaskControlBlock* owner()                const { return owner_; }

private:
    TaskControlBlock* owner_ = nullptr;
    Spinlock          wait_lock_;
    list_node         wait_list_{};
    const char*       name_ = nullptr;
};

/* RAII guard. */
class MutexGuard {
public:
    explicit MutexGuard(Mutex& m) : m_(m) { m_.lock(); }
    ~MutexGuard()                         { m_.unlock(); }
    MutexGuard(const MutexGuard&)            = delete;
    MutexGuard& operator=(const MutexGuard&) = delete;
private:
    Mutex& m_;
};
