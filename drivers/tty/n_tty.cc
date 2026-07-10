/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * n_tty.cc — N_TTY line discipline
 *
 * Implements the standard terminal line discipline:
 *
 * Canonical mode (ICANON):
 *   Input is buffered until newline/EOF. Backspace (VERASE) and
 *   kill-line (VKILL) editing are supported.
 *
 * Raw mode (!ICANON):
 *   Characters are available immediately (subject to VMIN/VTIME).
 *
 * Signal generation (ISIG):
 *   VINTR → SIGINT, VQUIT → SIGQUIT, VSUSP → SIGTSTP
 *
 * Echo (ECHO):
 *   Typed characters are reflected to output.
 *
 * Input processing (c_iflag):
 *   ICRNL: CR → NL mapping
 *   INLCR: NL → CR mapping
 *   IGNCR: ignore CR
 *   ISTRIP: strip high bit
 *
 * Output processing (c_oflag):
 *   OPOST + ONLCR: NL → CR+NL on output
 *
 * Reference: Linux drivers/tty/n_tty.c
 */

#include <lume/tty.h>
#include <lume/tty_ioctl.h>
#include <lume/signal.h>
#include <lume/signal_nr.h>
#include <lume/slab.h>
#include <lume/new.h>
#include <lume/errno.h>
#include <lume/task.h>
#include <lume/sched.h>

#ifndef ENOIOCTLCMD
#define ENOIOCTLCMD 515
#endif

extern void schedule();

/* ================================================================== */
/*  N_TTY internal data                                               */
/* ================================================================== */

inline constexpr int N_TTY_BUF_SIZE = 4096;

struct n_tty_data {
    char    read_buf[N_TTY_BUF_SIZE];
    int     read_head;      /* producer writes here (from receive_buf) */
    int     read_tail;      /* consumer reads from here (from read()) */
    int     canon_head;     /* in canonical mode: end of last complete line */
    bool    eof_pending;    /* Ctrl+D was pressed */
    Spinlock lock;
};

static inline int buf_count(const n_tty_data* d)
{
    return (d->read_head - d->read_tail + N_TTY_BUF_SIZE) % N_TTY_BUF_SIZE;
}

static inline int canon_count(const n_tty_data* d)
{
    return (d->canon_head - d->read_tail + N_TTY_BUF_SIZE) % N_TTY_BUF_SIZE;
}

static inline bool buf_full(const n_tty_data* d)
{
    return buf_count(d) >= N_TTY_BUF_SIZE - 1;
}

static inline void buf_put(n_tty_data* d, char c)
{
    d->read_buf[d->read_head] = c;
    d->read_head = (d->read_head + 1) % N_TTY_BUF_SIZE;
}

static inline char buf_get(n_tty_data* d)
{
    char c = d->read_buf[d->read_tail];
    d->read_tail = (d->read_tail + 1) % N_TTY_BUF_SIZE;
    return c;
}

/* ================================================================== */
/*  Output helpers                                                    */
/* ================================================================== */

static void tty_put_char(tty_struct* tty, char c)
{
    if (tty->driver && tty->driver->ops && tty->driver->ops->put_char) {
        tty->driver->ops->put_char(tty, c);
    }
}

/*
 * Process and output a single character, applying c_oflag transformations.
 */
static void tty_output_char(tty_struct* tty, char c)
{
    if (tty->termios_data.c_oflag & OPOST) {
        if (c == '\n' && (tty->termios_data.c_oflag & ONLCR)) {
            tty_put_char(tty, '\r');
            tty_put_char(tty, '\n');
            return;
        }
        if (c == '\r' && (tty->termios_data.c_oflag & OCRNL)) {
            tty_put_char(tty, '\n');
            return;
        }
    }
    tty_put_char(tty, c);
}

/*
 * Echo a character back to the terminal.
 * Control characters are displayed as ^X.
 */
