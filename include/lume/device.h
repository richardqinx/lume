/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Driver model: device, device_driver, bus_type.
 *
 * Mirrors Linux include/linux/device.h.  Every hardware unit embeds a
 * `device` and binds to a `device_driver` via a `bus_type` that knows
 * how to match the two.  Buses we will have:
 *   - platform: FDT-described memory-mapped devices (this commit)
 *   - virtio:   virtio-mmio devices (P5 of storage_stack.md)
 *
 * Reference: docs/specs/storage_stack.md §4.3
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/kobject.h>
#include <kernel/sync/spinlock.h>

struct bus_type;
struct device_driver;

struct device {
    kobject             kobj;          // embedded; first member by convention
    device*             parent;
    const char*         init_name;     // used until kobj.name is set
    bus_type*           bus;
    device_driver*      driver;
    void*               driver_data;
    void*               platform_data;
    uint32              devt;          // for char/block dev_t allocation
    list_node           bus_list;      // node in bus->devices
    list_node           driver_list;   // node in driver->devices
};

struct device_driver {
    const char*         name;
    bus_type*           bus;
    int                 (*probe)(device*);
    void                (*remove)(device*);
    list_node           bus_node;      // node in bus->drivers
    list_node           devices;       // head of devices bound to this driver
};

struct bus_type {
    const char*         name;
    int                 (*match)(device*, device_driver*);
    /* If non-null, this is the bus-level probe dispatcher.  It is called
     * before drv->probe and is responsible for downcasting device/driver
     * to the concrete bus type and forwarding (e.g. platform_dispatch). */
    int                 (*probe)(device*);
    list_node           devices;
    list_node           drivers;
    Spinlock            lock;
    bool                registered;
};

int  bus_register   (bus_type* bus);

/* device_initialize: kobject_init the embedded kobj with the generic
 * device_ktype.  device_register calls this automatically if the caller
 * hasn't already.  Separate entry point for callers that want a half-
 * initialized device (so they can take refs before adding). */
void device_initialize(device* dev);
int  device_register  (device* dev);
void device_unregister(device* dev);

int  driver_register  (device_driver* drv);
void driver_unregister(device_driver* drv);

/* Convenience accessor — name from kobject if set, else init_name. */
const char* dev_name(const device* dev);
