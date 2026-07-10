/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * POSIX waitpid / wait4 Constants
 * Reference: docs/specs/syscall.md §9
 */

/* waitpid options */
inline constexpr int WNOHANG    = 1;
inline constexpr int WUNTRACED  = 2;
inline constexpr int WCONTINUED = 8;
inline constexpr int WSTOPPED   = WUNTRACED;  /* POSIX alias */
inline constexpr int WEXITED    = 4;          /* POSIX */
inline constexpr int WNOWAIT    = 0x01000000; /* POSIX: peek, don't reap */

/* Exit status encoding (Linux-compatible) */
static inline int  WEXITSTATUS(int s) { return (s >> 8) & 0xFF; }
static inline bool WIFEXITED(int s)   { return (s & 0x7F) == 0; }
static inline bool WIFSIGNALED(int s) { return (s & 0x7F) != 0 && (s & 0x7F) != 0x7F; }
static inline int  WTERMSIG(int s)    { return s & 0x7F; }
static inline bool WIFSTOPPED(int s)  { return (s & 0xFF) == 0x7F; }
static inline int  WSTOPSIG(int s)    { return (s >> 8) & 0xFF; }
static inline bool WIFCONTINUED(int s){ return s == 0xFFFF; }

/* Encode exit code into wstatus (normal exit) */
static inline int W_EXITCODE(int code)    { return (code & 0xFF) << 8; }
static inline int W_STOPCODE(int sig)     { return ((sig & 0xFF) << 8) | 0x7F; }
static inline int W_CONTINUED()           { return 0xFFFF; }
