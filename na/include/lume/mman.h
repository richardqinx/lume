/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * POSIX Memory Management Constants
 * Reference: docs/specs/syscall.md §9
 */

/* mmap / mprotect protection flags */
inline constexpr int PROT_NONE    = 0x0;
inline constexpr int PROT_READ    = 0x1;
inline constexpr int PROT_WRITE   = 0x2;
inline constexpr int PROT_EXEC    = 0x4;

/* mmap flags */
inline constexpr int MAP_SHARED     = 0x01;
inline constexpr int MAP_PRIVATE    = 0x02;
inline constexpr int MAP_FIXED      = 0x10;
inline constexpr int MAP_ANONYMOUS  = 0x20;
