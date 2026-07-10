/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * driver.h — boot-time driver probing entry point.
 *
 * The actual driver-model primitives (kobject, device, bus_type,
 * platform_device, platform_driver) live in their own headers:
 *   <lume/kobject.h>, <lume/device.h>, <lume/platform_device.h>.
 *
 * This header just exposes the single boot entry point that
 * kernel_main() calls after the slab allocator + FDT unflatten are
 * ready.  The implementation lives in drivers/base/platform.cc.
 *
 * Reference: docs/specs/storage_stack.md §4
 */

/* Register the platform bus, register every linker-set platform_driver,
 * walk the FDT, and instantiate a platform_device for each compatible
 * match.  Each device is bound to its driver via the platform bus
 * match/probe path.  Returns after all probes have run. */
void driver_probe_all();
