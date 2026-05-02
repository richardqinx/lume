/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Driver Registration Subsystem
 *
 * Provides a linker-set based registration mechanism for hardware drivers.
 * Drivers define a probe function and register it with the REGISTER_DRIVER macro.
 * During boot, driver_probe_all() scans the Device Tree (FDT) and invokes the
 * probe function for any matching compatible strings.
 *
 * This decouples the MI kernel initialization from MD driver specifics.
 */

#include <lume/types.h>

class DeviceNode;

using DriverProbeFunc = void (*)(DeviceNode* node);

struct DriverEntry {
    const char* compatible;
    DriverProbeFunc probe;
};

#define REGISTER_DRIVER(compat_str, probe_fn) \
    static const DriverEntry __driver_##probe_fn \
    __attribute__((used, section(".drivers"))) = { compat_str, probe_fn }

/* MI initialization function called from kernel_main() */
void driver_probe_all();
