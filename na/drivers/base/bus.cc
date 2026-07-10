/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * drivers/base/bus.cc — bus_type registration.
 *
 * Mirrors Linux drivers/base/bus.c.  Trivial in this iteration:
 * initialize the device/driver lists and the per-bus spinlock.
 *
 * Reference: docs/specs/storage_stack.md §4.3
 */

#include <lume/device.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/errno.h>

int bus_register(bus_type* bus)
{
    if (bus == nullptr || bus->name == nullptr) {
        return -EINVAL;
    }
    if (bus->registered) {
        return 0;
    }
    bus->devices.init();
    bus->drivers.init();
    bus->lock.init(bus->name);
    bus->registered = true;
    kprintf("[bus] '%s' registered\n", bus->name);
    return 0;
}
