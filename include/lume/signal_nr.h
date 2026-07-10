/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Linux-compatible signal numbers and related ABI constants.
 *
 * This mirrors the common Linux UAPI numbering used by asm-generic/signal.h.
 * Keep the values stable so user-space binaries see the same numbers.
 */

inline constexpr int _NSIG       = 64;
inline constexpr int _NSIG_BPW   = sizeof(unsigned long) * 8;
inline constexpr int _NSIG_WORDS = _NSIG / _NSIG_BPW;

inline constexpr int SIGHUP    = 1;
inline constexpr int SIGINT    = 2;
inline constexpr int SIGQUIT   = 3;
inline constexpr int SIGILL    = 4;
inline constexpr int SIGTRAP   = 5;
inline constexpr int SIGABRT   = 6;
inline constexpr int SIGIOT    = SIGABRT;
inline constexpr int SIGBUS    = 7;
inline constexpr int SIGFPE    = 8;
inline constexpr int SIGKILL   = 9;
inline constexpr int SIGUSR1   = 10;
inline constexpr int SIGSEGV   = 11;
inline constexpr int SIGUSR2   = 12;
inline constexpr int SIGPIPE   = 13;
inline constexpr int SIGALRM   = 14;
inline constexpr int SIGTERM   = 15;
inline constexpr int SIGSTKFLT = 16;
inline constexpr int SIGCHLD   = 17;
inline constexpr int SIGCONT   = 18;
inline constexpr int SIGSTOP   = 19;
inline constexpr int SIGTSTP   = 20;
inline constexpr int SIGTTIN   = 21;
inline constexpr int SIGTTOU   = 22;
inline constexpr int SIGURG    = 23;
inline constexpr int SIGXCPU   = 24;
inline constexpr int SIGXFSZ   = 25;
inline constexpr int SIGVTALRM = 26;
inline constexpr int SIGPROF   = 27;
inline constexpr int SIGWINCH  = 28;
inline constexpr int SIGIO     = 29;
inline constexpr int SIGPOLL   = SIGIO;
inline constexpr int SIGPWR    = 30;
inline constexpr int SIGSYS    = 31;
inline constexpr int SIGUNUSED = 31;

/* Real-time signals start here in Linux UAPI. */
inline constexpr int SIGRTMIN = 32;
inline constexpr int SIGRTMAX = _NSIG;
