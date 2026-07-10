/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * tty_core.cc — TTY subsystem core
 *
 * Provides the tty_struct lifecycle, file_operations dispatch,
 * and ioctl routing between the line discipline and driver.
 *
 * Call chain:
 *   sys_read  → tty_fops.read  → tty_read  → ldisc.read
 *   sys_write → tty_fops.write → tty_write → ldisc.write
 *   sys_ioctl → tty_fops.ioctl → tty_ioctl → {core / ldisc / driver}
 */

#include <lume/tty.h>
#include <lume/tty_ioctl.h>
#include <lume/file.h>
#include <lume/fs_types.h>
#include <lume/chardev.h>
#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/signal_nr.h>
#include <lume/task.h>
#include <lume/pgrp.h>
#include <lume/poll.h>
#include <lume/new.h>
#include <lume/errno.h>
#include <lume/klog.h>
#include <lume/slab.h>

#ifndef ENOIOCTLCMD
#define ENOIOCTLCMD 515
#endif

/* ================================================================== */
/*  Global console TTY                                                */
/* ================================================================== */

tty_struct* g_console_tty = nullptr;

/* ================================================================== */
/*  tty_struct allocation                                             */
/* ================================================================== */

tty_struct* tty_alloc(const tty_driver* driver, int index)
{
    auto* tty = new tty_struct{};
    if (!tty) return nullptr;

    tty->index = index;
    tty->driver = driver;
    tty->link = nullptr;
    tty->pgrp = 0;
    tty->session = 0;
    tty->write_cnt = 0;
    tty->flags = 0;
    tty->open_count = 0;
    tty->driver_data = nullptr;

    tty_default_termios(&tty->termios_data);

    tty->ws.ws_row = 24;
    tty->ws.ws_col = 80;
    tty->ws.ws_xpixel = 0;
    tty->ws.ws_ypixel = 0;

    tty->lock.init("tty");
    tty->read_wait.init("tty_rd");
    tty->write_wait.init("tty_wr");

    /* Attach default line discipline (N_TTY) */
    tty->ldisc.ops = &n_tty_ops;
    tty->ldisc.data = nullptr;

    return tty;
}

/* ================================================================== */
/*  tty_open / tty_close                                              */
/* ================================================================== */

int tty_open(tty_struct* tty)
{
    if (!tty) return -EINVAL;

    if (tty->open_count == 0) {
        /* Initialize line discipline */
        if (tty->ldisc.ops && tty->ldisc.ops->open) {
            int ret = tty->ldisc.ops->open(tty);
            if (ret < 0) return ret;
        }

        /* Initialize driver */
        if (tty->driver && tty->driver->ops && tty->driver->ops->open) {
            int ret = tty->driver->ops->open(tty);
            if (ret < 0) {
                if (tty->ldisc.ops && tty->ldisc.ops->close)
                    tty->ldisc.ops->close(tty);
                return ret;
            }
        }
    }

    tty->open_count++;
    return 0;
}

void tty_close(tty_struct* tty)
{
    if (!tty) return;

    tty->open_count--;
    if (tty->open_count <= 0) {
        tty->open_count = 0;

        if (tty->driver && tty->driver->ops && tty->driver->ops->close)
            tty->driver->ops->close(tty);

        if (tty->ldisc.ops && tty->ldisc.ops->close)
            tty->ldisc.ops->close(tty);
    }
}

/* ================================================================== */
/*  Core I/O                                                          */
/* ================================================================== */

int64 tty_read(tty_struct* tty, file* fp, char* buf, uint64 count)
{
    if (!tty || !tty->ldisc.ops || !tty->ldisc.ops->read)
        return -EIO;

    return tty->ldisc.ops->read(tty, fp, buf, count);
}

int64 tty_write(tty_struct* tty, file* fp, const char* buf, uint64 count)
{
    if (!tty || !tty->ldisc.ops || !tty->ldisc.ops->write)
        return -EIO;

    return tty->ldisc.ops->write(tty, fp, buf, count);
}

/* ================================================================== */
/*  tty_receive_buf — called by driver on RX                          */
/* ================================================================== */

void tty_receive_buf(tty_struct* tty, const char* buf, int count)
{
    if (!tty || !tty->ldisc.ops || !tty->ldisc.ops->receive_buf)
        return;

    tty->ldisc.ops->receive_buf(tty, buf, count);
}

