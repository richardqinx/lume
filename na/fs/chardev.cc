/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * chardev.cc — Character device registry
 *
 * Simple linked list of registered cdevs, searched by dev number.
 */

#include <lume/chardev.h>
#include <lume/list.h>
#include <lume/klog.h>
#include <kernel/sync/spinlock.h>

static list_node g_cdev_list;
static Spinlock  g_cdev_lock;

void cdev_init()
{
    list_init(&g_cdev_list);
}

void cdev_register(cdev* dev)
{
    LockGuard guard(g_cdev_lock);
    list_init(&dev->list);
    list_add_tail(&dev->list, &g_cdev_list);
    printk("[cdev] registered '%s' (%d,%d)\n",
           dev->name, MAJOR(dev->dev), MINOR(dev->dev));
}

cdev* cdev_find(uint32 dev_nr)
{
    LockGuard guard(g_cdev_lock);
    list_node* pos;
    for (pos = g_cdev_list.prev; pos != &g_cdev_list; pos = pos->prev) {
        cdev* cd = container_of(pos, cdev, list);
        if (cd->dev == dev_nr) {
            return cd;
        }
    }
    return nullptr;
}
