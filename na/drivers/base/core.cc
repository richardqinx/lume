/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * drivers/base/core.cc — device core.
 *
 * Mirrors Linux drivers/base/core.c (greatly simplified).  Provides
 * device_initialize, device_register, device_unregister, and the
 * try_bind helper shared with driver registration.
 *
 * Reference: docs/specs/storage_stack.md §4.3
 */

#include <lume/device.h>
#include <lume/container_of.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/errno.h>
#include <lume/list.h>

/* ------------------------------------------------------------------ */
/*  device ktype — generic release (no-op; subclasses override)       */
/* ------------------------------------------------------------------ */

static void device_release(kobject* kobj)
{
    /* Concrete device flavors (platform_device, virtio_device, ...) are
     * expected to allocate via kmalloc and free in their own release
     * paths after device_unregister + final kobject_put.  The generic
     * device kobj_type only fires for stack-allocated devices used in
     * tests — nothing to do. */
    (void)kobj;
}

static const kobj_type device_ktype = {
    .release = device_release,
};

/* ------------------------------------------------------------------ */
/*  device_initialize / device_register                                */
/* ------------------------------------------------------------------ */

void device_initialize(device* dev)
{
    if (dev == nullptr) {
        return;
    }
    kobject_init(&dev->kobj, &device_ktype);
    dev->parent = nullptr;
    dev->driver = nullptr;
    dev->driver_data = nullptr;
    dev->platform_data = nullptr;
    dev->devt = 0;
    dev->bus_list.init();
    dev->driver_list.init();
}

const char* dev_name(const device* dev)
{
    if (dev == nullptr) {
        return "(null)";
    }
    if (dev->kobj.name != nullptr) {
        return dev->kobj.name;
    }
    if (dev->init_name != nullptr) {
        return dev->init_name;
    }
    return "(unnamed)";
}

/* try_bind: attempt to match `dev` against `drv` and probe.
 * Returns 1 on successful bind, 0 otherwise.
 * Caller must hold bus->lock. */
int device_try_bind(device* dev, device_driver* drv);

int device_try_bind(device* dev, device_driver* drv)
{
    bus_type* bus = dev->bus;

    if (bus->match != nullptr && bus->match(dev, drv) == 0) {
        return 0;
    }

    dev->driver = drv;

    int rc = 0;
    if (bus->probe != nullptr) {
        rc = bus->probe(dev);
    } else if (drv->probe != nullptr) {
        rc = drv->probe(dev);
    }

    if (rc == 0) {
        list_add_tail(&dev->driver_list, &drv->devices);
        return 1;
    }
    dev->driver = nullptr;
    return 0;
}

int device_register(device* dev)
{
    if (dev == nullptr || dev->bus == nullptr) {
        return -EINVAL;
    }
    if (!dev->bus->registered) {
        kprintf("[device] register '%s' fail: bus '%s' not registered\n",
                dev_name(dev),
                dev->bus->name != nullptr ? dev->bus->name : "?");
        return -ENODEV;
    }

    /* device_initialize is idempotent — safe to call again, but most
     * paths will already have initialized.  Detect via ktype set. */
    if (dev->kobj.ktype == nullptr) {
        device_initialize(dev);
    }
    if (dev->kobj.name == nullptr) {
        kobject_add(&dev->kobj, nullptr, dev->init_name);
    }
    dev->bus_list.init();
    dev->driver_list.init();

    LockGuard g(dev->bus->lock);
    list_add_tail(&dev->bus_list, &dev->bus->devices);

    list_node* cur = dev->bus->drivers.next;
    while (cur != &dev->bus->drivers) {
        device_driver* drv =
            list_entry<device_driver, &device_driver::bus_node>(cur);
        cur = cur->next;
        if (device_try_bind(dev, drv) != 0) {
            break;
        }
    }
    return 0;
}

void device_unregister(device* dev)
{
    if (dev == nullptr || dev->bus == nullptr) {
        return;
    }

    LockGuard g(dev->bus->lock);

    if (dev->driver != nullptr) {
        if (dev->driver->remove != nullptr) {
            dev->driver->remove(dev);
        }
        list_del_init(&dev->driver_list);
        dev->driver = nullptr;
    }
    list_del_init(&dev->bus_list);
}
