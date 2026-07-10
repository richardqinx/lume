/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * fs.h — Core VFS data structures
 *
 * Defines super_block, inode, address_space, and their operations.
 * Modeled after Linux include/linux/fs.h + include/linux/fs/super_types.h.
 *
 * Reference: docs/vfs/01_super_block.md, docs/vfs/02_inode.md
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/atomic.h>
#include <lume/fs_types.h>
#include <kernel/sync/spinlock.h>

/* Forward declarations */
struct super_block;
struct inode;
struct dentry;
struct file;
struct vfsmount;
struct path;
struct kstat;
struct iattr;
struct file_operations;
struct inode_operations;
struct dentry_operations;
struct dir_context;
struct pipe_inode_info;
struct VmAreaStruct;
struct Page;

/* ================================================================== */
/*  address_space_operations                                          */
/* ================================================================== */

struct address_space_operations {
    int   (*read_folio)(file* fp, Page* page);
    int   (*write_begin)(struct address_space* mapping, int64 pos,
                         unsigned len, Page** pagep, void** fsdata);
    int   (*write_end)(struct address_space* mapping, int64 pos,
                       unsigned len, unsigned copied,
                       Page* page, void* fsdata);
};

/* ================================================================== */
/*  address_space                                                     */
/* ================================================================== */

struct address_space {
    inode*                              host;
    const address_space_operations*     a_ops;
    uint64                              nrpages;
    uint64                              flags;
    Spinlock                            i_private_lock;
};

/* ================================================================== */
/*  super_operations                                                  */
/* ================================================================== */

struct super_operations {
    inode*  (*alloc_inode)(super_block* sb);
    void    (*destroy_inode)(inode* ip);
    void    (*free_inode)(inode* ip);

    void    (*dirty_inode)(inode* ip, int flags);
    int     (*write_inode)(inode* ip, bool sync);
    int     (*drop_inode)(inode* ip);
    void    (*evict_inode)(inode* ip);
    void    (*put_super)(super_block* sb);
    int     (*sync_fs)(super_block* sb, int wait);
    int     (*statfs)(dentry* de, struct kstatfs* buf);
    void    (*umount_begin)(super_block* sb);
};

/* ================================================================== */
/*  file_system_type                                                  */
/* ================================================================== */

struct file_system_type {
    const char*     name;
    int             fs_flags;
    super_block*    (*mount)(file_system_type* type, int flags,
                            const char* dev_name, void* data);
    void            (*kill_sb)(super_block* sb);
    list_node       fs_list;
};

int register_filesystem(file_system_type* fs);
file_system_type* get_fs_type(const char* name);

/* ================================================================== */
/*  super_block                                                       */
/* ================================================================== */

struct mount;

struct super_block {
    list_node               s_list;
    uint64                  s_dev;
    uint8                   s_blocksize_bits;
    uint64                  s_blocksize;
    int64                   s_maxbytes;
    file_system_type*       s_type;
    const super_operations* s_op;

    uint64                  s_flags;
    uint64                  s_magic;
    dentry*                 s_root;

    char                    s_id[32];
    void*                   s_fs_info;

    uint32                  s_time_gran;
    int64                   s_time_min;
    int64                   s_time_max;

    Spinlock                s_inode_list_lock;
    list_head               s_inodes;

    lume::atomic<int32>     s_active;
    int                     s_count;

    mount*                  s_mounts;
    uint32                  s_max_links;
    const dentry_operations* s_d_op;
};

/* ================================================================== */
/*  inode                                                             */
/* ================================================================== */

struct inode {
    /* ---- Path-walk hot fields ---- */
    uint32              i_mode;
    uint32              i_flags;
    uint32              i_uid;
    uint32              i_gid;

    const inode_operations* i_op;
    super_block*        i_sb;
    address_space*      i_mapping;

    /* ---- Stat data ---- */
    uint64              i_ino;
    uint32              i_nlink;        /* Use set_nlink/inc_nlink/drop_nlink */
    uint32              i_rdev;
    int64               i_size;

    int64               i_atime_sec;
    int64               i_mtime_sec;
    int64               i_ctime_sec;
    uint32              i_atime_nsec;
    uint32              i_mtime_nsec;
    uint32              i_ctime_nsec;
    uint32              i_generation;

    Spinlock            i_lock;
    unsigned short      i_bytes;
    uint8               i_blkbits;
    int64               i_blocks;

    /* ---- State ---- */
    uint32              i_state;

    /* ---- Lists ---- */
    list_node           i_sb_list;
    list_head           i_dentry;

