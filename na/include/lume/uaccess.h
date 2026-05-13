/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * User-space memory access — safe copy routines.
 *
 * Phase 2: Software page-table validation.
 * Phase 3+: Exception Table (zero-cost happy path).
 *
 * Reference: docs/specs/syscall.md §8
 */

#include <lume/types.h>

/* Copy len bytes from user address to kernel buffer.
 * Returns 0 on success, -EFAULT if user address is invalid. */
int copy_from_user(void* kernel_dst, uint64 user_src, uint64 len);

/* Copy len bytes from kernel buffer to user address.
 * Returns 0 on success, -EFAULT if user address is invalid. */
int copy_to_user(uint64 user_dst, const void* kernel_src, uint64 len);

/* Copy NUL-terminated string from user space.
 * Returns string length (excluding NUL) or -EFAULT. */
int64 strncpy_from_user(char* kernel_dst, uint64 user_src, uint64 max_len);
