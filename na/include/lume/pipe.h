/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * pipe.h — Pipe data structure and API
 *
 * A pipe is a unidirectional byte stream backed by a fixed-size
 * circular buffer.  Two file structs (reader + writer) share a
 * single pipe_inode_info.
 */

#include <lume/types.h>
#include <lume/atomic.h>
#include <lume/waitqueue.h>
#include <kernel/sync/spinlock.h>

struct file;
struct files_struct;

/* ================================================================== */
/*  pipe_inode_info                                                    */
/* ================================================================== */

inline constexpr int PIPE_BUF_SIZE = 4096;

struct pipe_inode_info {
    char        buf[PIPE_BUF_SIZE];
    int         rd_pos;         /* Read position in circular buffer */
    int         wr_pos;         /* Write position in circular buffer */
    int         len;            /* Bytes currently in buffer */
    Spinlock    lock;
    WaitQueue   rd_wait;        /* Readers sleep here when empty */
    WaitQueue   wr_wait;        /* Writers sleep here when full */

    lume::atomic<int32> readers;  /* Number of open read ends */
    lume::atomic<int32> writers;  /* Number of open write ends */
    lume::atomic<int32> refcount; /* Total references */
};

/* ================================================================== */
/*  API                                                               */
/* ================================================================== */

/* Create a pipe, install read/write fds into the given files_struct.
 * Returns 0 on success, negative errno on failure. */
int do_pipe2(files_struct* files, int fds[2], int flags);

/* Allocate a fresh pipe_inode_info */
pipe_inode_info* alloc_pipe_info();
void free_pipe_info(pipe_inode_info* pipe);
