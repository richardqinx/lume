/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * pipe.cc — Pipe implementation
 *
 * Implements unidirectional byte-stream pipes with blocking I/O.
 * Each pipe has a 4KB circular buffer.  Reads block when empty,
 * writes block when full (unless O_NONBLOCK).
 *
 * When all writers close, read returns 0 (EOF).
 * When all readers close, write returns -EPIPE.
 */

#include <lume/pipe.h>
#include <lume/file.h>
#include <lume/fdtable.h>
#include <lume/errno.h>
#include <lume/slab.h>
#include <lume/fs_types.h>
#include <lume/klog.h>
#include <lume/sched.h>

/* ================================================================== */
/*  pipe_inode_info lifecycle                                          */
/* ================================================================== */

pipe_inode_info* alloc_pipe_info()
{
    auto* pi = new pipe_inode_info{};
    if (!pi) return nullptr;

    pi->rd_pos = 0;
    pi->wr_pos = 0;
    pi->len = 0;
    pi->rd_wait.init("pipe_rd");
    pi->wr_wait.init("pipe_wr");
    pi->readers.store(0);
    pi->writers.store(0);
    pi->refcount.store(1);
    return pi;
}

void free_pipe_info(pipe_inode_info* pipe)
{
    delete pipe;
}

static void pipe_get(pipe_inode_info* pi)
{
    pi->refcount.fetch_add(1);
}

static void pipe_put(pipe_inode_info* pi)
{
    if (pi->refcount.fetch_sub(1) == 1) {
        free_pipe_info(pi);
    }
}

/* ================================================================== */
/*  pipe_read                                                         */
/* ================================================================== */

static int64 pipe_read(file* fp, char* buf, uint64 count, int64* /*pos*/)
{
    pipe_inode_info* pi = static_cast<pipe_inode_info*>(fp->private_data);
    if (!pi) return -EBADF;

    while (true) {
        pi->lock.acquire();

        if (pi->len > 0) {
            /* Data available — copy out */
            int64 to_read = static_cast<int64>(count);
            if (to_read > pi->len) to_read = pi->len;

            for (int64 i = 0; i < to_read; i++) {
                buf[i] = pi->buf[pi->rd_pos];
                pi->rd_pos = (pi->rd_pos + 1) % PIPE_BUF_SIZE;
            }
            pi->len -= static_cast<int>(to_read);

            pi->lock.release();

            /* Wake any blocked writers */
            pi->wr_wait.wake_all();
            return to_read;
        }

        /* Buffer empty */
        if (pi->writers.load() == 0) {
            /* No writers left — EOF */
            pi->lock.release();
            return 0;
        }

        if (fp->f_flags & O_NONBLOCK) {
            pi->lock.release();
            return -EAGAIN;
        }

        pi->lock.release();

        /* Sleep until data or writer closes */
        pi->rd_wait.sleep();
    }
}

/* ================================================================== */
/*  pipe_write                                                        */
/* ================================================================== */

static int64 pipe_write(file* fp, const char* buf, uint64 count, int64* /*pos*/)
{
    pipe_inode_info* pi = static_cast<pipe_inode_info*>(fp->private_data);
    if (!pi) return -EBADF;

    if (pi->readers.load() == 0) {
        return -EPIPE;  /* Broken pipe */
    }

    int64 written = 0;

    while (static_cast<uint64>(written) < count) {
        pi->lock.acquire();

        if (pi->len < PIPE_BUF_SIZE) {
            /* Space available — copy in */
            int avail = PIPE_BUF_SIZE - pi->len;
            int64 remaining = static_cast<int64>(count) - written;
            int to_write = avail < static_cast<int>(remaining)
                               ? avail
                               : static_cast<int>(remaining);

            for (int i = 0; i < to_write; i++) {
                pi->buf[pi->wr_pos] = buf[written + i];
                pi->wr_pos = (pi->wr_pos + 1) % PIPE_BUF_SIZE;
            }
            pi->len += to_write;
            written += to_write;

            pi->lock.release();

            /* Wake any blocked readers */
            pi->rd_wait.wake_all();
            continue;
        }

        /* Buffer full */
        if (pi->readers.load() == 0) {
            pi->lock.release();
            return written > 0 ? written : -EPIPE;
        }

        if (fp->f_flags & O_NONBLOCK) {
            pi->lock.release();
            return written > 0 ? written : -EAGAIN;
        }

        pi->lock.release();

        /* Sleep until space or reader closes */
        pi->wr_wait.sleep();
    }

    return written;
}

/* ================================================================== */
/*  pipe_release — called on last fput of a pipe fd                   */
/* ================================================================== */

static int pipe_read_release(inode* /*ip*/, file* fp)
{
    pipe_inode_info* pi = static_cast<pipe_inode_info*>(fp->private_data);
    if (pi) {
        pi->readers.fetch_sub(1);
        /* Wake writers so they see readers==0 and get EPIPE */
        pi->wr_wait.wake_all();
        pipe_put(pi);
    }
    return 0;
}

static int pipe_write_release(inode* /*ip*/, file* fp)
{
    pipe_inode_info* pi = static_cast<pipe_inode_info*>(fp->private_data);
    if (pi) {
        pi->writers.fetch_sub(1);
        /* Wake readers so they see writers==0 and get EOF */
        pi->rd_wait.wake_all();
        pipe_put(pi);
    }
    return 0;
}

/* ================================================================== */
/*  file_operations tables                                            */
/* ================================================================== */

static file_operations pipe_read_fops;
static file_operations pipe_write_fops;
static bool pipe_fops_initialized = false;

static void pipe_fops_init()
{
    if (pipe_fops_initialized) return;

    pipe_read_fops = {};
    pipe_read_fops.read    = pipe_read;
    pipe_read_fops.release = pipe_read_release;

    pipe_write_fops = {};
    pipe_write_fops.write   = pipe_write;
    pipe_write_fops.release = pipe_write_release;

    pipe_fops_initialized = true;
}

/* ================================================================== */
/*  do_pipe2 — create a pipe, install two fds                         */
/* ================================================================== */

int do_pipe2(files_struct* files, int fds[2], int flags)
{
    pipe_fops_init();

    pipe_inode_info* pi = alloc_pipe_info();
    if (!pi) return -ENOMEM;

    /* Create read-end file */
    file* rd_fp = alloc_empty_file(O_RDONLY | (flags & O_NONBLOCK));
    if (!rd_fp) {
        free_pipe_info(pi);
        return -ENFILE;
    }
    rd_fp->f_op = &pipe_read_fops;
    rd_fp->private_data = pi;

    /* Create write-end file */
    file* wr_fp = alloc_empty_file(O_WRONLY | (flags & O_NONBLOCK));
    if (!wr_fp) {
        fput(rd_fp);
        free_pipe_info(pi);
        return -ENFILE;
    }
    wr_fp->f_op = &pipe_write_fops;
    wr_fp->private_data = pi;

    /* Bump pipe refcount for the two files */
    pipe_get(pi);  /* wr_fp gets second ref */
    pi->readers.store(1);
    pi->writers.store(1);

    /* Allocate fds */
    int rd_fd = alloc_fd(files, 0);
    if (rd_fd < 0) {
        fput(rd_fp);
        fput(wr_fp);
        return rd_fd;
    }

    int wr_fd = alloc_fd(files, 0);
    if (wr_fd < 0) {
        close_fd(files, rd_fd);
        fput(wr_fp);
        return wr_fd;
    }

    fd_install(files, rd_fd, rd_fp);
    fd_install(files, wr_fd, wr_fp);

    fds[0] = rd_fd;
    fds[1] = wr_fd;

    return 0;
}
