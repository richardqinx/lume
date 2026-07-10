/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Linux-compatible clone(2) flags.
 *
 * Only the flags relevant to current and near-future use are defined.
 * Reference: include/uapi/linux/sched.h
 */

#include <lume/types.h>

/* Signal mask stored in low byte of clone flags */
inline constexpr uint64 CSIGNAL = 0x000000ffULL;

/* Sharing flags */
inline constexpr uint64 CLONE_VM             = 0x00000100ULL; // Share address space
inline constexpr uint64 CLONE_FS             = 0x00000200ULL; // Share fs info
inline constexpr uint64 CLONE_FILES          = 0x00000400ULL; // Share file descriptors
inline constexpr uint64 CLONE_SIGHAND        = 0x00000800ULL; // Share signal handlers
inline constexpr uint64 CLONE_PIDFD          = 0x00001000ULL; // pidfd
inline constexpr uint64 CLONE_PTRACE         = 0x00002000ULL; // Trace child
inline constexpr uint64 CLONE_VFORK          = 0x00004000ULL; // Parent blocks until child exits/execs
inline constexpr uint64 CLONE_PARENT         = 0x00008000ULL; // Same parent as cloner
inline constexpr uint64 CLONE_THREAD         = 0x00010000ULL; // Same thread group
inline constexpr uint64 CLONE_NEWNS          = 0x00020000ULL; // New mount namespace
inline constexpr uint64 CLONE_SYSVSEM        = 0x00040000ULL; // Share SysV semaphore undo
inline constexpr uint64 CLONE_SETTLS         = 0x00080000ULL; // Set TLS
inline constexpr uint64 CLONE_PARENT_SETTID  = 0x00100000ULL; // Write TID to parent
inline constexpr uint64 CLONE_CHILD_CLEARTID = 0x00200000ULL; // Clear TID on child exit
inline constexpr uint64 CLONE_DETACHED       = 0x00400000ULL; // Unused, historical
inline constexpr uint64 CLONE_CHILD_SETTID   = 0x01000000ULL; // Write TID to child
