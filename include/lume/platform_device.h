/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * platform_device / platform_driver — FDT-described memory-mapped devices.
 *
 * Mirrors Linux include/linux/platform_device.h.  The platform bus is
 * the catch-all bus for devices that don't live on a real bus like PCI
 * or USB — every device discovered via the FDT lands here.
 *
 * Reference: docs/specs/storage_stack.md §4.3
 */

#include <lume/types.h>
#include <lume/device.h>

class DeviceNode;

/* Compatible-string -> driver-private data table (Linux's of_device_id). */
struct of_device_id {
    const char* compatible;
    const void* data;
};

struct platform_device {
    device         dev;
    DeviceNode*    of_node;     // FDT node this device came from
    uint64         mmio_base;   // first `reg` cell from FDT (0 if none)
    uint64         mmio_size;   // second `reg` cell (0 if none)
    int            irq;         // first interrupt (-1 if none / not parsed)
};

struct platform_driver {
    device_driver           driver;
    int                     (*probe)(platform_device*);
    void                    (*remove)(platform_device*);
    const of_device_id*     of_match_table;     // NULL-terminated array
};

extern bus_type platform_bus;

void platform_bus_init();
int  platform_driver_register(platform_driver* drv);
int  platform_device_register(platform_device* pdev);

/* Helper: pull current driver out of a probed device. */
inline platform_driver* to_platform_driver(device_driver* drv)
{
    return container_of(drv, platform_driver, driver);
}
inline platform_device* to_platform_device(device* dev)
{
    return container_of(dev, platform_device, dev);
}

/* Linker-set registration macro — drop a pointer to your platform_driver
 * into the .drivers section.  driver_probe_all() iterates this set at
 * boot.  Use a unique token in CONCAT to avoid name collisions. */
#define PLATFORM_DRIVER(_drv)                                                \
    extern platform_driver _drv;                                             \
    static platform_driver* const __pdrv_ptr_##_drv                          \
        __attribute__((used, section(".drivers"))) = &_drv
