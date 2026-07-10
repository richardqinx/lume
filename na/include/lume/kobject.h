/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * kobject — generic refcounted object with parent/child relationship.
 *
 * Mirrors Linux include/linux/kobject.h.  Embedded into device, gendisk,
 * request_queue, block_device, etc.  Each kobject has a kobj_type that
 * provides the release callback called when the last reference drops.
 *
 * sysfs integration is not yet implemented — the sd/sysfs_ops fields are
 * reserved for future use.
 *
 * Reference: docs/specs/storage_stack.md §4.2
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/kref.h>
#include <kernel/sync/spinlock.h>

struct kobj_type;

struct kobject {
    const char*       name;
    kobject*          parent;
    kref              refcount;
    const kobj_type*  ktype;
    list_node         entry;       // node in parent->children
    list_node         children;    // head of children list
    Spinlock          lock;
    bool              state_in_sysfs;   // reserved, always false for now
};

struct kobj_type {
    void (*release)(kobject*);
    /* sysfs_ops + default_attrs: reserved for future sysfs implementation. */
};

/* Initialize a kobject in place; refcount starts at 1.
 * Caller must provide a non-null ktype with a valid release(). */
void kobject_init(kobject* k, const kobj_type* type);

/* Link `k` under `parent` (which may be null for a detached root).
 * Caller passes a stable `name` pointer (e.g. a static string or an
 * already-strdup'd buffer); kobject does not own the name string. */
int  kobject_add(kobject* k, kobject* parent, const char* name);

/* Unlink from parent.  Does NOT drop the final ref — caller decides
 * when to kobject_put(). */
void kobject_del(kobject* k);

/* Bump / drop reference. */
void kobject_get(kobject* k);
void kobject_put(kobject* k);
