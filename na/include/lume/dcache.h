/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * dcache.h — Directory entry cache
 *
 * Modeled after Linux include/linux/dcache.h.
 * Reference: docs/vfs/03_dentry.md
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/atomic.h>
#include <lume/fs_types.h>
#include <kernel/sync/spinlock.h>

struct inode;
struct super_block;
struct dentry;
struct dentry_operations;
struct path;

/* ================================================================== */
/*  qstr — quick string (name + precomputed hash + length)            */
/* ================================================================== */

struct qstr {
    union {
        struct {
            uint32 hash;
            uint32 len;
        };
        uint64 hash_len;
    };
    const char* name;
};

uint32 full_name_hash(const char* name, uint32 len);

/* ================================================================== */
/*  dentry                                                            */
/* ================================================================== */

inline constexpr int DNAME_INLINE_LEN = 40;

struct dentry {
    /* ---- RCU / lookup hot fields ---- */
    unsigned int        d_flags;
    dentry*             d_parent;
    qstr                d_name;
    inode*              d_inode;
    unsigned char       d_iname[DNAME_INLINE_LEN];

    /* ---- Ref lookup ---- */
    const dentry_operations* d_op;
    super_block*        d_sb;
    unsigned long       d_time;
    void*               d_fsdata;

    /* ---- Refcount + lock ---- */
    lume::atomic<int32> d_lockref;
    Spinlock            d_lock;

    /* ---- Tree linkage ---- */
    list_node           d_lru;
    list_node           d_child;        /* Linkage in parent->d_children */
    list_head           d_children;     /* Children of this dentry */

    /* ---- Inode alias ---- */
    list_node           d_alias;        /* Linkage in inode->i_dentry */
};

/* ================================================================== */
/*  dentry_operations                                                 */
/* ================================================================== */

struct dentry_operations {
    int   (*d_revalidate)(dentry* de, unsigned int flags);
    int   (*d_hash)(const dentry* de, qstr* name);
    int   (*d_compare)(const dentry* parent, unsigned int len,
                       const char* str, const qstr* name);
    int   (*d_delete)(const dentry* de);
    int   (*d_init)(dentry* de);
    void  (*d_release)(dentry* de);
    void  (*d_iput)(dentry* de, inode* ip);
};

/* ================================================================== */
/*  Dentry helpers                                                    */
/* ================================================================== */

inline bool d_is_negative(const dentry* de) {
    return (de->d_flags & DCACHE_ENTRY_TYPE) == DCACHE_MISS_TYPE;
}
inline bool d_is_positive(const dentry* de) {
    return !d_is_negative(de);
}
inline bool d_is_dir(const dentry* de) {
    return (de->d_flags & DCACHE_ENTRY_TYPE) == DCACHE_DIRECTORY_TYPE;
}
inline bool d_is_reg(const dentry* de) {
    return (de->d_flags & DCACHE_ENTRY_TYPE) == DCACHE_REGULAR_TYPE;
}
inline bool d_is_symlink(const dentry* de) {
    return (de->d_flags & DCACHE_ENTRY_TYPE) == DCACHE_SYMLINK_TYPE;
}
inline bool d_mountpoint(const dentry* de) {
    return (de->d_flags & DCACHE_MOUNTED) != 0;
}
inline bool d_is_root(const dentry* de) {
    return de == de->d_parent;
}

inline inode* d_inode_ptr(const dentry* de) {
    return de->d_inode;
}

/* ================================================================== */
/*  Dcache API                                                        */
/* ================================================================== */

dentry* d_alloc(dentry* parent, const qstr* name);
dentry* d_alloc_anon(super_block* sb);
void    d_instantiate(dentry* de, inode* ip);
dentry* d_make_root(inode* root_inode);
void    d_add(dentry* de, inode* ip);
dentry* d_lookup(const dentry* parent, const qstr* name);
dentry* dget(dentry* de);
void    dput(dentry* de);
void    d_drop(dentry* de);
void    d_delete(dentry* de);
char*   d_path(const path* p, char* buf, int buflen);

/* Set dentry type flags based on inode mode */
void    d_set_type(dentry* de, uint32 i_mode);

/* ================================================================== */
/*  Dcache init                                                       */
/* ================================================================== */

void dcache_init();
