// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 * LumeOS - FDT Device Discovery
 */

#pragma once
#include "common/types.h"

// Single device descriptor (populated from FDT)
struct FdtDevice {
    uint64 base_addr;    // MMIO base address
    uint64 size;         // MMIO region size
    uint32 irq;          // Interrupt number (0 = none)
};

// Device registry — populated by fdt_parse(), consumed by drivers
struct DeviceRegistry {
    // Memory
    uint64 mem_base;
    uint64 mem_size;

    // Core platform devices
    FdtDevice uart;
    FdtDevice plic;
    FdtDevice clint;

    // VirtIO devices (multiple possible)
    static constexpr int MAX_VIRTIO = 8;
    FdtDevice virtio[MAX_VIRTIO];
    int virtio_count;

    // MMIO ranges for kvminit() to map
    static constexpr int MAX_MMIO = 16;
    struct MmioRegion {
        uint64 base;
        uint64 size;
    } mmio_regions[MAX_MMIO];
    int mmio_count;
};

extern DeviceRegistry g_devices;

// Parse FDT and populate g_devices
void fdt_parse(uint64 dtb);