/* ================================================================== */
/*  tty_signal_pgrp — send signal to foreground process group         */
/* ================================================================== */

extern int send_signal(int sig, kernel_siginfo* info, TaskControlBlock* task);

void tty_signal_pgrp(tty_struct* tty, int sig)
{
    if (!tty) return;

    int32 pgid;
    {
        LockGuard guard(tty->lock);
        pgid = tty->pgrp;
    }
    if (pgid <= 0) return;

    /* Deliver to the leader of every thread group in the foreground
     * process group.  ldisc paths call this for SIGINT/SIGQUIT/SIGWINCH
     * etc.; previously we only signalled the current task, which was
     * incorrect when the fg pgrp had multiple processes. */
    kernel_siginfo info{};
    info.si_signo = sig;
    info.si_code  = 0;  /* SI_KERNEL would be 0x80; user rarely checks */
    for_each_pgrp_member(pgid, [&](signal_struct* s) {
        if (s->leader)
            send_signal(sig, &info, s->leader);
    });
}

/* ================================================================== */
/*  tty_ioctl — ioctl dispatch                                        */
/* ================================================================== */

long tty_ioctl(tty_struct* tty, file* /*fp*/, unsigned int cmd, uint64 arg)
{
    if (!tty) return -EINVAL;

    switch (cmd) {
    case TCGETS: {
        auto* p = reinterpret_cast<termios*>(arg);
        if (!p) return -EINVAL;
        *p = tty->termios_data;
        return 0;
    }

    case TCSETS:
    case TCSETSW:
    case TCSETSF: {
        auto* p = reinterpret_cast<const termios*>(arg);
        if (!p) return -EINVAL;
        termios old = tty->termios_data;
        tty->termios_data = *p;

        /* Notify line discipline of termios change */
        if (tty->ldisc.ops && tty->ldisc.ops->set_termios)
            tty->ldisc.ops->set_termios(tty, &old);

        /* If TCSETSF, flush input buffer */
        if (cmd == TCSETSF) {
            if (tty->ldisc.ops && tty->ldisc.ops->flush_buffer)
                tty->ldisc.ops->flush_buffer(tty);
        }
        return 0;
    }

    case TIOCGWINSZ: {
        auto* p = reinterpret_cast<winsize*>(arg);
        if (!p) return -EINVAL;
        *p = tty->ws;
        return 0;
    }

    case TIOCSWINSZ: {
        auto* p = reinterpret_cast<const winsize*>(arg);
        if (!p) return -EINVAL;
        winsize old = tty->ws;
        tty->ws = *p;
        if (old.ws_row != tty->ws.ws_row || old.ws_col != tty->ws.ws_col) {
            tty_signal_pgrp(tty, SIGWINCH);
        }
        return 0;
    }

    case TIOCGPGRP: {
        auto* p = reinterpret_cast<int32*>(arg);
        if (!p) return -EINVAL;

        TaskControlBlock* curr = current_task();
        if (!curr || !curr->signal) return -ENOTTY;
        if (curr->signal->tty != tty) return -ENOTTY;

        int32 pgid;
        {
            LockGuard guard(tty->lock);
            pgid = tty->pgrp != 0 ? tty->pgrp : curr->signal->pgid;
        }
        *p = pgid;
        return 0;
    }

    case TIOCSPGRP: {
        auto* p = reinterpret_cast<const int32*>(arg);
        if (!p) return -EINVAL;

        TaskControlBlock* curr = current_task();
        if (!curr || !curr->signal) return -ENOTTY;
        if (curr->signal->tty != tty) return -ENOTTY;

        int32 new_pgid = *p;
        if (new_pgid <= 0) return -EINVAL;

        /* new_pgid must be in the caller's session. */
        bool ok = false;
        for_each_pgrp_member(new_pgid, [&](signal_struct* s) {
            if (s->sid == curr->signal->sid) ok = true;
        });
        if (!ok) return -EPERM;

        LockGuard guard(tty->lock);
        tty->pgrp = new_pgid;
        return 0;
    }

    case TIOCSCTTY: {
        /* Become the controlling terminal of the caller's session.
         * Linux: only session leader without ctty may do this; with
         * arg==1, CAP_SYS_ADMIN may steal a ctty from another session.
         * We support the basic path; "steal" is left unimplemented. */
        TaskControlBlock* curr = current_task();
        if (!curr || !curr->signal) return -EPERM;
        signal_struct* sig = curr->signal;

        if (sig->sid != curr->pid) return -EPERM;     /* not leader */

        LockGuard sg(sig->lock);
        if (sig->tty != nullptr) return -EPERM;       /* already have one */

        LockGuard tg(tty->lock);
        if (tty->session != 0 && tty->session != sig->sid) {
            return -EPERM;                            /* owned elsewhere */
        }
        tty->session = sig->sid;
        tty->pgrp    = sig->pgid;
        sig->tty     = tty;
        return 0;
    }

    case TIOCNOTTY: {
        /* Detach from controlling terminal. */
        TaskControlBlock* curr = current_task();
        if (!curr || !curr->signal) return -ENOTTY;
        signal_struct* sig = curr->signal;
        if (sig->tty != tty) return -ENOTTY;

        /* Session leader: HUP everyone left in the old fg pgrp.
         * Job-control conformance — without this, daemons spawned by
         * a relinquishing leader keep blocking on a dead terminal. */
        bool was_leader = (sig->sid == curr->pid);
        int32 hup_pgrp = 0;
        {
            LockGuard tg(tty->lock);
            hup_pgrp = tty->pgrp;
            if (was_leader) {
                tty->session = 0;
                tty->pgrp    = 0;
            }
        }
        {
            LockGuard sg(sig->lock);
            sig->tty = nullptr;
        }
        if (was_leader && hup_pgrp > 0) {
            tty_signal_pgrp(tty, SIGHUP);
            tty_signal_pgrp(tty, SIGCONT);
            (void)hup_pgrp;
        }
        return 0;
    }

    case FIONREAD: {
        /* Delegate to line discipline */
        if (tty->ldisc.ops && tty->ldisc.ops->ioctl) {
            int ret = tty->ldisc.ops->ioctl(tty, cmd, arg);
            if (ret != -ENOIOCTLCMD)
                return ret;
        }
        return 0;
    }

    case TCFLSH: {
        int queue = static_cast<int>(arg);
        if (queue == 0 || queue == 2) {
            /* Flush input */
            if (tty->ldisc.ops && tty->ldisc.ops->flush_buffer)
                tty->ldisc.ops->flush_buffer(tty);
        }
        if (queue == 1 || queue == 2) {
            /* Flush output */
            if (tty->driver && tty->driver->ops && tty->driver->ops->flush_buffer)
                tty->driver->ops->flush_buffer(tty);
        }
        return 0;
    }

    default:
        break;
    }

    /* Try line discipline ioctl */
    if (tty->ldisc.ops && tty->ldisc.ops->ioctl) {
        int ret = tty->ldisc.ops->ioctl(tty, cmd, arg);
        if (ret != -ENOIOCTLCMD)
            return ret;
    }

    /* Try driver ioctl */
    if (tty->driver && tty->driver->ops && tty->driver->ops->ioctl) {
        int ret = tty->driver->ops->ioctl(tty, cmd, arg);
        if (ret != -ENOIOCTLCMD)
            return ret;
    }

    return -ENOTTY;
}

