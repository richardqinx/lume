/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * mount.h — Internal mount structure
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/atomic.h>
#include <lume/file.h>

struct dentry;
struct super_block;
struct file_system_type;

/* ================================================================== */
/*  mount (VFS-internal)                                              */
/* ================================================================== */

struct mount {
    vfsmount            mnt;
    mount*              mnt_parent;
    dentry*             mnt_mountpoint;
    list_node           mnt_child;
    list_head           mnt_mounts;
    list_node           mnt_list;
    lume::atomic<int32> mnt_count;
};

inline mount* real_mount(vfsmount* m) {
    return reinterpret_cast<mount*>(m);
}

/* ================================================================== */
/*  Mount API                                                         */
/* ================================================================== */

int  do_mount(const char* dev, const char* dir,
              const char* fstype, uint64 flags, void* data);
int  do_umount(vfsmount* mnt, int flags);

vfsmount* vfs_kern_mount(file_system_type* type, int flags,
                         const char* name, void* data);

/* Global root */
extern vfsmount* g_root_mnt;
extern dentry*   g_root_dentry;

void mount_init();
