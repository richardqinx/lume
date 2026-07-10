/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * namei.cc — Pathname resolution (path lookup)
 *
 * Simplified Phase 1: no symlink, no RCU, no mount traversal.
 */

#include <lume/namei.h>
#include <lume/dcache.h>
#include <lume/fs.h>
#include <lume/file.h>
#include <lume/fdtable.h>
#include <lume/fs_struct.h>
#include <lume/mount.h>
#include <lume/task.h>
#include <lume/errno.h>
#include <lume/fs_types.h>

/* ================================================================== */
/*  Helpers                                                           */
/* ================================================================== */

static const char* next_component(const char* path, qstr* result)
{
    while (*path == '/') path++;
    if (*path == '\0') return nullptr;

    const char* start = path;
    while (*path != '\0' && *path != '/') path++;

    uint32 len = static_cast<uint32>(path - start);
    result->name = start;
    result->len = len;
    result->hash = full_name_hash(start, len);

    return path;
}

static bool is_dot(const qstr* name) {
    return name->len == 1 && name->name[0] == '.';
}
static bool is_dotdot(const qstr* name) {
    return name->len == 2 && name->name[0] == '.' && name->name[1] == '.';
}

/* ================================================================== */
/*  walk_component                                                    */
/* ================================================================== */

static dentry* walk_component(dentry* parent, const qstr* name)
{
    if (!parent->d_inode || !S_ISDIR(parent->d_inode->i_mode))
        return reinterpret_cast<dentry*>(-ENOTDIR);

    if (is_dot(name))
        return dget(parent);

    if (is_dotdot(name))
        return dget(parent->d_parent);

    /* Try dcache */
    dentry* child = d_lookup(parent, name);
    if (child)
        return child;

    /* Cache miss — call filesystem lookup */
    inode* dir = parent->d_inode;
    if (!dir->i_op || !dir->i_op->lookup)
        return reinterpret_cast<dentry*>(-ENOENT);

    child = d_alloc(parent, name);
    if (!child)
        return reinterpret_cast<dentry*>(-ENOMEM);

    dentry* result = dir->i_op->lookup(dir, child, 0);
    if (result) {
        dput(child);
        return result;
    }

    /* If lookup didn't set an inode, this is a negative dentry
     * (file doesn't exist).  Remove from dcache and return error. */
    if (!child->d_inode) {
        d_drop(child);
        dput(child);
        return reinterpret_cast<dentry*>(-ENOENT);
    }

    return child;
}

/* ================================================================== */
/*  filename_lookup                                                   */
/* ================================================================== */

int filename_lookup(int dfd, const char* name, unsigned int flags, path* result)
{
    if (!name || !result)
        return -EINVAL;

    TaskControlBlock* task = current_task();
    dentry* start;

    /* Determine starting dentry */
    if (name[0] == '/') {
        start = task->fs->root.de;
        if (!start) start = g_root_dentry;
        name++;
    } else if (dfd == AT_FDCWD) {
        start = task->fs->pwd.de;
        if (!start) start = g_root_dentry;
    } else {
        file* dir_fp = fcheck(task->files, dfd);
        if (!dir_fp) return -EBADF;
        start = dir_fp->f_path.de;
        if (!start || !start->d_inode || !S_ISDIR(start->d_inode->i_mode))
            return -ENOTDIR;
    }

    dentry* current_de = dget(start);
    const char* p = name;

    while (p && *p) {
        qstr component;
        const char* next = next_component(p, &component);
        if (!next && component.len == 0)
            break;

        const char* after = next;
        while (after && *after == '/') after++;
        bool is_last = (!after || *after == '\0');

        if (is_last && (flags & LOOKUP_PARENT)) {
            result->de = current_de;
            result->mnt = task->fs->root.mnt;
            return 0;
        }

        dentry* child = walk_component(current_de, &component);

        int64 err = reinterpret_cast<int64>(child);
        if (err < 0 && err >= -4095) {
            dput(current_de);
            return static_cast<int>(err);
        }

        /* ---- Symlink following (Linux: step_into → pick_link) ----
         * If the resolved component is a symlink, follow it.
         * Linux limits this to MAXSYMLINKS (40); we use 8. */
        constexpr int kMaxSymlinks = 8;
        int symlink_depth = 0;
        while (child->d_inode && S_ISLNK(child->d_inode->i_mode) &&
               child->d_inode->i_link && symlink_depth < kMaxSymlinks) {
            symlink_depth++;
            const char* target = child->d_inode->i_link;
            dput(child);

            /* Absolute symlink: restart from root.
             * Relative symlink: resolve from current parent. */
            dentry* link_start;
            if (target[0] == '/') {
                link_start = dget(task->fs->root.de ? task->fs->root.de : g_root_dentry);
                target++;
            } else {
                link_start = dget(current_de);
            }

            /* Walk each component of the symlink target */
            dentry* link_cur = link_start;
            const char* lp = target;
            qstr lcomp;
            while (lp && *lp) {
                const char* lnext = next_component(lp, &lcomp);
                if (!lnext && lcomp.len == 0) break;

                dentry* lchild = walk_component(link_cur, &lcomp);
                int64 lerr = reinterpret_cast<int64>(lchild);
                if (lerr < 0 && lerr >= -4095) {
                    dput(link_cur);
                    dput(current_de);
                    return static_cast<int>(lerr);
                }

                dput(link_cur);
                link_cur = lchild;
                lp = lnext;
            }

            child = link_cur;
        }

        if (symlink_depth >= kMaxSymlinks) {
            dput(child);
            dput(current_de);
            return -ELOOP;
        }

        if (!is_last && child->d_inode && !S_ISDIR(child->d_inode->i_mode)) {
            dput(child);
            dput(current_de);
            return -ENOTDIR;
        }

        if (!is_last && !child->d_inode) {
            dput(child);
            dput(current_de);
            return -ENOENT;
        }

        dput(current_de);
        current_de = child;
        p = next;
    }

    if ((flags & LOOKUP_DIRECTORY) && current_de->d_inode &&
        !S_ISDIR(current_de->d_inode->i_mode)) {
        dput(current_de);
        return -ENOTDIR;
    }

    /* Negative dentry: the path was walked, but the final component
     * does not exist (d_inode == NULL).  Return -ENOENT. */
    if (!current_de->d_inode) {
        dput(current_de);
        return -ENOENT;
    }

    result->de = current_de;
    result->mnt = task->fs->root.mnt;
    return 0;
}

int kern_path(const char* name, unsigned int flags, path* result)
{
    return filename_lookup(AT_FDCWD, name, flags, result);
}

dentry* lookup_one_len(const char* name, dentry* parent, int len)
{
    qstr q;
    q.name = name;
    q.len = static_cast<uint32>(len);
    q.hash = full_name_hash(name, q.len);

    return walk_component(parent, &q);
}

void namei_init() {}
