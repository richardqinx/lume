/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * super.cc — Superblock lifecycle + filesystem type registry
 */

#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/mount.h>
#include <lume/klog.h>
#include <lume/slab.h>
#include <lume/errno.h>

/* Global root filesystem entry points */
vfsmount* g_root_mnt    = nullptr;
dentry*   g_root_dentry = nullptr;

/* ================================================================== */
/*  Filesystem type registry                                          */
/* ================================================================== */

namespace {

list_head g_fs_types;
Spinlock  g_fs_type_lock;

} // namespace

int register_filesystem(file_system_type* fs)
{
    LockGuard guard(g_fs_type_lock);
    list_add_tail(&fs->fs_list, &g_fs_types);
    printk("[vfs] registered filesystem: %s\n", fs->name);
    return 0;
}

file_system_type* get_fs_type(const char* name)
{
    LockGuard guard(g_fs_type_lock);
    list_node* pos;
    list_for_each(pos, &g_fs_types) {
        auto* fs = list_entry(pos, file_system_type, fs_list);
        /* Simple strcmp */
        const char* a = fs->name;
        const char* b = name;
        while (*a && *a == *b) { a++; b++; }
        if (*a == '\0' && *b == '\0')
            return fs;
    }
    return nullptr;
}

/* ================================================================== */
/*  Superblock allocation                                             */
/* ================================================================== */

super_block* alloc_super(file_system_type* type)
{
    auto* sb = new super_block{};
    if (!sb) return nullptr;

    list_init(&sb->s_list);
    list_init(&sb->s_inodes);
    sb->s_type = type;
    sb->s_op = nullptr;
    sb->s_root = nullptr;
    sb->s_fs_info = nullptr;
    sb->s_blocksize = 4096;
    sb->s_blocksize_bits = 12;
    sb->s_maxbytes = 0x7FFFFFFFFFFFFFFFLL;
    sb->s_time_gran = 1;
    sb->s_time_min = 0;
    sb->s_time_max = 0x7FFFFFFFFFFFFFFFLL;
    sb->s_flags = 0;
    sb->s_magic = 0;
    sb->s_active.store(1);
    sb->s_count = 1;
    sb->s_max_links = 0;
    sb->s_d_op = nullptr;
    sb->s_mounts = nullptr;
    sb->s_dev = 0;
    for (int i = 0; i < 32; i++) sb->s_id[i] = 0;

    return sb;
}

/* ================================================================== */
/*  Init                                                              */
/* ================================================================== */

void super_init()
{
    list_init(&g_fs_types);
}
