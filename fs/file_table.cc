/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * file_table.cc — Open file allocation and reference counting
 */

#include <lume/file.h>
#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/slab.h>
#include <lume/errno.h>

/* ================================================================== */
/*  alloc_empty_file                                                  */
/* ================================================================== */

file* alloc_empty_file(int flags)
{
    auto* fp = new file{};
    if (!fp) return nullptr;

    fp->f_count.store(1);
    fp->f_flags = flags;
    fp->f_mode = 0;
    fp->f_op = nullptr;
    fp->f_mapping = nullptr;
    fp->f_inode = nullptr;
    fp->f_pos = 0;
    fp->private_data = nullptr;
    fp->f_path.mnt = nullptr;
    fp->f_path.de = nullptr;

    /* Derive f_mode from O_* flags */
    int acc = flags & O_ACCMODE;
    if (acc == O_RDONLY)
        fp->f_mode = FMODE_READ | FMODE_CAN_READ;
    else if (acc == O_WRONLY)
        fp->f_mode = FMODE_WRITE | FMODE_CAN_WRITE;
    else if (acc == O_RDWR)
        fp->f_mode = FMODE_READ | FMODE_WRITE | FMODE_CAN_READ | FMODE_CAN_WRITE;

    fp->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;

    return fp;
}

/* ================================================================== */
/*  get_file / fput                                                   */
/* ================================================================== */

file* get_file(file* f)
{
    f->f_count.fetch_add(1);
    return f;
}

void fput(file* fp)
{
    if (!fp) return;

    int old = fp->f_count.fetch_sub(1);
    if (old > 1) return;

    /* Last reference — release */
    if (fp->f_op && fp->f_op->release)
        fp->f_op->release(fp->f_inode, fp);

    if (fp->f_path.de)
        dput(fp->f_path.de);

    /* Future: mntput(fp->f_path.mnt) */

    delete fp;
}

/* ================================================================== */
/*  vfs_read / vfs_write / vfs_llseek / vfs_fstat                     */
/* ================================================================== */

int64 vfs_read(file* fp, char* buf, uint64 count, int64* pos)
{
    if (!(fp->f_mode & FMODE_CAN_READ))
        return -EBADF;
    if (!fp->f_op || !fp->f_op->read)
        return -EINVAL;

    return fp->f_op->read(fp, buf, count, pos);
}

int64 vfs_write(file* fp, const char* buf, uint64 count, int64* pos)
{
    if (!(fp->f_mode & FMODE_CAN_WRITE))
        return -EBADF;
    if (!fp->f_op || !fp->f_op->write)
        return -EINVAL;

    return fp->f_op->write(fp, buf, count, pos);
}

int64 vfs_llseek(file* fp, int64 offset, int whence)
{
    if (fp->f_op && fp->f_op->llseek)
        return fp->f_op->llseek(fp, offset, whence);
    return generic_file_llseek(fp, offset, whence);
}

int64 generic_file_llseek(file* fp, int64 offset, int whence)
{
    int64 new_pos;
    switch (whence) {
    case SEEK_SET:
        new_pos = offset;
        break;
    case SEEK_CUR:
        new_pos = fp->f_pos + offset;
        break;
    case SEEK_END:
        new_pos = fp->f_inode->i_size + offset;
        break;
    default:
        return -EINVAL;
    }

    if (new_pos < 0) return -EINVAL;
    fp->f_pos = new_pos;
    return new_pos;
}

int vfs_fstat(file* fp, kstat* stat)
{
    inode* ip = file_inode(fp);
    if (!ip) return -EBADF;

    if (ip->i_op && ip->i_op->getattr) {
        return ip->i_op->getattr(&fp->f_path, stat, 0, 0);
    }

    generic_fillattr(ip, stat);
    return 0;
}

/* ================================================================== */
/*  path_get / path_put (simplified)                                  */
/* ================================================================== */

void path_get(const path* p)
{
    if (p->de) dget(p->de);
    /* Future: mntget(p->mnt) */
}

void path_put(const path* p)
{
    if (p->de) dput(p->de);
    /* Future: mntput(p->mnt) */
}

/* ================================================================== */
/*  mntget / mntput (stubs for Phase 1)                               */
/* ================================================================== */

vfsmount* mntget(vfsmount* mnt) { return mnt; }
void mntput(vfsmount*) {}
