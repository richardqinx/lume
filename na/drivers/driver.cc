/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/driver.h>
#include <lume/fdt.h>
#include <lume/kprintf.h>

extern "C" {
    extern DriverEntry __drivers_start[];
    extern DriverEntry __drivers_end[];
}

void driver_probe_all() {
    DeviceNode* root = fdt_get_node_by_path("/");
    if (!root) {
        kprintf("[driver] WARN: No FDT root found\n");
        return;
    }

    for (DriverEntry* drv = __drivers_start; drv < __drivers_end; ++drv) {
        DeviceNode* node = fdt_find_compatible(drv->compatible);
        if (node) {
            kprintf("[driver] Probing %s\n", drv->compatible);
            drv->probe(node);
        }
    }
}
