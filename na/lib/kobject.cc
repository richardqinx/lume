/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * kobject — implementation.
 *
 * Lives in lib/ (mirroring Linux's lib/kobject.c) because kobject is a
 * generic primitive, not tied to the driver model.
 *
 * Reference: docs/specs/storage_stack.md §4.2
 */

#include <lume/kobject.h>
#include <lume/container_of.h>
#include <lume/klog.h>

void kobject_init(kobject* k, const kobj_type* type)
{
    if (k == nullptr) {
        return;
    }
    k->name = nullptr;
    k->parent = nullptr;
    k->ktype = type;
    k->state_in_sysfs = false;
    k->entry.init();
    k->children.init();
    k->lock.init("kobject");
    kref_init(&k->refcount);
}

int kobject_add(kobject* k, kobject* parent, const char* name)
{
    if (k == nullptr) {
        return -1;
    }
    k->name = name;
    if (parent != nullptr) {
        kobject_get(parent);
        k->parent = parent;
        LockGuard g(parent->lock);
        list_add_tail(&k->entry, &parent->children);
    }
    return 0;
}

void kobject_del(kobject* k)
{
    if (k == nullptr || k->parent == nullptr) {
        return;
    }
    kobject* parent = k->parent;
    {
        LockGuard g(parent->lock);
        list_del_init(&k->entry);
    }
    k->parent = nullptr;
    kobject_put(parent);
}

void kobject_get(kobject* k)
{
    if (k != nullptr) {
        kref_get(&k->refcount);
    }
}

static void kobject_release(kref* r)
{
    kobject* k = container_of(r, kobject, refcount);
    if (k->ktype != nullptr && k->ktype->release != nullptr) {
        k->ktype->release(k);
    }
}

void kobject_put(kobject* k)
{
    if (k == nullptr) {
        return;
    }
    kref_put(&k->refcount, kobject_release);
}
