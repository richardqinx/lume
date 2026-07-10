/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * fd.cc — File descriptor table management
 */

#include <lume/fdtable.h>
#include <lume/file.h>
#include <lume/slab.h>
#include <lume/errno.h>

/* ================================================================== */
/*  Bitmap helpers                                                    */
/* ================================================================== */

static inline bool bit_test(const uint64* bmap, int bit) {
    return (bmap[bit / 64] >> (bit % 64)) & 1;
}
static inline void bit_set(uint64* bmap, int bit) {
    bmap[bit / 64] |= (1ULL << (bit % 64));
}
static inline void bit_clear(uint64* bmap, int bit) {
    bmap[bit / 64] &= ~(1ULL << (bit % 64));
}

/* ================================================================== */
/*  alloc_files_struct                                                */
/* ================================================================== */

files_struct* alloc_files_struct()
{
    auto* files = new files_struct{};
    if (!files) return nullptr;

    files->count.store(1);
    files->next_fd = 0;
    files->max_fds = NR_OPEN_DEFAULT;

    for (int i = 0; i < NR_OPEN_DEFAULT; i++)
        files->fd_array[i] = nullptr;

    int bmap_words = (NR_OPEN_DEFAULT + 63) / 64;
    for (int i = 0; i < bmap_words; i++) {
        files->close_on_exec_init[i] = 0;
        files->open_fds_init[i] = 0;
    }

    return files;
}

/* ================================================================== */
/*  put_files_struct — drop reference, free on last                   */
/* ================================================================== */

void put_files_struct(files_struct* files)
{
    if (!files) return;

    int old = files->count.fetch_sub(1);
    if (old > 1) return;

    /* Close all open fds */
    for (int i = 0; i < files->max_fds; i++) {
        if (files->fd_array[i]) {
            fput(files->fd_array[i]);
            files->fd_array[i] = nullptr;
        }
    }

    delete files;
}

/* ================================================================== */
/*  dup_fd — duplicate entire fd table (for fork)                     */
/* ================================================================== */

files_struct* dup_fd(files_struct* old_files)
{
    auto* new_files = alloc_files_struct();
    if (!new_files) return nullptr;

    LockGuard guard(old_files->file_lock);

    for (int i = 0; i < old_files->max_fds; i++) {
        file* fp = old_files->fd_array[i];
        if (fp) {
            get_file(fp);
            new_files->fd_array[i] = fp;
        }
    }

    /* Copy bitmaps */
    int bmap_words = (NR_OPEN_DEFAULT + 63) / 64;
    for (int i = 0; i < bmap_words; i++) {
        new_files->open_fds_init[i] = old_files->open_fds_init[i];
        new_files->close_on_exec_init[i] = old_files->close_on_exec_init[i];
    }

    new_files->next_fd = old_files->next_fd;

    return new_files;
}

/* ================================================================== */
/*  alloc_fd — find lowest free fd >= start                           */
/* ================================================================== */

int alloc_fd(files_struct* files, unsigned int start)
{
    LockGuard guard(files->file_lock);

    for (int fd = static_cast<int>(start); fd < files->max_fds; fd++) {
        if (!bit_test(files->open_fds_init, fd)) {
            bit_set(files->open_fds_init, fd);
            files->fd_array[fd] = nullptr;  /* placeholder, fd_install sets real file */
            if (fd >= files->next_fd)
                files->next_fd = fd + 1;
            return fd;
        }
    }

    return -EMFILE;
}

/* ================================================================== */
/*  fd_install — place a file* at a given fd                          */
/* ================================================================== */

void fd_install(files_struct* files, int fd, file* fp)
{
    LockGuard guard(files->file_lock);
    files->fd_array[fd] = fp;
}

/* ================================================================== */
/*  fcheck — look up file by fd (no refcount bump)                    */
/* ================================================================== */

file* fcheck(files_struct* files, int fd)
{
    if (fd < 0 || fd >= files->max_fds) return nullptr;
    return files->fd_array[fd];
}

/* ================================================================== */
/*  close_fd                                                          */
/* ================================================================== */

int close_fd(files_struct* files, int fd)
{
    file* fp;
    {
        LockGuard guard(files->file_lock);
        if (fd < 0 || fd >= files->max_fds) return -EBADF;

        fp = files->fd_array[fd];
        if (!fp) return -EBADF;

        files->fd_array[fd] = nullptr;
        bit_clear(files->open_fds_init, fd);
        bit_clear(files->close_on_exec_init, fd);
    }

    fput(fp);
    return 0;
}

/* ================================================================== */
/*  do_dup2 — duplicate oldfd to newfd                                */
/* ================================================================== */

int do_dup2(files_struct* files, int oldfd, int newfd, int flags)
{
    if (oldfd == newfd) return -EINVAL;

    file* existing = nullptr;
    {
        LockGuard guard(files->file_lock);

        if (oldfd < 0 || oldfd >= files->max_fds) return -EBADF;
        if (newfd < 0 || newfd >= files->max_fds) return -EBADF;

        file* old_fp = files->fd_array[oldfd];
        if (!old_fp) return -EBADF;

        existing = files->fd_array[newfd];

        get_file(old_fp);
        files->fd_array[newfd] = old_fp;
        bit_set(files->open_fds_init, newfd);

        if (flags & O_CLOEXEC)
            bit_set(files->close_on_exec_init, newfd);
        else
            bit_clear(files->close_on_exec_init, newfd);
    }

    if (existing)
        fput(existing);

    return newfd;
}

/* ================================================================== */
/*  do_close_on_exec — close all fds with CLOEXEC set                 */
/* ================================================================== */

void do_close_on_exec(files_struct* files)
{
    for (int fd = 0; fd < files->max_fds; fd++) {
        if (bit_test(files->close_on_exec_init, fd)) {
            close_fd(files, fd);
        }
    }
}
