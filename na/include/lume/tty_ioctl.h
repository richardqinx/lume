/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * tty_ioctl.h — Terminal I/O control constants and structures
 *
 * Linux-compatible termios, winsize, and TIOC* ioctl definitions.
 * Values match the RISC-V/generic Linux ABI.
 *
 * Reference: include/uapi/asm-generic/termbits.h,
 *            include/uapi/asm-generic/ioctls.h
 */

#include <lume/types.h>

/* ================================================================== */
/*  termios c_cc indices                                              */
/* ================================================================== */

inline constexpr int VINTR    = 0;
inline constexpr int VQUIT    = 1;
inline constexpr int VERASE   = 2;
inline constexpr int VKILL    = 3;
inline constexpr int VEOF     = 4;
inline constexpr int VTIME    = 5;
inline constexpr int VMIN     = 6;
inline constexpr int VSWTC    = 7;
inline constexpr int VSTART   = 8;
inline constexpr int VSTOP    = 9;
inline constexpr int VSUSP    = 10;
inline constexpr int VEOL     = 11;
inline constexpr int VREPRINT = 12;
inline constexpr int VDISCARD = 13;
inline constexpr int VWERASE  = 14;
inline constexpr int VLNEXT   = 15;
inline constexpr int VEOL2    = 16;
inline constexpr int NCCS     = 19;

/* ================================================================== */
/*  c_iflag — input mode flags                                        */
/* ================================================================== */

inline constexpr uint32 IGNBRK  = 0000001;
inline constexpr uint32 BRKINT  = 0000002;
inline constexpr uint32 IGNPAR  = 0000004;
inline constexpr uint32 PARMRK  = 0000010;
inline constexpr uint32 INPCK   = 0000020;
inline constexpr uint32 ISTRIP  = 0000040;
inline constexpr uint32 INLCR   = 0000100;
inline constexpr uint32 IGNCR   = 0000200;
inline constexpr uint32 ICRNL   = 0000400;
inline constexpr uint32 IUCLC   = 0001000;
inline constexpr uint32 IXON    = 0002000;
inline constexpr uint32 IXANY   = 0004000;
inline constexpr uint32 IXOFF   = 0010000;
inline constexpr uint32 IMAXBEL = 0020000;
inline constexpr uint32 IUTF8   = 0040000;

/* ================================================================== */
/*  c_oflag — output mode flags                                       */
/* ================================================================== */

inline constexpr uint32 OPOST   = 0000001;
inline constexpr uint32 OLCUC   = 0000002;
inline constexpr uint32 ONLCR   = 0000004;
inline constexpr uint32 OCRNL   = 0000010;
inline constexpr uint32 ONOCR   = 0000020;
inline constexpr uint32 ONLRET  = 0000040;
inline constexpr uint32 OFILL   = 0000100;
inline constexpr uint32 OFDEL   = 0000200;

/* ================================================================== */
/*  c_cflag — control mode flags                                      */
/* ================================================================== */

inline constexpr uint32 CSIZE   = 0000060;
inline constexpr uint32 CS5     = 0000000;
inline constexpr uint32 CS6     = 0000020;
inline constexpr uint32 CS7     = 0000040;
inline constexpr uint32 CS8     = 0000060;
inline constexpr uint32 CSTOPB  = 0000100;
inline constexpr uint32 CREAD   = 0000200;
inline constexpr uint32 PARENB  = 0000400;
inline constexpr uint32 PARODD  = 0001000;
inline constexpr uint32 HUPCL   = 0002000;
inline constexpr uint32 CLOCAL  = 0004000;

/* Baud rates (stored in c_cflag masked with CBAUD) */
inline constexpr uint32 CBAUD   = 0010017;
inline constexpr uint32 B0      = 0000000;
inline constexpr uint32 B9600   = 0000015;
inline constexpr uint32 B19200  = 0000016;
inline constexpr uint32 B38400  = 0000017;
inline constexpr uint32 B115200 = 0010002;

/* ================================================================== */
/*  c_lflag — local mode flags                                        */
/* ================================================================== */

inline constexpr uint32 ISIG    = 0000001;
inline constexpr uint32 ICANON  = 0000002;
inline constexpr uint32 XCASE   = 0000004;
inline constexpr uint32 LECHO   = 0000010;   /* Named LECHO to avoid macro conflict */
inline constexpr uint32 ECHOE   = 0000020;
inline constexpr uint32 ECHOK   = 0000040;
inline constexpr uint32 ECHONL  = 0000100;
inline constexpr uint32 NOFLSH  = 0000200;
inline constexpr uint32 TOSTOP  = 0000400;
inline constexpr uint32 ECHOCTL = 0001000;
inline constexpr uint32 ECHOPRT = 0002000;
inline constexpr uint32 ECHOKE  = 0004000;
inline constexpr uint32 IEXTEN  = 0100000;

