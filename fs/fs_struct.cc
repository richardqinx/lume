/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * fs_struct.cc — Per-task filesystem context (cwd, root)
 */

#include <lume/fs_struct.h>
#include <lume/slab.h>

/* ================================================================== */
/*  alloc_fs_struct                                                   */
/* ================================================================== */

fs_struct* alloc_fs_struct()
{
    auto* fs = new fs_struct{};
    if (!fs) return nullptr;

    fs->count.store(1);
    fs->umask = 022;
    fs->root = {nullptr, nullptr};
    fs->pwd  = {nullptr, nullptr};

    return fs;
}

/* ================================================================== */
/*  put_fs_struct                                                     */
/* ================================================================== */

void put_fs_struct(fs_struct* fs)
{
    if (!fs) return;

    int old = fs->count.fetch_sub(1);
    if (old > 1) return;

    path_put(&fs->root);
    path_put(&fs->pwd);
    delete fs;
}

/* ================================================================== */
/*  copy_fs_struct — for fork without CLONE_FS                        */
/* ================================================================== */

fs_struct* copy_fs_struct(const fs_struct* old_fs)
{
    auto* fs = alloc_fs_struct();
    if (!fs) return nullptr;

    fs->umask = old_fs->umask;

    fs->root = old_fs->root;
    path_get(&fs->root);

    fs->pwd = old_fs->pwd;
    path_get(&fs->pwd);

    return fs;
}

/* ================================================================== */
/*  set_fs_root / set_fs_pwd                                          */
/* ================================================================== */

void set_fs_root(fs_struct* fs, const path* p)
{
    path old_root;
    {
        LockGuard guard(fs->lock);
        old_root = fs->root;
        fs->root = *p;
        path_get(p);
    }
    path_put(&old_root);
}

void set_fs_pwd(fs_struct* fs, const path* p)
{
    path old_pwd;
    {
        LockGuard guard(fs->lock);
        old_pwd = fs->pwd;
        fs->pwd = *p;
        path_get(p);
    }
    path_put(&old_pwd);
}
