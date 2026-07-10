/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_dcache.cc — Self-tests for the dentry cache layer
 */

#include <lume/selftest.h>
#include <lume/dcache.h>
#include <lume/fs.h>
#include <lume/mount.h>
#include <lume/errno.h>
#include <lume/slab.h>

/* Root dentry/mount from VFS init */
extern dentry* g_root_dentry;
extern vfsmount* g_root_mnt;

void selftest_dcache()
{
    /* ---- d_alloc: basic allocation under root ---- */
    st_begin("dcache: d_alloc basic");
    {
        qstr name{};
        name.name = "test_child";
        name.len = 10;
        name.hash = full_name_hash(name.name, name.len);

        dentry* child = d_alloc(g_root_dentry, &name);
        ST_ASSERT(child != nullptr);
        ST_ASSERT_EQ(child->d_name.len, 10u);
        ST_ASSERT(child->d_parent == g_root_dentry);
        ST_ASSERT(child->d_inode == nullptr);  /* not instantiated yet */
        ST_ASSERT(child->d_sb == g_root_dentry->d_sb);

        /* Name was copied into inline buffer */
        bool match = true;
        for (uint32 i = 0; i < name.len; i++) {
            if (child->d_name.name[i] != name.name[i]) { match = false; break; }
        }
        ST_ASSERT(match);

        d_drop(child);
        dput(child);
    }
    st_pass();

    /* ---- d_lookup: find existing child ---- */
    st_begin("dcache: d_lookup finds child");
    {
        qstr name{};
        name.name = "lookup_me";
        name.len = 9;
        name.hash = full_name_hash(name.name, name.len);

        dentry* child = d_alloc(g_root_dentry, &name);
        ST_ASSERT(child != nullptr);

        /* d_lookup should find it */
        dentry* found = d_lookup(g_root_dentry, &name);
        ST_ASSERT(found != nullptr);
        ST_ASSERT(found == child);
        dput(found);  /* drop d_lookup ref */

        d_drop(child);
        dput(child);
    }
    st_pass();

    /* ---- d_lookup: miss returns nullptr ---- */
    st_begin("dcache: d_lookup miss returns nullptr");
    {
        qstr name{};
        name.name = "nonexistent_xyz";
        name.len = 15;
        name.hash = full_name_hash(name.name, name.len);

        dentry* found = d_lookup(g_root_dentry, &name);
        ST_ASSERT(found == nullptr);
    }
    st_pass();

    /* ---- d_instantiate: bind inode to dentry ---- */
    st_begin("dcache: d_instantiate binds inode");
    {
        qstr name{};
        name.name = "has_inode";
        name.len = 9;
        name.hash = full_name_hash(name.name, name.len);

        dentry* child = d_alloc(g_root_dentry, &name);
        ST_ASSERT(child != nullptr);
        ST_ASSERT(child->d_inode == nullptr);

        /* Create a dummy inode */
        inode* ip = new_inode(g_root_dentry->d_sb);
        ST_ASSERT(ip != nullptr);
        ip->i_mode = S_IFREG | 0644;

        d_instantiate(child, ip);
        ST_ASSERT(child->d_inode == ip);
        ST_ASSERT(child->d_flags & DCACHE_REGULAR_TYPE);

        d_drop(child);
        dput(child);
    }
    st_pass();

    /* ---- dget/dput: refcount ---- */
    st_begin("dcache: dget/dput refcount");
    {
        qstr name{};
        name.name = "reftest";
        name.len = 7;
        name.hash = full_name_hash(name.name, name.len);

        dentry* child = d_alloc(g_root_dentry, &name);
        ST_ASSERT(child != nullptr);
        /* d_alloc sets refcount = 1 */
        int rc1 = child->d_lockref.load();
        ST_ASSERT(rc1 >= 1);

        dget(child);
        int rc2 = child->d_lockref.load();
        ST_ASSERT_EQ(rc2, rc1 + 1);

        dput(child);
        int rc3 = child->d_lockref.load();
        ST_ASSERT_EQ(rc3, rc1);

        d_drop(child);
        dput(child);
    }
    st_pass();

    /* ---- d_drop: removes from parent children list ---- */
    st_begin("dcache: d_drop removes from parent");
    {
        qstr name{};
        name.name = "dropme";
        name.len = 6;
        name.hash = full_name_hash(name.name, name.len);

        dentry* child = d_alloc(g_root_dentry, &name);
        ST_ASSERT(child != nullptr);

        /* Should be findable */
        dentry* f1 = d_lookup(g_root_dentry, &name);
        ST_ASSERT(f1 != nullptr);
        dput(f1);

        /* Drop it */
        d_drop(child);

        /* Should no longer be findable */
        dentry* f2 = d_lookup(g_root_dentry, &name);
        ST_ASSERT(f2 == nullptr);

        dput(child);
    }
    st_pass();

    /* ---- d_path: root returns "/" ---- */
    st_begin("dcache: d_path root returns /");
    {
        path p{};
        p.de = g_root_dentry;
        p.mnt = g_root_mnt;

        char buf[64];
        char* result = d_path(&p, buf, sizeof(buf));
        ST_ASSERT(result != nullptr);
        ST_ASSERT(result[0] == '/');
        ST_ASSERT(result[1] == '\0');
    }
    st_pass();

    /* ---- d_path: child path ---- */
    st_begin("dcache: d_path child returns /name");
    {
        qstr name{};
        name.name = "pathtest";
        name.len = 8;
        name.hash = full_name_hash(name.name, name.len);

        dentry* child = d_alloc(g_root_dentry, &name);
        ST_ASSERT(child != nullptr);

        path p{};
        p.de = child;
        p.mnt = g_root_mnt;

        char buf[64];
        char* result = d_path(&p, buf, sizeof(buf));
        ST_ASSERT(result != nullptr);

        /* Should be "/pathtest" */
        const char* expected = "/pathtest";
        bool eq = true;
        for (int i = 0; expected[i]; i++) {
            if (result[i] != expected[i]) { eq = false; break; }
        }
        ST_ASSERT(eq);

        d_drop(child);
        dput(child);
    }
    st_pass();

    /* ---- d_alloc_anon: root-like dentry ---- */
    st_begin("dcache: d_alloc_anon");
    {
        dentry* anon = d_alloc_anon(g_root_dentry->d_sb);
        ST_ASSERT(anon != nullptr);
        ST_ASSERT(anon->d_parent == anon);  /* root: parent is self */
        ST_ASSERT(anon->d_sb == g_root_dentry->d_sb);
        dput(anon);
    }
    st_pass();

    /* ---- full_name_hash: deterministic ---- */
    st_begin("dcache: full_name_hash deterministic");
    {
        uint32 h1 = full_name_hash("hello", 5);
        uint32 h2 = full_name_hash("hello", 5);
        ST_ASSERT_EQ(h1, h2);

        uint32 h3 = full_name_hash("world", 5);
        ST_ASSERT_NE(h1, h3);
    }
    st_pass();
}