static void echo_char(tty_struct* tty, char c)
{
    if (!(tty->termios_data.c_lflag & ECHO))
        return;

    if (c == '\n') {
        tty_output_char(tty, '\n');
        return;
    }

    if (c == '\t') {
        tty_put_char(tty, '\t');
        return;
    }

    /* Control characters: echo as ^X */
    if ((tty->termios_data.c_lflag & ECHOCTL) && c < 0x20 && c != '\t' && c != '\n') {
        tty_put_char(tty, '^');
        tty_put_char(tty, c + '@');
        return;
    }

    if (c == 0x7f) {  /* DEL */
        tty_put_char(tty, '^');
        tty_put_char(tty, '?');
        return;
    }

    tty_output_char(tty, c);
}

/*
 * Erase one character visually (backspace + space + backspace).
 */
static void erase_char(tty_struct* tty, char erased)
{
    if (!(tty->termios_data.c_lflag & ECHO))
        return;

    if ((tty->termios_data.c_lflag & ECHOE)) {
        /* If the erased char was a control char displayed as ^X, erase 2 cols */
        if ((erased < 0x20 && erased != '\t' && erased != '\n') || erased == 0x7f) {
            tty_put_char(tty, '\b');
            tty_put_char(tty, ' ');
            tty_put_char(tty, '\b');
            tty_put_char(tty, '\b');
            tty_put_char(tty, ' ');
            tty_put_char(tty, '\b');
        } else {
            tty_put_char(tty, '\b');
            tty_put_char(tty, ' ');
            tty_put_char(tty, '\b');
        }
    }
}

/* ================================================================== */
/*  Input processing — receive_buf (called from IRQ or driver)        */
/* ================================================================== */

static void n_tty_receive_buf(tty_struct* tty, const char* cp, int count)
{
    auto* d = static_cast<n_tty_data*>(tty->ldisc.data);
    if (!d) return;

    const termios& t = tty->termios_data;

    LockGuard guard(d->lock);

    for (int i = 0; i < count; i++) {
        char c = cp[i];

        /* Strip high bit if requested */
        if (t.c_iflag & ISTRIP)
            c &= 0x7f;

        /* Input CR/NL processing */
        if (c == '\r') {
            if (t.c_iflag & IGNCR)
                continue;
            if (t.c_iflag & ICRNL)
                c = '\n';
        } else if (c == '\n') {
            if (t.c_iflag & INLCR)
                c = '\r';
        }

        /* Signal generation */
        if (t.c_lflag & ISIG) {
            if (c == t.c_cc[VINTR]) {
                tty_signal_pgrp(tty, SIGINT);
                echo_char(tty, c);
                if (!(t.c_lflag & NOFLSH)) {
                    /* Flush input buffer */
                    d->read_head = d->read_tail;
                    d->canon_head = d->read_tail;
                }
                continue;
            }
            if (c == t.c_cc[VQUIT]) {
                tty_signal_pgrp(tty, SIGQUIT);
                echo_char(tty, c);
                if (!(t.c_lflag & NOFLSH)) {
                    d->read_head = d->read_tail;
                    d->canon_head = d->read_tail;
                }
                continue;
            }
            if (c == t.c_cc[VSUSP]) {
                tty_signal_pgrp(tty, SIGTSTP);
                echo_char(tty, c);
                continue;
            }
        }

        /* Canonical mode processing */
        if (t.c_lflag & ICANON) {
            /* EOF (Ctrl+D) */
            if (c == t.c_cc[VEOF]) {
                d->eof_pending = true;
                d->canon_head = d->read_head;
                tty->read_wait.wake_all();
                continue;
            }

            /* ERASE (backspace/DEL) */
            if (c == t.c_cc[VERASE]) {
                if (d->read_head != d->canon_head &&
                    d->read_head != d->read_tail) {
                    int prev = (d->read_head - 1 + N_TTY_BUF_SIZE) % N_TTY_BUF_SIZE;
                    char erased = d->read_buf[prev];
                    d->read_head = prev;
                    erase_char(tty, erased);
                }
                continue;
            }

            /* KILL (Ctrl+U — erase entire line) */
            if (c == t.c_cc[VKILL]) {
                while (d->read_head != d->canon_head &&
                       d->read_head != d->read_tail) {
                    int prev = (d->read_head - 1 + N_TTY_BUF_SIZE) % N_TTY_BUF_SIZE;
                    char erased = d->read_buf[prev];
                    d->read_head = prev;
                    erase_char(tty, erased);
                }
                if (t.c_lflag & ECHOK) {
                    tty_output_char(tty, '\n');
                }
                continue;
            }

            /* WERASE (Ctrl+W — erase word) */
            if ((t.c_lflag & IEXTEN) && c == t.c_cc[VWERASE]) {
                /* Skip trailing spaces */
                while (d->read_head != d->canon_head) {
                    int prev = (d->read_head - 1 + N_TTY_BUF_SIZE) % N_TTY_BUF_SIZE;
                    if (d->read_buf[prev] != ' ' && d->read_buf[prev] != '\t')
                        break;
                    erase_char(tty, d->read_buf[prev]);
                    d->read_head = prev;
                }
                /* Erase word */
                while (d->read_head != d->canon_head) {
                    int prev = (d->read_head - 1 + N_TTY_BUF_SIZE) % N_TTY_BUF_SIZE;
                    if (d->read_buf[prev] == ' ' || d->read_buf[prev] == '\t')
                        break;
                    erase_char(tty, d->read_buf[prev]);
                    d->read_head = prev;
                }
                continue;
            }

            /* REPRINT (Ctrl+R) */
            if ((t.c_lflag & IEXTEN) && c == t.c_cc[VREPRINT]) {
                tty_output_char(tty, '\n');
                int pos = d->canon_head;
                while (pos != d->read_head) {
                    echo_char(tty, d->read_buf[pos]);
                    pos = (pos + 1) % N_TTY_BUF_SIZE;
                }
                continue;
            }

            /* Regular character — buffer it */
            if (!buf_full(d)) {
                buf_put(d, c);
                echo_char(tty, c);
            }

            /* Line complete on newline or EOL */
            if (c == '\n' || c == t.c_cc[VEOL] ||
                (t.c_cc[VEOL2] && c == t.c_cc[VEOL2])) {
                d->canon_head = d->read_head;
                tty->read_wait.wake_all();
            }
        } else {
            /* Raw / non-canonical mode */
            if (!buf_full(d)) {
                buf_put(d, c);
                echo_char(tty, c);
                tty->read_wait.wake_all();
            }
        }
    }
}

