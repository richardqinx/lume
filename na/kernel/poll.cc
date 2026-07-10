/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * sys_ppoll — POSIX ppoll() implementation.
 *
 * Linux fs/select.c:do_sys_poll() pattern, simplified for our needs:
 *   - Two-phase loop: "register-then-check".  First pass calls every
 *     f_op->poll() with a real poll_table so drivers can register their
 *     wait queues; if any fd is already ready we return immediately.
 *     Otherwise schedule() until a wq fires (or timeout/signal), then
 *     re-check with poll_table=nullptr (probe-only).
 *
 * Limitations vs. Linux:
 *   - Only a single wait queue per ppoll call is tracked (the first one
 *     a driver hands to poll_wait).  Multi-fd polls work, but only the
 *     first wq's wake actually re-runs the loop; other fds becoming
 *     ready won't be noticed until the timer fires or another wake.
 *     BusyBox interactive shell polls one fd (stdin), so this matches.
 *
 * Reference: Linux fs/select.c
 */

#include <lume/poll.h>
#include <lume/file.h>
#include <lume/fdtable.h>
#include <lume/task.h>
#include <lume/sched.h>
#include <lume/timer.h>
#include <lume/waitqueue.h>
#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/uaccess.h>
#include <lume/errno.h>
#include <lume/klog.h>
#include <lume/new.h>

/* ================================================================== */
/*  poll_wait — called by file_operations->poll() implementations     */
/* ================================================================== */

void poll_wait(file* /*fp*/, WaitQueue* wq, poll_table* pt)
{
    /* Probe-only pass: pt is null, drivers skip registration. */
    if (!pt || !wq) return;
    /* Single-wq design: keep the first one we see.  A more complete
     * implementation would chain entries onto a list. */
    if (!pt->wq) pt->wq = wq;
}

/* ================================================================== */
/*  Linux-compatible timespec                                         */
/* ================================================================== */

struct linux_timespec_pp {
    int64 tv_sec;
    int64 tv_nsec;
};

/*
 * Convert a timespec into a deadline in jiffies (g_jiffies clock).
 * Returns 0 if the input is null (= infinite wait), or a deadline
 * jiffy value otherwise.  Caller treats 0 deadline as "no timeout".
 */
static uint64 timespec_to_deadline(const linux_timespec_pp* ts)
{
    if (!ts) return 0;
    /* g_jiffies advances at 100 Hz (HZ=100) — 1 jiffy = 10 ms */
    uint64 ticks = static_cast<uint64>(ts->tv_sec) * 100ULL;
    ticks += ts->tv_nsec / 10'000'000;          /* 10 ms granularity */
    /* Round up sub-jiffy nsec so a tiny timeout doesn't truncate to 0. */
    if (ts->tv_nsec % 10'000'000 != 0) ticks++;
    return g_jiffies + ticks;
}

/* ================================================================== */
/*  do_poll — one scan over all fds                                   */
/* ================================================================== */

/*
 * For each fd: look up the file, call its poll() callback.  If `pt` is
 * non-null, drivers register their wait queues onto it.  Returns the
 * number of fds that have any non-zero revents.
 */
static int do_poll_scan(pollfd* fds, uint32 nfds, poll_table* pt)
{
    TaskControlBlock* c = current_task();
    files_struct* files = c ? c->files : nullptr;
    if (!files) return 0;
    int ready = 0;

    for (uint32 i = 0; i < nfds; i++) {
        if (fds[i].fd < 0) {
            fds[i].revents = 0;
            continue;
        }
        file* fp = fcheck(files, fds[i].fd);
        if (!fp) {
            fds[i].revents = POLLNVAL;
            ready++;
            continue;
        }
        uint32 mask = 0;
        if (fp->f_op && fp->f_op->poll) {
            mask = fp->f_op->poll(fp, pt);
        } else {
            /* No poll handler — treat as always readable/writable so
             * a missing implementation doesn't permanently block sh. */
            mask = POLLIN | POLLOUT;
        }
        /* Filter: revents always include error/hup; userland event bits
         * only set if requested in events. */
        uint32 always = POLLERR | POLLHUP | POLLNVAL;
        uint32 want = static_cast<uint32>(fds[i].events) | always;
        fds[i].revents = static_cast<int16>(mask & want);
        if (fds[i].revents) ready++;
    }
    return ready;
}

/* ================================================================== */
/*  sys_ppoll                                                         */
/* ================================================================== */

/*
 * a0 = struct pollfd __user *ufds
 * a1 = nfds_t nfds
 * a2 = const struct __kernel_timespec __user *tsp  (nullable = infinite)
 * a3 = const sigset_t __user *sigmask              (nullable = no override)
 * a4 = size_t sigsetsize
 */
