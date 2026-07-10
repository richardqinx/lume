/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * ramfs/file.cc — RamFS file operations (read/write via in-memory pages)
 *
 * Phase 1: simple flat buffer per-inode via i_private.
 * Will migrate to page_cache integration later.
 */

#include <lume/fs.h>
#include <lume/file.h>
#include <lume/dcache.h>
#include <lume/slab.h>
#include <lume/errno.h>
#include <lume/fs_types.h>

/*
 * Simplest possible in-memory file storage:
 * i_private points to a dynamically grown buffer.
 */
struct ramfs_file_data {
    char*   buf;
    uint64  capacity;
};

static ramfs_file_data* get_or_create_data(inode* ip)
{
    if (!ip->i_private) {
        auto* data = new ramfs_file_data{};
        data->buf = nullptr;
        data->capacity = 0;
        ip->i_private = data;
    }
    return static_cast<ramfs_file_data*>(ip->i_private);
}

static int ensure_capacity(ramfs_file_data* data, uint64 needed)
{
    if (needed <= data->capacity) return 0;

    /* Round up to page size */
    uint64 new_cap = (needed + 4095) & ~4095ULL;
    char* new_buf = new char[new_cap];
    if (!new_buf) return -ENOMEM;

    /* Copy old data */
    if (data->buf && data->capacity > 0) {
        for (uint64 i = 0; i < data->capacity; i++)
            new_buf[i] = data->buf[i];
    }
    /* Zero new region */
    for (uint64 i = data->capacity; i < new_cap; i++)
        new_buf[i] = 0;

    delete[] data->buf;
    data->buf = new_buf;
    data->capacity = new_cap;
    return 0;
}

/* ================================================================== */
/*  ramfs_read                                                        */
/* ================================================================== */

static int64 ramfs_read(file* fp, char* buf, uint64 count, int64* pos)
{
    inode* ip = file_inode(fp);
    int64 offset = *pos;

    if (offset < 0) return -EINVAL;
    if (offset >= ip->i_size) return 0;

    int64 avail = ip->i_size - offset;
    if (static_cast<int64>(count) > avail)
        count = static_cast<uint64>(avail);

    auto* data = static_cast<ramfs_file_data*>(ip->i_private);
    if (!data || !data->buf) return 0;

    /* Copy to user buffer.
     * TODO: use copy_to_user when called from syscall context */
    for (uint64 i = 0; i < count; i++)
        buf[i] = data->buf[offset + i];

    *pos += count;
    return static_cast<int64>(count);
}

/* ================================================================== */
/*  ramfs_write                                                       */
/* ================================================================== */

static int64 ramfs_write(file* fp, const char* buf, uint64 count, int64* pos)
{
    inode* ip = file_inode(fp);
    int64 offset = *pos;

    if (fp->f_flags & O_APPEND)
        offset = ip->i_size;

    if (offset < 0) return -EINVAL;

    auto* data = get_or_create_data(ip);
    uint64 end = static_cast<uint64>(offset) + count;

    int err = ensure_capacity(data, end);
    if (err) return err;

    /* Copy from user buffer */
    for (uint64 i = 0; i < count; i++)
        data->buf[offset + i] = buf[i];

    if (static_cast<int64>(end) > ip->i_size)
        ip->i_size = end;

    *pos = end;
    mark_inode_dirty(ip);
    return static_cast<int64>(count);
}

/* ================================================================== */
/*  ramfs_dir_iterate — getdents64                                    */
/* ================================================================== */

static int ramfs_dir_iterate(file* fp, dir_context* ctx)
{
    dentry* dir_de = file_dentry(fp);
    inode* dir_ip = file_inode(fp);
    int64 pos = ctx->pos;
    int count = 0;

    /* pos 0: emit "." */
    if (pos == 0) {
        if (!ctx->actor(ctx, ".", 1, pos, dir_ip->i_ino, DT_DIR))
            return 0;
        ctx->pos = 1;
        pos = 1;
        count++;
    }

    /* pos 1: emit ".." */
    if (pos == 1) {
        uint64 parent_ino = dir_de->d_parent->d_inode
            ? dir_de->d_parent->d_inode->i_ino : dir_ip->i_ino;
        if (!ctx->actor(ctx, "..", 2, pos, parent_ino, DT_DIR))
            return 0;
        ctx->pos = 2;
        pos = 2;
        count++;
    }

    /* pos >= 2: iterate children */
    int64 child_idx = 2;
    list_node* node;
    list_for_each(node, &dir_de->d_children) {
        dentry* child = list_entry(node, dentry, d_child);

        if (!child->d_inode)
            continue;  /* skip negative dentries */

        if (child_idx >= pos) {
            uint8 d_type = DT_UNKNOWN;
            if (S_ISDIR(child->d_inode->i_mode)) d_type = DT_DIR;
            else if (S_ISREG(child->d_inode->i_mode)) d_type = DT_REG;
            else if (S_ISCHR(child->d_inode->i_mode)) d_type = DT_CHR;
            else if (S_ISBLK(child->d_inode->i_mode)) d_type = DT_BLK;
            else if (S_ISLNK(child->d_inode->i_mode)) d_type = DT_LNK;
            else if (S_ISFIFO(child->d_inode->i_mode)) d_type = DT_FIFO;

            if (!ctx->actor(ctx, child->d_name.name,
                            static_cast<int>(child->d_name.len),
                            child_idx, child->d_inode->i_ino, d_type))
                return 0;

            ctx->pos = child_idx + 1;
            count++;
        }
        child_idx++;
    }

    return count;
}

extern file_operations ramfs_file_operations;
extern file_operations ramfs_dir_operations;

file_operations ramfs_file_operations;
file_operations ramfs_dir_operations;

void ramfs_file_ops_init()
{
    ramfs_file_operations.llseek         = nullptr;
    ramfs_file_operations.read           = ramfs_read;
    ramfs_file_operations.write          = ramfs_write;
    ramfs_file_operations.iterate_shared = nullptr;
    ramfs_file_operations.poll           = nullptr;
    ramfs_file_operations.unlocked_ioctl = nullptr;
    ramfs_file_operations.mmap           = nullptr;
    ramfs_file_operations.open           = nullptr;
    ramfs_file_operations.flush          = nullptr;
    ramfs_file_operations.release        = nullptr;
    ramfs_file_operations.fsync          = nullptr;

    ramfs_dir_operations.llseek          = nullptr;
    ramfs_dir_operations.read            = nullptr;
    ramfs_dir_operations.write           = nullptr;
    ramfs_dir_operations.iterate_shared  = ramfs_dir_iterate;
    ramfs_dir_operations.poll            = nullptr;
    ramfs_dir_operations.unlocked_ioctl  = nullptr;
    ramfs_dir_operations.mmap            = nullptr;
    ramfs_dir_operations.open            = nullptr;
    ramfs_dir_operations.flush           = nullptr;
    ramfs_dir_operations.release         = nullptr;
    ramfs_dir_operations.fsync           = nullptr;
}
