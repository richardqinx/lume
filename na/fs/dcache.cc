/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * dcache.cc — Directory entry cache
 *
 * Provides dentry allocation, lookup, instantiation, and d_path.
 */

#include <lume/dcache.h>
#include <lume/fs.h>
#include <lume/file.h>
#include <lume/slab.h>
#include <lume/errno.h>
#include <lume/fs_types.h>

/* ================================================================== */
/*  Hash function                                                     */
/* ================================================================== */

uint32 full_name_hash(const char* name, uint32 len)
{
    uint32 hash = 0;
    for (uint32 i = 0; i < len; i++)
        hash = hash * 31 + static_cast<uint8>(name[i]);
    return hash;
}

/* ================================================================== */
/*  d_set_type — set DCACHE_*_TYPE bits from inode mode               */
/* ================================================================== */

void d_set_type(dentry* de, uint32 i_mode)
{
    de->d_flags &= ~DCACHE_ENTRY_TYPE;

    if (S_ISDIR(i_mode))
        de->d_flags |= DCACHE_DIRECTORY_TYPE;
    else if (S_ISLNK(i_mode))
        de->d_flags |= DCACHE_SYMLINK_TYPE;
    else if (S_ISREG(i_mode))
        de->d_flags |= DCACHE_REGULAR_TYPE;
    else
        de->d_flags |= DCACHE_SPECIAL_TYPE;
}

/* ================================================================== */
/*  d_alloc — allocate a dentry under a parent                        */
/* ================================================================== */

static void dentry_init(dentry* de, dentry* parent, const qstr* name)
{
    de->d_flags = DCACHE_MISS_TYPE;  /* negative until instantiated */
    de->d_parent = parent ? parent : de;
    de->d_inode = nullptr;
    de->d_op = nullptr;
    de->d_sb = parent ? parent->d_sb : nullptr;
    de->d_time = 0;
    de->d_fsdata = nullptr;
    de->d_lockref.store(1);

    list_init(&de->d_lru);
    list_init(&de->d_child);
    list_init(&de->d_children);
    list_init(&de->d_alias);

    /* Copy name */
    if (name && name->name && name->len > 0) {
        uint32 len = name->len;
        if (len < DNAME_INLINE_LEN) {
            for (uint32 i = 0; i < len; i++)
                de->d_iname[i] = name->name[i];
            de->d_iname[len] = '\0';
            de->d_name.name = reinterpret_cast<const char*>(de->d_iname);
        } else {
            /* Heap-allocate for long names */
            char* buf = new char[len + 1];
            for (uint32 i = 0; i < len; i++)
                buf[i] = name->name[i];
            buf[len] = '\0';
            de->d_name.name = buf;
        }
        de->d_name.len = len;
        de->d_name.hash = name->hash ? name->hash : full_name_hash(name->name, len);
    } else {
        de->d_iname[0] = '\0';
        de->d_name.name = reinterpret_cast<const char*>(de->d_iname);
        de->d_name.len = 0;
        de->d_name.hash = 0;
    }
}

dentry* d_alloc(dentry* parent, const qstr* name)
{
    auto* de = new dentry{};
    if (!de) return nullptr;

    dentry_init(de, parent, name);
    de->d_sb = parent->d_sb;

    /* Use sb default d_op if set */
    if (parent->d_sb->s_d_op)
        de->d_op = parent->d_sb->s_d_op;

    /* Link into parent's children list */
    if (parent) {
        LockGuard guard(parent->d_lock);
        list_add_tail(&de->d_child, &parent->d_children);
        dget(parent);  /* child holds ref on parent */
    }

    return de;
}

dentry* d_alloc_anon(super_block* sb)
{
    auto* de = new dentry{};
    if (!de) return nullptr;

    dentry_init(de, nullptr, nullptr);
    de->d_sb = sb;
    de->d_parent = de;  /* root: parent is self */

    return de;
}

/* ================================================================== */
/*  d_instantiate — bind an inode to a dentry                         */
/* ================================================================== */

void d_instantiate(dentry* de, inode* ip)
{
    if (!ip) return;

    LockGuard guard(de->d_lock);
    de->d_inode = ip;
    d_set_type(de, ip->i_mode);

    /* Add to inode's alias list */
    list_add_tail(&de->d_alias, &ip->i_dentry);
}

/* ================================================================== */
/*  d_make_root — create root dentry for a superblock                 */
/* ================================================================== */

dentry* d_make_root(inode* root_inode)
{
    if (!root_inode) return nullptr;

    dentry* de = d_alloc_anon(root_inode->i_sb);
    if (!de) {
        iput(root_inode);
        return nullptr;
    }

    d_instantiate(de, root_inode);
    return de;
}

/* ================================================================== */
/*  d_add — combined d_instantiate + d_rehash                         */
/* ================================================================== */

void d_add(dentry* de, inode* ip)
{
    d_instantiate(de, ip);
    /* d_rehash would add to dcache hash table; simplified for now */
}

/* ================================================================== */
/*  d_lookup — search children of parent for a name match             */
/* ================================================================== */

dentry* d_lookup(const dentry* parent, const qstr* name)
{
    LockGuard guard(const_cast<Spinlock&>(parent->d_lock));

    list_node* pos;
    list_for_each(pos, &parent->d_children) {
        dentry* child = list_entry(pos, dentry, d_child);

        if (child->d_name.len != name->len)
            continue;

        /* Compare names */
        const char* a = child->d_name.name;
        const char* b = name->name;
        uint32 len = name->len;
        bool match = true;
        for (uint32 i = 0; i < len; i++) {
            if (a[i] != b[i]) { match = false; break; }
        }
        if (match) {
            dget(child);
            return child;
        }
    }

    return nullptr;
}

/* ================================================================== */
/*  dget / dput — dentry reference counting                           */
/* ================================================================== */

dentry* dget(dentry* de)
{
    if (de)
        de->d_lockref.fetch_add(1);
    return de;
}

void dput(dentry* de)
{
    if (!de) return;

    int old = de->d_lockref.fetch_sub(1);
    if (old > 1) return;

    /* Last reference — could free, but for ramfs we keep dentries alive.
     * A real implementation would check d_op->d_delete and possibly
     * add to LRU for later reclaim. For now, just leak (Phase 1). */
}

/* ================================================================== */
/*  d_drop / d_delete                                                 */
/* ================================================================== */

void d_drop(dentry* de)
{
    /* Remove from parent's children list */
    LockGuard guard(de->d_lock);
    if (!list_empty(&de->d_child))
        list_del_init(&de->d_child);
}

void d_delete(dentry* de)
{
    d_drop(de);
}

/* ================================================================== */
/*  d_path — build absolute pathname from a path                      */
/* ================================================================== */

char* d_path(const path* p, char* buf, int buflen)
{
    if (!p || !p->de || buflen <= 0)
        return nullptr;

    /* Build path by walking up d_parent chain, writing backwards */
    char* end = buf + buflen - 1;
    *end = '\0';

    dentry* de = p->de;

    if (d_is_root(de)) {
        if (end <= buf) return nullptr;
        *(--end) = '/';
        return end;
    }

    while (!d_is_root(de)) {
        uint32 len = de->d_name.len;
        end -= len;
        if (end <= buf) return nullptr;

        const char* name = de->d_name.name;
        for (uint32 i = 0; i < len; i++)
            end[i] = name[i];

        *(--end) = '/';
        de = de->d_parent;
    }

    return end;
}

/* ================================================================== */
/*  dcache_init                                                       */
/* ================================================================== */

void dcache_init()
{
    /* Future: init dcache hash table */
}
