/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * ramfs/inode.cc — RamFS inode operations
 *
 * A simple in-memory filesystem (like Linux tmpfs without swap).
 * All data lives in memory via the page cache.
 */

#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/file.h>
#include <lume/slab.h>
#include <lume/errno.h>
#include <lume/fs_types.h>

/* Forward declarations */
extern file_operations ramfs_file_operations;
extern file_operations ramfs_dir_operations;
extern inode_operations ramfs_dir_inode_operations;

/* ================================================================== */
/*  ramfs_get_inode — allocate + init an inode for ramfs               */
/* ================================================================== */

inode* ramfs_get_inode(super_block* sb, const inode* dir, uint32 mode, uint32 rdev)
{
    inode* ip = new_inode(sb);
    if (!ip) return nullptr;

    inode_init_owner(ip, dir, mode);
    /* TODO: set timestamps to current time when we have a time source */

    switch (mode & S_IFMT) {
    case S_IFREG:
        ip->i_op = nullptr;  /* regular files don't need inode_ops for Phase 1 */
        ip->i_fop = &ramfs_file_operations;
        break;
    case S_IFDIR:
        ip->i_op = &ramfs_dir_inode_operations;
        ip->i_fop = &ramfs_dir_operations;
        inc_nlink(ip);  /* directories start with nlink=2 (. and parent's link) */
        break;
    case S_IFLNK:
        /* Symlink: stub for Phase 1 */
        break;
    default:
        /* Character/block devices: i_rdev */
        ip->i_rdev = rdev;
        break;
    }

    return ip;
}

/* ================================================================== */
/*  Directory inode operations                                        */
/* ================================================================== */

static dentry* ramfs_lookup(inode* dir, dentry* de, unsigned int flags)
{
    (void)dir;
    (void)flags;
    /* For ramfs, everything is in dcache. If we get here, it means
     * d_lookup() already failed, so this is a negative dentry.
     * Just return nullptr to let the caller see de->d_inode == NULL. */
    return nullptr;
}

static int ramfs_create(inode* dir, dentry* de, uint32 mode, bool excl)
{
    (void)excl;
    inode* ip = ramfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
    if (!ip) return -ENOMEM;

    d_instantiate(de, ip);
    dget(de);
    dir->i_size += de->d_name.len;
    mark_inode_dirty(dir);
    return 0;
}

static int ramfs_mkdir(inode* dir, dentry* de, uint32 mode)
{
    inode* ip = ramfs_get_inode(dir->i_sb, dir, mode | S_IFDIR, 0);
    if (!ip) return -ENOMEM;

    d_instantiate(de, ip);
    dget(de);
    inc_nlink(dir);
    dir->i_size += de->d_name.len;
    mark_inode_dirty(dir);
    return 0;
}

static int ramfs_rmdir(inode* dir, dentry* de)
{
    /* Check if directory is empty */
    if (!list_empty(&de->d_children))
        return -ENOTEMPTY;

    drop_nlink(de->d_inode);  /* remove . link */
    drop_nlink(de->d_inode);  /* remove parent's link */
    drop_nlink(dir);
    d_delete(de);
    dir->i_size -= de->d_name.len;
    mark_inode_dirty(dir);
    return 0;
}

static int ramfs_unlink(inode* dir, dentry* de)
{
    drop_nlink(de->d_inode);
    d_delete(de);
    dir->i_size -= de->d_name.len;
    mark_inode_dirty(dir);
    return 0;
}

static int ramfs_link(dentry* old_de, inode* dir, dentry* new_de)
{
    inode* ip = old_de->d_inode;
    if (!ip) return -ENOENT;

    inc_nlink(ip);
    ihold(ip);
    d_instantiate(new_de, ip);
    dget(new_de);
    dir->i_size += new_de->d_name.len;
    mark_inode_dirty(dir);
    return 0;
}

static int ramfs_mknod(inode* dir, dentry* de, uint32 mode, uint32 rdev)
{
    inode* ip = ramfs_get_inode(dir->i_sb, dir, mode, rdev);
    if (!ip) return -ENOMEM;

    d_instantiate(de, ip);
    dget(de);
    dir->i_size += de->d_name.len;
    mark_inode_dirty(dir);
    return 0;
}

inode_operations ramfs_dir_inode_operations;

void ramfs_dir_inode_ops_init()
{
    ramfs_dir_inode_operations.lookup     = ramfs_lookup;
    ramfs_dir_inode_operations.create     = ramfs_create;
    ramfs_dir_inode_operations.link       = ramfs_link;
    ramfs_dir_inode_operations.unlink     = ramfs_unlink;
    ramfs_dir_inode_operations.symlink    = nullptr;
    ramfs_dir_inode_operations.mkdir      = ramfs_mkdir;
    ramfs_dir_inode_operations.rmdir      = ramfs_rmdir;
    ramfs_dir_inode_operations.mknod      = ramfs_mknod;
    ramfs_dir_inode_operations.rename     = nullptr;
    ramfs_dir_inode_operations.setattr    = nullptr;
    ramfs_dir_inode_operations.getattr    = nullptr;
    ramfs_dir_inode_operations.get_link   = nullptr;
    ramfs_dir_inode_operations.permission = nullptr;
}