    /* ---- Counters ---- */
    lume::atomic<int32> i_count;
    lume::atomic<int32> i_writecount;

    /* ---- File ops ---- */
    const file_operations* i_fop;

    /* ---- Embedded address_space ---- */
    address_space       i_data;

    /* ---- Type-specific ---- */
    union {
        pipe_inode_info*    i_pipe;
        char*               i_link;
        uint32              i_dir_seq;
    };

    void*               i_private;
};

/* ================================================================== */
/*  inode_operations                                                  */
/* ================================================================== */

struct inode_operations {
    dentry* (*lookup)(inode* dir, dentry* de, unsigned int flags);
    int     (*create)(inode* dir, dentry* de, uint32 mode, bool excl);
    int     (*link)(dentry* old_de, inode* dir, dentry* new_de);
    int     (*unlink)(inode* dir, dentry* de);
    int     (*symlink)(inode* dir, dentry* de, const char* target);
    int     (*mkdir)(inode* dir, dentry* de, uint32 mode);
    int     (*rmdir)(inode* dir, dentry* de);
    int     (*mknod)(inode* dir, dentry* de, uint32 mode, uint32 rdev);
    int     (*rename)(inode* old_dir, dentry* old_de,
                      inode* new_dir, dentry* new_de, unsigned int flags);
    int     (*setattr)(dentry* de, iattr* attr);
    int     (*getattr)(const path* p, kstat* stat, uint32 request_mask,
                       unsigned int query_flags);
    const char* (*get_link)(dentry* de, inode* ip);
    int     (*permission)(inode* ip, int mask);
};

/* ================================================================== */
/*  Inode API                                                         */
/* ================================================================== */

inode* new_inode(super_block* sb);
inode* iget(super_block* sb, uint64 ino);
void   iput(inode* ip);
void   ihold(inode* ip);
void   mark_inode_dirty(inode* ip);

void   set_nlink(inode* ip, uint32 nlink);
void   inc_nlink(inode* ip);
void   drop_nlink(inode* ip);
void   clear_nlink(inode* ip);

void   inode_init_owner(inode* ip, const inode* dir, uint32 mode);

/* Generic helpers used by simple filesystems */
void   generic_fillattr(inode* ip, kstat* stat);

/* ================================================================== */
/*  kstat (matches oscomp ABI layout exactly)                         */
/* ================================================================== */

struct kstat {
    uint64  st_dev;
    uint64  st_ino;
    uint32  st_mode;
    uint32  st_nlink;
    uint32  st_uid;
    uint32  st_gid;
    uint64  st_rdev;
    uint64  __pad;
    int64   st_size;
    int32   st_blksize;
    int32   __pad2;
    int64   st_blocks;
    int64   st_atime_sec;
    int64   st_atime_nsec;
    int64   st_mtime_sec;
    int64   st_mtime_nsec;
    int64   st_ctime_sec;
    int64   st_ctime_nsec;
    uint32  __unused[2];
};

struct kstatfs {
    int64   f_type;
    int64   f_bsize;
    uint64  f_blocks;
    uint64  f_bfree;
    uint64  f_bavail;
    uint64  f_files;
    uint64  f_ffree;
    int32   f_fsid[2];
    int64   f_namelen;
    int64   f_frsize;
    int64   f_flags;
    int64   f_spare[4];
};

/* ================================================================== */
/*  iattr (for setattr)                                               */
/* ================================================================== */

struct iattr {
    unsigned int    ia_valid;       /* ATTR_* flags */
    uint32          ia_mode;
    uint32          ia_uid;
    uint32          ia_gid;
    int64           ia_size;
    int64           ia_atime_sec;
    int64           ia_atime_nsec;
    int64           ia_mtime_sec;
    int64           ia_mtime_nsec;
    int64           ia_ctime_sec;
    int64           ia_ctime_nsec;
};

/* ATTR_* flags */
inline constexpr uint32 ATTR_MODE  = (1U << 0);
inline constexpr uint32 ATTR_UID   = (1U << 1);
inline constexpr uint32 ATTR_GID   = (1U << 2);
inline constexpr uint32 ATTR_SIZE  = (1U << 3);
inline constexpr uint32 ATTR_ATIME = (1U << 4);
inline constexpr uint32 ATTR_MTIME = (1U << 5);
inline constexpr uint32 ATTR_CTIME = (1U << 6);

/* ================================================================== */
/*  VFS init                                                          */
/* ================================================================== */

void vfs_init();