/* ================================================================== */
/*  N_TTY read — blocking read from the input buffer                  */
/* ================================================================== */

static int n_tty_read(tty_struct* tty, file* fp, char* buf, uint64 count)
{
    auto* d = static_cast<n_tty_data*>(tty->ldisc.data);
    if (!d) return -EIO;

    const termios& t = tty->termios_data;
    TaskControlBlock* curr = current_task();
    int copied = 0;

    if (t.c_lflag & ICANON) {
        /* Canonical mode: block until a complete line is available */
        while (canon_count(d) == 0 && !d->eof_pending) {
            if (tty->flags & TTY_IO_ERROR)
                return -EIO;

            /* Check for pending signals — return -EINTR so the
             * trap return path can deliver them via do_signal() */
            if (signal_pending(curr))
                return -EINTR;

            tty->read_wait.prepare_to_wait(curr, TaskState::Sleeping);
            if (canon_count(d) == 0 && !d->eof_pending)
                schedule();
            tty->read_wait.finish_wait(curr);
        }

        if (d->eof_pending && canon_count(d) == 0) {
            d->eof_pending = false;
            return 0;  /* EOF */
        }

        /* Copy up to one line */
        LockGuard guard(d->lock);
        while (copied < static_cast<int>(count) && d->read_tail != d->canon_head) {
            buf[copied++] = buf_get(d);
        }
    } else {
        /* Non-canonical mode */
        int vmin = t.c_cc[VMIN];
        /* VTIME not implemented (would need timers) */

        if (vmin == 0) vmin = 1;

        while (buf_count(d) < vmin) {
            if (tty->flags & TTY_IO_ERROR)
                return -EIO;

            if (signal_pending(curr))
                return -EINTR;

            tty->read_wait.prepare_to_wait(curr, TaskState::Sleeping);
            if (buf_count(d) < vmin)
                schedule();
            tty->read_wait.finish_wait(curr);
        }

        LockGuard guard(d->lock);
        while (copied < static_cast<int>(count) && buf_count(d) > 0) {
            buf[copied++] = buf_get(d);
        }
    }

    return copied;
}

