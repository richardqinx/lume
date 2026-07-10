/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * fdtable.h — Per-task file descriptor table
 *
 * Modeled after Linux include/linux/fdtable.h.
 * Reference: docs/vfs/05_fdtable.md
 */

#include <lume/types.h>
#include <lume/atomic.h>
#include <kernel/sync/spinlock.h>

struct file;

/* ================================================================== */
/*  files_struct — per-task open file table                           */
/* ================================================================== */

inline constexpr int NR_OPEN_DEFAULT = 256;

struct files_struct {
    lume::atomic<int32> count;          /* Reference count (CLONE_FILES) */
    Spinlock            file_lock;

    int                 next_fd;        /* Hint for next free fd */
    int                 max_fds;        /* Current max (= NR_OPEN_DEFAULT) */
    file*               fd_array[NR_OPEN_DEFAULT];
    uint64              close_on_exec_init[(NR_OPEN_DEFAULT + 63) / 64];
    uint64              open_fds_init[(NR_OPEN_DEFAULT + 63) / 64];
};

/* ================================================================== */
/*  API                                                               */
/* ================================================================== */

files_struct*   alloc_files_struct();
void            put_files_struct(files_struct* files);
files_struct*   dup_fd(files_struct* old_files);

int             alloc_fd(files_struct* files, unsigned int start);
void            fd_install(files_struct* files, int fd, file* fp);
file*           fcheck(files_struct* files, int fd);
int             close_fd(files_struct* files, int fd);
int             do_dup2(files_struct* files, int oldfd, int newfd, int flags);
void            do_close_on_exec(files_struct* files);
