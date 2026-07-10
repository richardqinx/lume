/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * drivers/base/driver.cc — driver_register / driver_unregister.
 *
 * Mirrors Linux drivers/base/driver.c.  Registers a device_driver on
 * its bus and tries to bind any unbound matching devices.
 *
 * Reference: docs/specs/storage_stack.md §4.3
 */

#include <lume/device.h>
#include <lume/container_of.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/errno.h>

/* Implemented in core.cc — bind a device to a driver on its bus.
 * Returns 1 on success, 0 on no-match-or-probe-fail. */
int device_try_bind(device* dev, device_driver* drv);

int driver_register(device_driver* drv)
{
    if (drv == nullptr || drv->bus == nullptr) {
        return -EINVAL;
    }
    if (!drv->bus->registered) {
        kprintf("[driver] register '%s' fail: bus '%s' not registered\n",
                drv->name != nullptr ? drv->name : "?",
                drv->bus->name != nullptr ? drv->bus->name : "?");
        return -ENODEV;
    }

    drv->bus_node.init();
    drv->devices.init();

    LockGuard g(drv->bus->lock);
    list_add_tail(&drv->bus_node, &drv->bus->drivers);

    /* Try to bind any unbound devices already on the bus. */
    list_node* cur = drv->bus->devices.next;
    while (cur != &drv->bus->devices) {
        device* dev = list_entry<device, &device::bus_list>(cur);
        cur = cur->next;
        if (dev->driver == nullptr) {
            device_try_bind(dev, drv);
        }
    }
    return 0;
}

void driver_unregister(device_driver* drv)
{
    if (drv == nullptr || drv->bus == nullptr) {
        return;
    }

    LockGuard g(drv->bus->lock);

    /* Unbind every device bound to this driver. */
    while (!drv->devices.is_empty()) {
        list_node* first = drv->devices.next;
        device* dev = list_entry<device, &device::driver_list>(first);
        if (drv->remove != nullptr) {
            drv->remove(dev);
        }
        list_del_init(&dev->driver_list);
        dev->driver = nullptr;
    }
    list_del_init(&drv->bus_node);
}