/* ================================================================== */
/*  file_operations for TTY devices                                   */
/* ================================================================== */

static int64 tty_fops_read(file* fp, char* buf, uint64 count, int64* /*pos*/)
{
    auto* tty = static_cast<tty_struct*>(fp->private_data);
    return tty_read(tty, fp, buf, count);
}

static int64 tty_fops_write(file* fp, const char* buf, uint64 count, int64* /*pos*/)
{
    auto* tty = static_cast<tty_struct*>(fp->private_data);
    return tty_write(tty, fp, buf, count);
}

static long tty_fops_ioctl(file* fp, unsigned int cmd, uint64 arg)
{
    auto* tty = static_cast<tty_struct*>(fp->private_data);
    return tty_ioctl(tty, fp, cmd, arg);
}

/*
 * tty poll callback — Linux drivers/tty/tty_io.c:tty_poll() does the
 * same thing: register tty->read_wait so the poller is woken on input,
 * then ask the ldisc whether data is currently available.  Write side
 * is always considered ready since our writes don't block.
 */
extern bool n_tty_input_ready(tty_struct* tty);
extern void poll_wait(file*, WaitQueue*, poll_table*);

static uint32 tty_fops_poll(file* fp, void* pt)
{
    auto* tty = static_cast<tty_struct*>(fp->private_data);
    if (!tty) return POLLNVAL;

    poll_wait(fp, &tty->read_wait, static_cast<poll_table*>(pt));

    uint32 mask = POLLOUT | POLLWRNORM;  /* always writable */
    if (n_tty_input_ready(tty))
        mask |= POLLIN | POLLRDNORM;
    return mask;
}

