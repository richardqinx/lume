/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * devfs.cc — /dev population and chardev-aware open
 *
 * Creates /dev as a subdirectory under the ramfs root, then
 * populates device nodes.  On open(), if the inode is S_IFCHR,
 * we look up the cdev by i_rdev and use its fops.
 */

#include <lume/fs.h>
#include <lume/dcache.h>
#include <lume/file.h>
#include <lume/chardev.h>
#include <lume/mount.h>
#include <lume/klog.h>
#include <lume/errno.h>
#include <lume/fs_types.h>

/* ================================================================== */
/*  devfs_create_node — create a char device inode under parent        */
/* ================================================================== */

static int devfs_create_node(dentry* parent, const char* name,
                             uint32 major, uint32 minor)
{
    inode* dir_ip = parent->d_inode;
    if (!dir_ip || !dir_ip->i_op || !dir_ip->i_op->mknod) {
        return -EPERM;
    }

    qstr q{};
    q.name = name;
    q.len = 0;
    for (const char* s = name; *s; s++) {
        q.len++;
    }

    dentry* de = d_alloc(parent, &q);
    if (!de) {
        return -ENOMEM;
    }

    int err = dir_ip->i_op->mknod(dir_ip, de, S_IFCHR | 0666,
                                   MKDEV(major, minor));
    if (err) {
        return err;
    }

    return 0;
}

/* ================================================================== */
/*  devfs_open — chardev-aware open hook                              */
/* ================================================================== */

/*
 * Called from sys_openat when the inode is S_IFCHR.
 * Replaces f_op with the chardev's file_operations.
 */
int devfs_chrdev_open(inode* ip, file* fp)
{
    if (!S_ISCHR(ip->i_mode)) {
        return 0;
    }

    cdev* cd = cdev_find(ip->i_rdev);
    if (!cd || !cd->fops) {
        return -ENXIO;  /* No such device */
    }

    fp->f_op = cd->fops;

    /* Call the device's own open if it has one */
    if (fp->f_op->open) {
        return fp->f_op->open(ip, fp);
    }

    return 0;
}

/* ================================================================== */
/*  devfs_init — create /dev and populate device nodes                 */
/* ================================================================== */

void devfs_init()
{
    if (!g_root_dentry || !g_root_dentry->d_inode) {
        printk(KERN_ERR "[devfs] no root filesystem!\n");
        return;
    }

    /* Create /dev directory — or reuse if initramfs already created it.
     * Linux: devtmpfs similarly handles pre-existing directories. */
    inode* root_ip = g_root_dentry->d_inode;

    qstr dev_name{};
    dev_name.name = "dev";
    dev_name.len = 3;
    dev_name.hash = full_name_hash("dev", 3);

    dentry* dev_de = d_lookup(g_root_dentry, &dev_name);
    if (dev_de) {
        /* /dev already exists (from initramfs) — reuse it */
        printk("[devfs] reusing existing /dev directory\n");
    } else {
        /* Create /dev from scratch */
        if (!root_ip->i_op || !root_ip->i_op->mkdir) {
            printk(KERN_ERR "[devfs] root has no mkdir!\n");
            return;
        }

        dev_de = d_alloc(g_root_dentry, &dev_name);
        if (!dev_de) {
            printk(KERN_ERR "[devfs] failed to alloc /dev dentry\n");
            return;
        }

        int err = root_ip->i_op->mkdir(root_ip, dev_de, S_IFDIR | 0755);
        if (err) {
            printk(KERN_ERR "[devfs] mkdir /dev failed: %d\n", err);
            return;
        }
    }

    /* Populate: /dev/console (5,1) */
    devfs_create_node(dev_de, "console", 5, 1);

    /* Populate: /dev/null (1,3) */
    devfs_create_node(dev_de, "null", 1, 3);

    /* Populate: /dev/zero (1,5) */
    devfs_create_node(dev_de, "zero", 1, 5);

    printk("[devfs] /dev populated (console, null, zero)\n");
}
