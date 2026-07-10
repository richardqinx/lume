/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_namei.cc — Self-tests for pathname resolution (namei.cc)
 */

#include <lume/selftest.h>
#include <lume/namei.h>
#include <lume/dcache.h>
#include <lume/fs.h>
#include <lume/file.h>
#include <lume/mount.h>
#include <lume/task.h>
#include <lume/errno.h>

extern dentry* g_root_dentry;
extern vfsmount* g_root_mnt;

/* sys_mkdirat from kernel/sys_fs.cc */
int64 sys_mkdirat(uint64, uint64, uint64, uint64, uint64, uint64);

void selftest_namei()
{
    /* ---- lookup root "/" ---- */
    st_begin("namei: lookup root /");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/", 0, &p);
        ST_ASSERT_EQ(err, 0);
        ST_ASSERT(p.de == g_root_dentry);
        ST_ASSERT(p.de->d_inode != nullptr);
        ST_ASSERT(S_ISDIR(p.de->d_inode->i_mode));
    }
    st_pass();

    /* ---- lookup /dev (exists from boot) ---- */
    st_begin("namei: lookup /dev");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/dev", 0, &p);
        ST_ASSERT_EQ(err, 0);
        ST_ASSERT(p.de != nullptr);
        ST_ASSERT(p.de->d_inode != nullptr);
        ST_ASSERT(S_ISDIR(p.de->d_inode->i_mode));
    }
    st_pass();

    /* ---- lookup nonexistent path returns -ENOENT ---- */
    st_begin("namei: lookup nonexistent returns -ENOENT");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/this_does_not_exist", 0, &p);
        ST_ASSERT_EQ(err, -ENOENT);
    }
    st_pass();

    /* ---- lookup /dev/console (chardev) ---- */
    st_begin("namei: lookup /dev/console");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/dev/console", 0, &p);
        ST_ASSERT_EQ(err, 0);
        ST_ASSERT(p.de->d_inode != nullptr);
        ST_ASSERT(S_ISCHR(p.de->d_inode->i_mode));
    }
    st_pass();

    /* ---- lookup with LOOKUP_DIRECTORY on non-dir returns -ENOTDIR ---- */
    st_begin("namei: LOOKUP_DIRECTORY on file returns -ENOTDIR");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/dev/console", LOOKUP_DIRECTORY, &p);
        ST_ASSERT_EQ(err, -ENOTDIR);
    }
    st_pass();

    /* ---- lookup with LOOKUP_DIRECTORY on dir succeeds ---- */
    st_begin("namei: LOOKUP_DIRECTORY on dir succeeds");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/dev", LOOKUP_DIRECTORY, &p);
        ST_ASSERT_EQ(err, 0);
        ST_ASSERT(S_ISDIR(p.de->d_inode->i_mode));
    }
    st_pass();

    /* ---- kern_path shortcut ---- */
    st_begin("namei: kern_path works like filename_lookup");
    {
        path p{};
        int err = kern_path("/dev", 0, &p);
        ST_ASSERT_EQ(err, 0);
        ST_ASSERT(p.de->d_inode != nullptr);
    }
    st_pass();

    /* ---- dot path: /dev/. resolves to /dev ---- */
    st_begin("namei: /dev/. resolves to /dev");
    {
        path p1{}, p2{};
        int e1 = filename_lookup(AT_FDCWD, "/dev", 0, &p1);
        int e2 = filename_lookup(AT_FDCWD, "/dev/.", 0, &p2);
        ST_ASSERT_EQ(e1, 0);
        ST_ASSERT_EQ(e2, 0);
        ST_ASSERT(p1.de == p2.de);
    }
    st_pass();

    /* ---- dotdot path: /dev/.. resolves to root ---- */
    st_begin("namei: /dev/.. resolves to root");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/dev/..", 0, &p);
        ST_ASSERT_EQ(err, 0);
        ST_ASSERT(p.de == g_root_dentry);
    }
    st_pass();

    /* ---- lookup into non-dir returns -ENOTDIR ---- */
    st_begin("namei: path through non-dir returns -ENOTDIR");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/dev/console/child", 0, &p);
        ST_ASSERT_EQ(err, -ENOTDIR);
    }
    st_pass();

    /* ---- null/empty paths ---- */
    st_begin("namei: null name returns -EINVAL");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, nullptr, 0, &p);
        ST_ASSERT_EQ(err, -EINVAL);
    }
    st_pass();

    /* ---- LOOKUP_PARENT: returns parent dentry ---- */
    st_begin("namei: LOOKUP_PARENT returns parent");
    {
        path p{};
        int err = filename_lookup(AT_FDCWD, "/dev/console", LOOKUP_PARENT, &p);
        ST_ASSERT_EQ(err, 0);
        /* Should return /dev, not /dev/console */
        path dev_path{};
        int e2 = filename_lookup(AT_FDCWD, "/dev", 0, &dev_path);
        ST_ASSERT_EQ(e2, 0);
        ST_ASSERT(p.de == dev_path.de);
    }
    st_pass();

    /* ---- mkdir + lookup round-trip ---- */
    st_begin("namei: mkdir then lookup succeeds");
    {
        /* Create /test_namei_dir via sys_mkdirat */
        int64 ret = sys_mkdirat(
            static_cast<uint64>(-100),
            reinterpret_cast<uint64>("/test_namei_dir"),
            0755, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);

        /* Now lookup should find it */
        path p{};
        int err = filename_lookup(AT_FDCWD, "/test_namei_dir", 0, &p);
        ST_ASSERT_EQ(err, 0);
        ST_ASSERT(p.de->d_inode != nullptr);
        ST_ASSERT(S_ISDIR(p.de->d_inode->i_mode));
    }
    st_pass();

    /* NOTE: trailing slash "/dev/" not tested — Phase 1 namei
     * doesn't handle empty trailing components. */
}
