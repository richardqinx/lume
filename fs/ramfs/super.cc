/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * ramfs/super.cc — RamFS superblock: mount, fill_super, and init
 */

#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/file.h>
#include <lume/mount.h>
#include <lume/slab.h>
#include <lume/kprintf.h>
#include <lume/errno.h>
#include <lume/fs_types.h>

extern inode* ramfs_get_inode(super_block* sb, const inode* dir,
                              uint32 mode, uint32 rdev);

/* Superblock allocation helper (defined in super.cc) */
extern super_block* alloc_super(file_system_type* type);

/* ================================================================== */
/*  ramfs super_operations                                            */
/* ================================================================== */

static inode* ramfs_alloc_inode(super_block* sb)
{
    return new inode{};
}

static void ramfs_destroy_inode(inode* ip)
{
    /* Free ramfs_file_data if any */
    if (ip->i_private) {
        struct ramfs_file_data {
            char* buf;
            uint64 capacity;
        };
        auto* data = static_cast<ramfs_file_data*>(ip->i_private);
        delete[] data->buf;
        delete data;
    }
    delete ip;
}

static int ramfs_statfs(dentry* de, kstatfs* buf)
{
    /* Simple fake values */
    buf->f_type = 0x858458f6;  /* RAMFS_MAGIC */
    buf->f_bsize = 4096;
    buf->f_blocks = 0;
    buf->f_bfree = 0;
    buf->f_bavail = 0;
    buf->f_files = 0;
    buf->f_ffree = 0;
    buf->f_namelen = 255;
    buf->f_frsize = 4096;
    buf->f_flags = 0;
    return 0;
}

static super_operations ramfs_sops;

static void ramfs_sops_init()
{
    ramfs_sops.alloc_inode   = ramfs_alloc_inode;
    ramfs_sops.destroy_inode = ramfs_destroy_inode;
    ramfs_sops.free_inode    = nullptr;
    ramfs_sops.dirty_inode   = nullptr;
    ramfs_sops.write_inode   = nullptr;
    ramfs_sops.drop_inode    = nullptr;
    ramfs_sops.evict_inode   = nullptr;
    ramfs_sops.put_super     = nullptr;
    ramfs_sops.sync_fs       = nullptr;
    ramfs_sops.statfs        = ramfs_statfs;
    ramfs_sops.umount_begin  = nullptr;
}

/* ================================================================== */
/*  ramfs_fill_super                                                  */
/* ================================================================== */

static int ramfs_fill_super(super_block* sb, void* data, int silent)
{
    sb->s_op = &ramfs_sops;
    sb->s_magic = 0x858458f6;
    sb->s_blocksize = 4096;
    sb->s_blocksize_bits = 12;
    sb->s_maxbytes = 0x7FFFFFFFFFFFFFFFLL;
    sb->s_time_gran = 1;

    /* Create root inode */
    inode* root_ip = ramfs_get_inode(sb, nullptr, S_IFDIR | 0755, 0);
    if (!root_ip) return -ENOMEM;

    /* Create root dentry */
    sb->s_root = d_make_root(root_ip);
    if (!sb->s_root)
        return -ENOMEM;

    return 0;
}

/* ================================================================== */
/*  ramfs_mount                                                       */
/* ================================================================== */

static super_block* ramfs_mount(file_system_type* type, int flags,
                                const char* dev_name, void* data)
{
    super_block* sb = alloc_super(type);
    if (!sb) return nullptr;

    int err = ramfs_fill_super(sb, data, flags & SB_SILENT);
    if (err) {
        delete sb;
        return nullptr;
    }

    return sb;
}

static void ramfs_kill_sb(super_block* sb)
{
    /* Phase 1: no cleanup needed for ramfs */
    (void)sb;
}

/* ================================================================== */
/*  Filesystem type registration                                      */
/* ================================================================== */

static file_system_type ramfs_fs_type;

extern void ramfs_file_ops_init();
extern void ramfs_dir_inode_ops_init();

void ramfs_init()
{
    /* Runtime init to avoid un-relocated absolute pointers in .data */
    ramfs_sops_init();
    ramfs_file_ops_init();
    ramfs_dir_inode_ops_init();

    ramfs_fs_type.name     = "ramfs";
    ramfs_fs_type.fs_flags = FS_NO_DEVICE;
    ramfs_fs_type.mount    = ramfs_mount;
    ramfs_fs_type.kill_sb  = ramfs_kill_sb;
    list_init(&ramfs_fs_type.fs_list);

    register_filesystem(&ramfs_fs_type);
}

