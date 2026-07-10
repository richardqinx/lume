/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * fs_struct.h — Per-task filesystem context (cwd, root)
 *
 * Modeled after Linux include/linux/fs_struct.h.
 * Reference: docs/vfs/05_fdtable.md
 */

#include <lume/types.h>
#include <lume/atomic.h>
#include <lume/file.h>          /* struct path */
#include <kernel/sync/spinlock.h>

/* ================================================================== */
/*  fs_struct                                                         */
/* ================================================================== */

struct fs_struct {
    lume::atomic<int32> count;      /* Reference count (CLONE_FS) */
    Spinlock            lock;
    int                 umask;      /* File creation mask */
    path                root;       /* Root directory */
    path                pwd;        /* Current working directory */
};

/* ================================================================== */
/*  API                                                               */
/* ================================================================== */

fs_struct*  alloc_fs_struct();
void        put_fs_struct(fs_struct* fs);
fs_struct*  copy_fs_struct(const fs_struct* old_fs);

void        set_fs_root(fs_struct* fs, const path* p);
void        set_fs_pwd(fs_struct* fs, const path* p);
