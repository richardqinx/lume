// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 */
#include "common/types.h"
#include "kernel/riscv.h"
#include "drivers/plic.h"
#include "drivers/uart.h"
#include "kernel/fdt.h"

// Helper Macros — all relative to PLIC base from FDT
#define PLIC_BASE      (g_devices.plic.base_addr)
#define PLIC_PRIORITY  (PLIC_BASE + 0x0)
#define PLIC_PENDING   (PLIC_BASE + 0x1000)

#define PLIC_SENABLE_ADDR(hart) (PLIC_BASE + 0x2080 + (hart) * 0x100)
#define PLIC_STHRESHOLD_ADDR(hart) (PLIC_BASE + 0x201000 + (hart) * 0x2000)
#define PLIC_SCLAIM_ADDR(hart) (PLIC_BASE + 0x201004 + (hart) * 0x2000)

// Helper for Volatile Access
static inline volatile uint32 *REG32(uint64 addr)
{
    return reinterpret_cast<volatile uint32 *>(addr);
}

namespace PLIC
{
    void init()
    {
        // Set priority for UART IRQ
        if (g_devices.uart.irq > 0)
            *REG32(PLIC_PRIORITY + g_devices.uart.irq * 4) = 1;

        // Set priority for all VirtIO IRQs
        for (int i = 0; i < g_devices.virtio_count; i++)
        {
            if (g_devices.virtio[i].irq > 0)
                *REG32(PLIC_PRIORITY + g_devices.virtio[i].irq * 4) = 1;
        }
    }

    void inithart()
    {
        int hart = static_cast<int>(r_tp());

        // Build enable bitmask from discovered devices
        uint32 enable = 0;

        if (g_devices.uart.irq > 0 && g_devices.uart.irq < 32)
            enable |= (1 << g_devices.uart.irq);

        for (int i = 0; i < g_devices.virtio_count; i++)
        {
            if (g_devices.virtio[i].irq > 0 && g_devices.virtio[i].irq < 32)
                enable |= (1 << g_devices.virtio[i].irq);
        }

        *REG32(PLIC_SENABLE_ADDR(hart)) = enable;

        // Set Priority Threshold to 0 (Allow all)
        *REG32(PLIC_STHRESHOLD_ADDR(hart)) = 0;

        Drivers::uart_puts("[PLIC] Hart Init Done.\n");
    }

    int claim()
    {
        int hart = static_cast<int>(r_tp());
        return *REG32(PLIC_SCLAIM_ADDR(hart));
    }

    void complete(int irq)
    {
        int hart = static_cast<int>(r_tp());
        *REG32(PLIC_SCLAIM_ADDR(hart)) = static_cast<uint32>(irq);
    }
}