int64 sys_ppoll(uint64 a0, uint64 a1, uint64 a2, uint64 a3,
                uint64 a4, uint64 /*a5*/)
{
    uint64 ufds   = a0;
    uint32 nfds   = static_cast<uint32>(a1);
    uint64 utsp   = a2;
    uint64 usigmask = a3;
    uint64 sigsetsize = a4;

    if (nfds > 1024) return -EINVAL;        /* Linux RLIMIT_NOFILE-ish cap */
    if (usigmask && sigsetsize != sizeof(sigset_t)) return -EINVAL;

    /* Copy timespec from user.  Null pointer means "wait forever". */
    bool have_timeout = (utsp != 0);
    linux_timespec_pp ts{};
    if (have_timeout) {
        if (copy_from_user(&ts, utsp, sizeof(ts)) < 0) return -EFAULT;
        if (ts.tv_sec < 0 || ts.tv_nsec < 0 || ts.tv_nsec >= 1'000'000'000)
            return -EINVAL;
    }
    uint64 deadline = have_timeout ? timespec_to_deadline(&ts) : 0;

    /* Apply temporary sigmask if requested.  Linux semantics: the new
     * mask is in effect for the duration of the call; on return we
     * restore the old mask.  If a signal interrupts us mid-wait, the
     * original mask is restored before returning -EINTR. */
    TaskControlBlock* curr = current_task();
    sigset_t saved_mask{};
    bool mask_swapped = false;
    if (usigmask && curr && curr->sighand) {
        sigset_t newmask{};
        if (copy_from_user(&newmask, usigmask, sizeof(newmask)) < 0)
            return -EFAULT;
        newmask.del(SIGKILL);
        newmask.del(SIGSTOP);
        LockGuard guard(curr->sighand->siglock);
        saved_mask = curr->blocked;
        curr->blocked = newmask;
        mask_swapped = true;
    }

    /* Copy pollfd array from user.  Allocate a kernel buffer; for the
     * common nfds<=8 case this is one slab object. */
    pollfd* kfds = nullptr;
    uint64 fds_bytes = static_cast<uint64>(nfds) * sizeof(pollfd);
    int64 ret = 0;

    if (nfds > 0) {
        kfds = static_cast<pollfd*>(operator new[](fds_bytes));
        if (!kfds) { ret = -ENOMEM; goto out_restore_mask; }
        if (copy_from_user(kfds, ufds, fds_bytes) < 0) {
            ret = -EFAULT; goto out_free;
        }
    }

    /* The main poll loop. */
    {
        poll_table pt{};
        pt.wq = nullptr;
        int n_ready = do_poll_scan(kfds, nfds, &pt);

        while (n_ready == 0) {
            /* Timeout==0 means non-blocking probe. */
            if (have_timeout && deadline <= g_jiffies) break;

            /* No registered wait queue?  Nothing to sleep on.  This
             * happens when no fd has a poll handler that calls
             * poll_wait — fall back to a short reschedule loop so we
             * don't burn the CPU. */
            if (!pt.wq) {
                schedule();
                if (signal_pending(curr)) { ret = -EINTR; goto out_free; }
                pt.wq = nullptr;
                n_ready = do_poll_scan(kfds, nfds, &pt);
                continue;
            }

            /* Standard prepare-check-schedule pattern. */
            pt.wq->prepare_to_wait(curr, TaskState::Sleeping);

            /* Re-probe with pt=nullptr (no extra registration) so we
             * see any state change that arrived between the previous
             * scan and prepare_to_wait. */
            n_ready = do_poll_scan(kfds, nfds, nullptr);
            if (n_ready > 0) {
                pt.wq->finish_wait(curr);
                break;
            }
            if (signal_pending(curr)) {
                pt.wq->finish_wait(curr);
                ret = -EINTR; goto out_free;
            }

            schedule();
            pt.wq->finish_wait(curr);

            /* Reset the registration and rescan — drivers may register
             * fresh wait queues this pass. */
            pt.wq = nullptr;
            n_ready = do_poll_scan(kfds, nfds, &pt);
        }
        ret = n_ready;
    }

    /* Copy revents back to user (events bits stay as user wrote them). */
    if (nfds > 0) {
        if (copy_to_user(ufds, kfds, fds_bytes) < 0) ret = -EFAULT;
    }

out_free:
    if (kfds) operator delete[](kfds);

out_restore_mask:
    if (mask_swapped && curr && curr->sighand) {
        LockGuard guard(curr->sighand->siglock);
        curr->blocked = saved_mask;
    }
    return ret;
}
