/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * poll.h — POSIX poll() / ppoll() infrastructure.
 *
 * Linux pattern (include/linux/poll.h):
 *   - file_operations->poll(file, poll_table) returns a bitmask of
 *     POLL* events that are currently true on this file.
 *   - As a side effect, the poll callback calls poll_wait(file, wq, pt)
 *     to register the caller on every wait queue that might fire when
 *     state changes.  sys_ppoll() then sleeps on those queues until
 *     one of them fires or a signal/timeout arrives.
 *
 * Our minimal implementation supports a SINGLE wait queue per poll call
 * (sufficient for nfds==1, which is the BusyBox interactive shell case).
 * Multi-fd polls work but fall back to busy re-checking; a proper
 * per-fd waiter-list upgrade can come later.
 */

#include <lume/types.h>

struct file;
class  WaitQueue;

/* ================================================================== */
/*  UAPI: pollfd struct + POLL* event bits (Linux asm-generic)        */
/* ================================================================== */

struct pollfd {
    int32  fd;
    int16  events;
    int16  revents;
};

inline constexpr int16 POLLIN     = 0x0001;
inline constexpr int16 POLLPRI    = 0x0002;
inline constexpr int16 POLLOUT    = 0x0004;
inline constexpr int16 POLLERR    = 0x0008;
inline constexpr int16 POLLHUP    = 0x0010;
inline constexpr int16 POLLNVAL   = 0x0020;
inline constexpr int16 POLLRDNORM = 0x0040;
inline constexpr int16 POLLRDBAND = 0x0080;
inline constexpr int16 POLLWRNORM = 0x0100;
inline constexpr int16 POLLWRBAND = 0x0200;

/* ================================================================== */
/*  Kernel-side poll_table                                            */
/* ================================================================== */

/*
 * Carried into file_operations->poll().  Drivers call poll_wait() with
 * the wait queue they'd like the poller to sleep on; we record the
 * first one.  When `wq == nullptr` on entry, no real registration is
 * needed (the caller is just probing readiness).
 */
struct poll_table {
    WaitQueue* wq;   /* first wait queue registered (single-wq design) */
};

/*
 * Called from f_op->poll() implementations to register a wait queue.
 * If `pt` is null we're in a probe-only pass — caller doesn't want to
 * sleep, just to read current revents.
 */
void poll_wait(file* fp, WaitQueue* wq, poll_table* pt);
