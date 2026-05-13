/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * PID Allocator — Bitmap-based O(1) block search
 * Reference: docs/specs/task.md §3.2
 */

#include <lume/pid.h>

void PidAllocator::init()
{
    for (int i = 0; i < kBitmapWords; i++)
        bitmap_[i] = 0;
    next_hint_ = 2;
    bitmap_[0] |= 0x3ULL; /* Reserve PID 0 (idle) and 1 (init) */
}

int32 PidAllocator::alloc()
{
    LockGuard guard(lock_);

    int32 word_start = next_hint_ / 64;

    for (int32 passes = 0; passes < kBitmapWords; passes++) {
        int32 w = (word_start + passes) % kBitmapWords;
        uint64 free_bits = ~bitmap_[w];
        if (free_bits == 0)
            continue;

        int bit = 0;
        uint64 v = free_bits;
        while ((v & 1ULL) == 0) { v >>= 1; bit++; }
        int32 pid = w * 64 + bit;

        if (pid >= kMaxPid)
            continue;

        bitmap_[w] |= (1ULL << bit);
        next_hint_ = pid + 1;
        if (next_hint_ >= kMaxPid)
            next_hint_ = 2;

        return pid;
    }

    return -1;
}

void PidAllocator::free(int32 pid)
{
    if (pid < 0 || pid >= kMaxPid)
        return;

    LockGuard guard(lock_);
    int32 w = pid / 64;
    int32 bit = pid % 64;
    bitmap_[w] &= ~(1ULL << bit);
}

PidAllocator g_pid_alloc;
