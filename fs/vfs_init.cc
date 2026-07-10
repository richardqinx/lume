/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * vfs_init.cc — Bootstrap the VFS: mount ramfs root, set global root
 *
 * Called from kernel_main() after slab_init() and ramfs_init().
 * This is the moral equivalent of Linux's vfs_caches_init() +
 * mnt_init() + init_rootfs().
 */

#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/file.h>
#include <lume/mount.h>
#include <lume/fdtable.h>
#include <lume/fs_struct.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/task.h>
#include <lume/sched.h>

/* ================================================================== */
/*  vfs_init — mount ramfs as root filesystem                         */
/* ================================================================== */

/*
 * ramfs_mount is called internally via the file_system_type::mount
 * callback registered by ramfs_init().  We look it up by name.
 */
extern file_system_type* get_fs_type(const char* name);
extern super_block* alloc_super(file_system_type* type);

void vfs_init()
{
    /* 1. Look up the ramfs filesystem type */
    file_system_type* ramfs_type = get_fs_type("ramfs");
    if (!ramfs_type || !ramfs_type->mount) {
        printk(KERN_ERR "vfs_init: ramfs not registered!\n");
        return;
    }

    /* 2. Mount ramfs */
    super_block* sb = ramfs_type->mount(ramfs_type, 0, "ramfs", nullptr);
    if (!sb || !sb->s_root) {
        printk(KERN_ERR "vfs_init: failed to mount ramfs!\n");
        return;
    }

    /* 3. Set global root */
    g_root_dentry = sb->s_root;
    g_root_mnt = nullptr;  /* TODO: allocate a proper vfsmount when mount.cc lands */

    dget(g_root_dentry);  /* Hold a reference for the global root */

    printk(KERN_INFO "[vfs] root filesystem mounted (ramfs)\n");

    /* 4. Set up VFS state for the current (BSP idle) task,
     *    which will be inherited by all subsequently created tasks. */
    TaskControlBlock* bsp = current_task();
    if (bsp) {
        if (!bsp->files) {
            bsp->files = alloc_files_struct();
        }
        if (!bsp->fs) {
            bsp->fs = alloc_fs_struct();
            if (bsp->fs) {
                bsp->fs->root.de = g_root_dentry;
                bsp->fs->root.mnt = g_root_mnt;
                bsp->fs->pwd.de = g_root_dentry;
                bsp->fs->pwd.mnt = g_root_mnt;
                dget(g_root_dentry);  /* root ref */
                dget(g_root_dentry);  /* pwd ref */
            }
        }
        printk(KERN_INFO "[vfs] BSP task VFS context initialized\n");
    }
}