/*
 * Auto-acquire a controlling terminal on open.
 *
 * POSIX rule: when a session leader without a controlling tty opens a
 * terminal that itself has no controlling session, and the caller did
 * not pass O_NOCTTY, that terminal becomes the controlling terminal of
 * the caller's session.  tty->session and tty->pgrp are seeded from the
 * caller's sid/pgid so that the very first tcgetpgrp() call returns a
 * value matching the caller's pgid — which is precisely what BusyBox
 * ash:setjobctl() needs to exit its setup loop.
 *
 * Reference: Linux drivers/tty/tty_jobctrl.c:tty_open_proc_set_tty()
 */
static void tty_acquire_ctty(tty_struct* tty, file* fp)
{
    TaskControlBlock* curr = current_task();
    if (!curr || !curr->signal) return;
    if (fp->f_flags & O_NOCTTY) return;

    signal_struct* sig = curr->signal;

    /* Must be session leader (sid == pid). */
    if (sig->sid != curr->pid) return;

    LockGuard sig_guard(sig->lock);
    if (sig->tty != nullptr) return;          /* already have one */

    LockGuard tty_guard(tty->lock);
    if (tty->session != 0) return;            /* tty owned by another sess */

    tty->session = sig->sid;
    tty->pgrp    = sig->pgid;
    sig->tty     = tty;
}

static int tty_fops_open(inode* /*ip*/, file* fp)
{
    /* The console TTY is pre-allocated; just attach it */
    if (!g_console_tty) return -ENXIO;
    fp->private_data = g_console_tty;
    int err = tty_open(g_console_tty);
    if (err == 0) {
        tty_acquire_ctty(g_console_tty, fp);
    }
    return err;
}

static int tty_fops_release(inode* /*ip*/, file* fp)
{
    auto* tty = static_cast<tty_struct*>(fp->private_data);
    tty_close(tty);
    return 0;
}

file_operations tty_fops;

static void init_tty_fops()
{
    tty_fops.read           = tty_fops_read;
    tty_fops.write          = tty_fops_write;
    tty_fops.unlocked_ioctl = tty_fops_ioctl;
    tty_fops.poll           = tty_fops_poll;
    tty_fops.open           = tty_fops_open;
    tty_fops.release        = tty_fops_release;
}

/* ================================================================== */
/*  TTY chardev registration                                          */
/* ================================================================== */

static cdev tty_cdev;

void tty_init()
{
    init_tty_fops();

    /* Allocate the console TTY */
    g_console_tty = tty_alloc(&uart_tty_driver, 0);
    if (!g_console_tty) {
        return;
    }

    /* Open the TTY (initializes ldisc + driver) */
    tty_open(g_console_tty);

    /* Leave tty->session and tty->pgrp at 0.  The first session-leader
     * to open /dev/console without O_NOCTTY claims it as its controlling
     * terminal via tty_acquire_ctty(), which fills both fields.  Pre-
     * seeding them here (as we used to with the hardcoded pid==1) would
     * make every subsequent acquire path see "owned by another session"
     * and bail out, leaving sh's tcgetpgrp() returning -ENOTTY and
     * disabling job control. */

    /* Initialize UART RX interrupts */
    uart_tty_init(g_console_tty);

    /* Register UART as a struct console driver.
     * After this, printk/klog output goes through console_write_all()
     * → uart_console_write() instead of raw early_putc(). */
    extern void uart_register_console();
    uart_register_console();

    /* Register as /dev/console chardev — replace the old console_cdev.
     * We use the same major/minor (5,1) so that existing opens
     * to /dev/console will get the TTY fops. */
    tty_cdev.name = "console";
    tty_cdev.dev  = MKDEV(5, 1);
    tty_cdev.fops = &tty_fops;
    cdev_register(&tty_cdev);
}
