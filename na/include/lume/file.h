/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * file.h — Open file description + file_operations + path + vfsmount
 *
 * Modeled after Linux include/linux/fs.h struct file / file_operations.
 * Reference: docs/vfs/04_file.md
 */

#include <lume/types.h>
#include <lume/atomic.h>
#include <lume/fs_types.h>
#include <kernel/sync/spinlock.h>

struct inode;
struct dentry;
struct super_block;
struct address_space;
struct dir_context;
struct VmAreaStruct;
struct kstat;

/* ================================================================== */
/*  vfsmount (public part)                                            */
/* ================================================================== */

struct vfsmount {
    dentry*         mnt_root;
    super_block*    mnt_sb;
    int             mnt_flags;
};

vfsmount* mntget(vfsmount* mnt);
void      mntput(vfsmount* mnt);

/* ================================================================== */
/*  path                                                              */
/* ================================================================== */

struct path {
    vfsmount*   mnt;
    dentry*     de;     /* Linux calls this 'dentry' but that conflicts in C++ */
};

void path_get(const path* p);
void path_put(const path* p);

/* ================================================================== */
/*  file                                                              */
/* ================================================================== */

struct file_operations;

struct file {
    Spinlock                    f_lock;
    uint32                      f_mode;         /* FMODE_* */
    const file_operations*      f_op;
    address_space*              f_mapping;
    void*                       private_data;
    inode*                      f_inode;
    unsigned int                f_flags;        /* O_* */

    path                        f_path;

    int64                       f_pos;
    lume::atomic<int32>         f_count;
};

/* ================================================================== */
/*  Accessors                                                         */
/* ================================================================== */

inline inode* file_inode(const file* f)   { return f->f_inode; }
inline dentry* file_dentry(const file* f) { return f->f_path.de; }

file* get_file(file* f);
file* alloc_empty_file(int flags);
void  fput(file* fp);

/* ================================================================== */
/*  dir_context (for iterate_shared / getdents64)                     */
/* ================================================================== */

struct dir_context;
using filldir_t = bool (*)(dir_context* ctx, const char* name, int namelen,
                           int64 offset, uint64 ino, unsigned int d_type);

struct dir_context {
    filldir_t   actor;
    int64       pos;
};

/* ================================================================== */
/*  file_operations                                                   */
/* ================================================================== */

struct file_operations {
    int64   (*llseek)(file* fp, int64 offset, int whence);
    int64   (*read)(file* fp, char* buf, uint64 count, int64* pos);
    int64   (*write)(file* fp, const char* buf, uint64 count, int64* pos);
    int     (*iterate_shared)(file* fp, dir_context* ctx);
    uint32  (*poll)(file* fp, void* pt);
    long    (*unlocked_ioctl)(file* fp, unsigned int cmd, uint64 arg);
    int     (*mmap)(file* fp, VmAreaStruct* vma);
    int     (*open)(inode* ip, file* fp);
    int     (*flush)(file* fp);
    int     (*release)(inode* ip, file* fp);
    int     (*fsync)(file* fp, int64 start, int64 end, int datasync);
};

/* ================================================================== */
/*  VFS read/write/seek                                               */
/* ================================================================== */

int64 vfs_read(file* fp, char* buf, uint64 count, int64* pos);
int64 vfs_write(file* fp, const char* buf, uint64 count, int64* pos);
int64 vfs_llseek(file* fp, int64 offset, int whence);
int   vfs_fstat(file* fp, kstat* stat);

/* Generic helpers for simple fs */
int64 generic_file_llseek(file* fp, int64 offset, int whence);

/* ================================================================== */
/*  path helpers                                                      */
/* ================================================================== */

inline bool path_equal(const path* a, const path* b) {
    return a->mnt == b->mnt && a->de == b->de;
}