/* ================================================================== */
/*  N_TTY write — output through the driver with post-processing      */
/* ================================================================== */

static int n_tty_write(tty_struct* tty, file* fp, const char* buf, uint64 count)
{
    if (!tty->driver || !tty->driver->ops || !tty->driver->ops->write)
        return -EIO;

    /* Apply output processing (OPOST) */
    if (tty->termios_data.c_oflag & OPOST) {
        for (uint64 i = 0; i < count; i++) {
            tty_output_char(tty, buf[i]);
        }
        return static_cast<int>(count);
    }

    /* Raw output: pass directly to driver */
    return tty->driver->ops->write(tty, buf, static_cast<int>(count));
}

/* ================================================================== */
/*  N_TTY ioctl                                                       */
/* ================================================================== */

static int n_tty_ioctl(tty_struct* tty, unsigned int cmd, uint64 arg)
{
    auto* d = static_cast<n_tty_data*>(tty->ldisc.data);

    switch (cmd) {
    case FIONREAD: {
        int count = buf_count(d);
        auto* p = reinterpret_cast<int*>(arg);
        *p = count;
        return 0;
    }
    default:
        return -ENOIOCTLCMD;
    }
}

/* ================================================================== */
/*  N_TTY open / close                                                */
/* ================================================================== */

static int n_tty_open(tty_struct* tty)
{
    auto* d = new n_tty_data{};
    if (!d) return -ENOMEM;

    d->read_head = 0;
    d->read_tail = 0;
    d->canon_head = 0;
    d->eof_pending = false;
    d->lock.init("n_tty");

    tty->ldisc.data = d;
    return 0;
}

static void n_tty_close(tty_struct* tty)
{
    auto* d = static_cast<n_tty_data*>(tty->ldisc.data);
    if (d) {
        delete d;
        tty->ldisc.data = nullptr;
    }
}

static void n_tty_flush_buffer(tty_struct* tty)
{
    auto* d = static_cast<n_tty_data*>(tty->ldisc.data);
    if (!d) return;
    LockGuard guard(d->lock);
    d->read_head = 0;
    d->read_tail = 0;
    d->canon_head = 0;
    d->eof_pending = false;
}

static int n_tty_chars_in_buffer(tty_struct* tty)
{
    auto* d = static_cast<n_tty_data*>(tty->ldisc.data);
    if (!d) return 0;
    return buf_count(d);
}

/*
 * Probe input readiness for poll().  In canonical mode the read syscall
 * blocks until a whole line is queued, so we mirror that: POLLIN only
 * when canon_count() shows a finalized line (or pending EOF).  In raw
 * mode any character satisfies VMIN==1 immediately.  Without this
 * mirror, ppoll() would falsely signal POLLIN on partial canonical
 * input, then read() would block — exactly the busy-loop the shell's
 * ppoll-then-read pattern is trying to avoid.
 */
bool n_tty_input_ready(tty_struct* tty)
{
    auto* d = static_cast<n_tty_data*>(tty->ldisc.data);
    if (!d) return false;
    const termios& t = tty->termios_data;
    if (t.c_lflag & ICANON)
        return canon_count(d) != 0 || d->eof_pending;
    int vmin = t.c_cc[VMIN];
    if (vmin == 0) vmin = 1;
    return buf_count(d) >= vmin;
}

static void n_tty_set_termios(tty_struct* /*tty*/, const termios* /*old*/)
{
    /* Nothing special needed for now */
}

static void n_tty_hangup(tty_struct* tty)
{
    n_tty_flush_buffer(tty);
    tty->read_wait.wake_all();
}

/* ================================================================== */
/*  N_TTY ops table                                                   */
/* ================================================================== */

const tty_ldisc_ops n_tty_ops = {
    .name           = "n_tty",
    .num            = 0,  /* N_TTY */
    .open           = n_tty_open,
    .close          = n_tty_close,
    .read           = n_tty_read,
    .write          = n_tty_write,
    .receive_buf    = n_tty_receive_buf,
    .ioctl          = n_tty_ioctl,
    .flush_buffer   = n_tty_flush_buffer,
    .chars_in_buffer = n_tty_chars_in_buffer,
    .set_termios    = n_tty_set_termios,
    .hangup         = n_tty_hangup,
};
