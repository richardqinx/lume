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

/* Exit status encoding (Linux-compatible) */
static inline int WEXITSTATUS(int s) { return (s >> 8) & 0xFF; }
static inline bool WIFEXITED(int s)  { return (s & 0x7F) == 0; }
static inline bool WIFSIGNALED(int s){ return (s & 0x7F) != 0 && (s & 0x7F) != 0x7F; }
static inline int WTERMSIG(int s)    { return s & 0x7F; }

/* Encode exit code into wstatus (normal exit) */
static inline int W_EXITCODE(int code) { return (code & 0xFF) << 8; }
