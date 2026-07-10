/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * PID Allocator — Bitmap-based O(1) block search
 * Reference: docs/specs/task.md §3.2
 */

#include <lume/types.h>
#include <kernel/sync/spinlock.h>

inline constexpr int32 kMaxPid = 32768;

class PidAllocator {
public:
    void init();
    int32 alloc();
    void free(int32 pid);

private:
    static constexpr int32 kBitmapWords = kMaxPid / 64;
    Spinlock lock_;
    uint64 bitmap_[kBitmapWords];
    int32 next_hint_ = 2;
};

extern PidAllocator g_pid_alloc;