/* Linux uses ECHO = 0x0008, we use LECHO to avoid reserved-name issues.
 * Provide the standard name as well for ioctl compatibility. */
inline constexpr uint32 ECHO    = LECHO;

/* ================================================================== */
/*  termios structure                                                 */
/* ================================================================== */

struct termios {
    uint32 c_iflag;             /* input mode flags */
    uint32 c_oflag;             /* output mode flags */
    uint32 c_cflag;             /* control mode flags */
    uint32 c_lflag;             /* local mode flags */
    uint8  c_line;              /* line discipline */
    uint8  c_cc[NCCS];          /* control characters */
};

/* ================================================================== */
/*  winsize structure                                                 */
/* ================================================================== */

struct winsize {
    uint16 ws_row;
    uint16 ws_col;
    uint16 ws_xpixel;
    uint16 ws_ypixel;
};

/* ================================================================== */
/*  ioctl command numbers (Linux asm-generic/ioctls.h)                */
/* ================================================================== */

inline constexpr uint32 TCGETS      = 0x5401;
inline constexpr uint32 TCSETS      = 0x5402;
inline constexpr uint32 TCSETSW     = 0x5403;
inline constexpr uint32 TCSETSF     = 0x5404;
inline constexpr uint32 TCGETA      = 0x5405;
inline constexpr uint32 TCSETA      = 0x5406;
inline constexpr uint32 TCSETAW     = 0x5407;
inline constexpr uint32 TCSETAF     = 0x5408;
inline constexpr uint32 TCSBRK      = 0x5409;
inline constexpr uint32 TCXONC      = 0x540A;
inline constexpr uint32 TCFLSH      = 0x540B;
inline constexpr uint32 TIOCEXCL    = 0x540C;
inline constexpr uint32 TIOCNXCL    = 0x540D;
inline constexpr uint32 TIOCSCTTY   = 0x540E;
inline constexpr uint32 TIOCGPGRP   = 0x540F;
inline constexpr uint32 TIOCSPGRP   = 0x5410;
inline constexpr uint32 TIOCOUTQ    = 0x5411;
inline constexpr uint32 TIOCSTI     = 0x5412;
inline constexpr uint32 TIOCGWINSZ  = 0x5413;
inline constexpr uint32 TIOCSWINSZ  = 0x5414;
inline constexpr uint32 TIOCMGET    = 0x5415;
inline constexpr uint32 TIOCMSET    = 0x5418;
inline constexpr uint32 FIONREAD    = 0x541B;
inline constexpr uint32 TIOCNOTTY   = 0x5422;
inline constexpr uint32 TIOCGPTLCK  = 0x80045430;
inline constexpr uint32 TIOCSPTLCK  = 0x40045431;

/* Default termios for a new TTY */
inline void tty_default_termios(termios* t)
{
    t->c_iflag = ICRNL | IXON | IUTF8;
    t->c_oflag = OPOST | ONLCR;
    t->c_cflag = B115200 | CS8 | CREAD | HUPCL | CLOCAL;
    t->c_lflag = ISIG | ICANON | ECHO | ECHOE | ECHOK | ECHOCTL | ECHOKE | IEXTEN;
    t->c_line  = 0;  /* N_TTY */

    for (int i = 0; i < NCCS; i++)
        t->c_cc[i] = 0;

    t->c_cc[VINTR]    = 003;   /* Ctrl+C */
    t->c_cc[VQUIT]    = 034;   /* Ctrl+\ */
    t->c_cc[VERASE]   = 0177;  /* DEL */
    t->c_cc[VKILL]    = 025;   /* Ctrl+U */
    t->c_cc[VEOF]     = 004;   /* Ctrl+D */
    t->c_cc[VSTART]   = 021;   /* Ctrl+Q */
    t->c_cc[VSTOP]    = 023;   /* Ctrl+S */
    t->c_cc[VSUSP]    = 032;   /* Ctrl+Z */
    t->c_cc[VREPRINT] = 022;   /* Ctrl+R */
    t->c_cc[VWERASE]  = 027;   /* Ctrl+W */
    t->c_cc[VLNEXT]   = 026;   /* Ctrl+V */
    t->c_cc[VEOL]     = 0;
    t->c_cc[VEOL2]    = 0;
    t->c_cc[VMIN]     = 1;
    t->c_cc[VTIME]    = 0;
}
