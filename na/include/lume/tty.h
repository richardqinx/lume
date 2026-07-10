/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * tty.h — TTY subsystem core structures
 *
 * tty_struct is the central object representing an open terminal.
 * It connects a hardware driver (tty_driver) with a line discipline
 * (tty_ldisc) to implement the full terminal abstraction.
 *
 * Architecture:
 *   user read/write → tty_core → tty_ldisc (n_tty) → tty_driver (uart/pty)
 *
 * Reference: Linux include/linux/tty.h, include/linux/tty_ldisc.h
 */

#include <lume/types.h>
#include <lume/tty_ioctl.h>
#include <lume/waitqueue.h>
#include <kernel/sync/spinlock.h>

struct tty_struct;
struct file;
struct file_operations;
struct inode;

/* ================================================================== */
/*  tty_driver — hardware/pseudo-terminal driver interface            */
/* ================================================================== */

struct tty_driver_ops {
    int  (*open)(tty_struct* tty);
    void (*close)(tty_struct* tty);
    int  (*write)(tty_struct* tty, const char* buf, int count);
    int  (*write_room)(tty_struct* tty);
    void (*put_char)(tty_struct* tty, char ch);
    void (*flush_chars)(tty_struct* tty);
    int  (*chars_in_buffer)(tty_struct* tty);
    void (*flush_buffer)(tty_struct* tty);
    int  (*ioctl)(tty_struct* tty, unsigned int cmd, uint64 arg);
    void (*throttle)(tty_struct* tty);
    void (*unthrottle)(tty_struct* tty);
    void (*hangup)(tty_struct* tty);
};

struct tty_driver {
    const char*             name;           /* "ttyS", "ttySIF", "pts" */
    int                     major;
    int                     minor_start;
    int                     num;            /* number of devices */
    const tty_driver_ops*   ops;
};

/* ================================================================== */
/*  tty_ldisc — line discipline interface                             */
/* ================================================================== */

struct tty_ldisc_ops {
    const char* name;
    int         num;            /* N_TTY = 0 */

    int  (*open)(tty_struct* tty);
    void (*close)(tty_struct* tty);
    int  (*read)(tty_struct* tty, file* fp, char* buf, uint64 count);
    int  (*write)(tty_struct* tty, file* fp, const char* buf, uint64 count);
    void (*receive_buf)(tty_struct* tty, const char* buf, int count);
    int  (*ioctl)(tty_struct* tty, unsigned int cmd, uint64 arg);
    void (*flush_buffer)(tty_struct* tty);
    int  (*chars_in_buffer)(tty_struct* tty);
    void (*set_termios)(tty_struct* tty, const termios* old);
    void (*hangup)(tty_struct* tty);
};

struct tty_ldisc {
    const tty_ldisc_ops*    ops;
    void*                   data;       /* ldisc private data (n_tty_data*) */
};

/* ================================================================== */
/*  tty_struct — central TTY object                                   */
/* ================================================================== */

inline constexpr int TTY_BUF_SIZE = 4096;

/* TTY flags */
inline constexpr uint32 TTY_THROTTLED   = (1 << 0);
inline constexpr uint32 TTY_IO_ERROR    = (1 << 1);
inline constexpr uint32 TTY_CLOSING     = (1 << 2);
inline constexpr uint32 TTY_HUPPING     = (1 << 3);

struct tty_struct {
    int                     index;          /* device index */
    const tty_driver*       driver;         /* hardware driver */
    tty_ldisc               ldisc;          /* current line discipline */
    tty_struct*             link;           /* PTY peer (master ↔ slave) */

    termios                 termios_data;   /* terminal settings */
    winsize                 ws;             /* window size */

    int32                   pgrp;           /* foreground process group */
    int32                   session;        /* controlling session */

    /* Output buffer (tty_core → driver) */
    char                    write_buf[TTY_BUF_SIZE];
    int                     write_cnt;

    /* Synchronization */
    WaitQueue               read_wait;
    WaitQueue               write_wait;
    Spinlock                lock;

    uint32                  flags;
    int                     open_count;

    /* Private driver data */
    void*                   driver_data;
};

/* ================================================================== */
/*  TTY core API                                                      */
/* ================================================================== */

/* Initialize the TTY subsystem (creates /dev/console TTY) */
void tty_init();

/* Allocate and initialize a new tty_struct */
tty_struct* tty_alloc(const tty_driver* driver, int index);

/* Open/close a TTY (called from chardev open/close) */
int  tty_open(tty_struct* tty);
void tty_close(tty_struct* tty);

/* Core I/O (called from file_operations) */
int64 tty_read(tty_struct* tty, file* fp, char* buf, uint64 count);
int64 tty_write(tty_struct* tty, file* fp, const char* buf, uint64 count);
long  tty_ioctl(tty_struct* tty, file* fp, unsigned int cmd, uint64 arg);

/* Called by hardware driver when bytes arrive */
void tty_receive_buf(tty_struct* tty, const char* buf, int count);

/* Signal helpers */
void tty_signal_pgrp(tty_struct* tty, int sig);

/* file_operations for TTY devices */
extern file_operations tty_fops;

/* Global console TTY */
extern tty_struct* g_console_tty;

/* ================================================================== */
/*  N_TTY line discipline                                             */
/* ================================================================== */

extern const tty_ldisc_ops n_tty_ops;

/* ================================================================== */
/*  UART TTY driver                                                   */
/* ================================================================== */

extern const tty_driver uart_tty_driver;

/* Initialize UART as a TTY driver (registers RX IRQ) */
void uart_tty_init(tty_struct* tty);
