/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * inode.cc — Inode allocation, lifecycle, and generic helpers
 */

#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/slab.h>
#include <lume/errno.h>

namespace {
lume::atomic<uint64> g_next_ino{1};
} // namespace

/* ================================================================== */
/*  new_inode — allocate a fresh inode on a superblock                */
/* ================================================================== */

inode* new_inode(super_block* sb)
{
    inode* ip = nullptr;

    if (sb->s_op && sb->s_op->alloc_inode)
        ip = sb->s_op->alloc_inode(sb);
    else
        ip = new inode{};

    if (!ip) return nullptr;

    /* Zero-init key fields */
    ip->i_sb = sb;
    ip->i_ino = g_next_ino.fetch_add(1);
    ip->i_mode = 0;
    ip->i_flags = 0;
    ip->i_uid = 0;
    ip->i_gid = 0;
    ip->i_nlink = 1;
    ip->i_rdev = 0;
    ip->i_size = 0;
    ip->i_blocks = 0;
    ip->i_bytes = 0;
    ip->i_blkbits = sb->s_blocksize_bits;
    ip->i_generation = 0;
    ip->i_state = I_NEW;
    ip->i_count.store(1);
    ip->i_writecount.store(0);

    ip->i_atime_sec = ip->i_mtime_sec = ip->i_ctime_sec = 0;
    ip->i_atime_nsec = ip->i_mtime_nsec = ip->i_ctime_nsec = 0;

    ip->i_op = nullptr;
    ip->i_fop = nullptr;
    ip->i_mapping = &ip->i_data;
    ip->i_private = nullptr;
    ip->i_pipe = nullptr;

    /* Init embedded address_space */
    ip->i_data.host = ip;
    ip->i_data.a_ops = nullptr;
    ip->i_data.nrpages = 0;
    ip->i_data.flags = 0;

    /* Init lists */
    list_init(&ip->i_sb_list);
    list_init(&ip->i_dentry);

    /* Add to superblock's inode list */
    {
        LockGuard guard(sb->s_inode_list_lock);
        list_add_tail(&ip->i_sb_list, &sb->s_inodes);
    }

    return ip;
}

/* ================================================================== */
/*  ihold / iput — reference counting                                */
/* ================================================================== */

void ihold(inode* ip)
{
    ip->i_count.fetch_add(1);
}

void iput(inode* ip)
{
    if (!ip) return;

    int old = ip->i_count.fetch_sub(1);
    if (old > 1) return;

    /* Last reference dropped — evict */
    if (ip->i_sb->s_op && ip->i_sb->s_op->evict_inode)
        ip->i_sb->s_op->evict_inode(ip);

    /* Remove from sb list */
    {
        LockGuard guard(ip->i_sb->s_inode_list_lock);
        list_del(&ip->i_sb_list);
    }

    if (ip->i_sb->s_op && ip->i_sb->s_op->destroy_inode)
        ip->i_sb->s_op->destroy_inode(ip);
    else
        delete ip;
}

/* ================================================================== */
/*  nlink helpers                                                     */
/* ================================================================== */

void set_nlink(inode* ip, uint32 nlink) { ip->i_nlink = nlink; }
void inc_nlink(inode* ip)               { ip->i_nlink++; }
void drop_nlink(inode* ip)              { ip->i_nlink--; }
void clear_nlink(inode* ip)             { ip->i_nlink = 0; }

/* ================================================================== */
/*  inode_init_owner                                                  */
/* ================================================================== */

void inode_init_owner(inode* ip, const inode* dir, uint32 mode)
{
    ip->i_uid = 0;  /* Phase 1: always root */
    ip->i_gid = 0;
    ip->i_mode = mode;
}

/* ================================================================== */
/*  generic_fillattr — fill kstat from inode (used by getattr)        */
/* ================================================================== */

void generic_fillattr(inode* ip, kstat* stat)
{
    stat->st_dev = ip->i_sb->s_dev;
    stat->st_ino = ip->i_ino;
    stat->st_mode = ip->i_mode;
    stat->st_nlink = ip->i_nlink;
    stat->st_uid = ip->i_uid;
    stat->st_gid = ip->i_gid;
    stat->st_rdev = ip->i_rdev;
    stat->__pad = 0;
    stat->st_size = ip->i_size;
    stat->st_blksize = 1 << ip->i_blkbits;
    stat->__pad2 = 0;
    stat->st_blocks = ip->i_blocks;
    stat->st_atime_sec = ip->i_atime_sec;
    stat->st_atime_nsec = ip->i_atime_nsec;
    stat->st_mtime_sec = ip->i_mtime_sec;
    stat->st_mtime_nsec = ip->i_mtime_nsec;
    stat->st_ctime_sec = ip->i_ctime_sec;
    stat->st_ctime_nsec = ip->i_ctime_nsec;
    stat->__unused[0] = 0;
    stat->__unused[1] = 0;
}

/* ================================================================== */
/*  mark_inode_dirty (stub)                                           */
/* ================================================================== */

void mark_inode_dirty(inode* ip)
{
    ip->i_state |= I_DIRTY_SYNC;
    /* Phase 1: no writeback, ramfs is memory-only */
}
