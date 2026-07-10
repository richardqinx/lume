// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 * LumeOS - FDT Parser
 *
 * Parses the Flattened Device Tree to discover hardware.
 * Populates g_devices for use by all drivers.
 */
#include "common/types.h"
#include "kernel/fdt.h"
#include "lib/string.h"

// Global device registry
DeviceRegistry g_devices;

// Keep g_dtb_addr for PMM to protect DTB pages
// g_dtb_addr is defined in entry.S, g_uart_base in config.cc
extern "C" uint64 g_dtb_addr;
extern uint64 g_uart_base;

static inline uint32 bswap(uint32 x)
{
    return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) |
           ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF);
}

struct fdt_header
{
    uint32 magic;
    uint32 totalsize;
    uint32 off_dt_struct;
    uint32 off_dt_strings;
    uint32 off_mem_rsvmap;
    uint32 version;
    uint32 last_comp_version;
    uint32 boot_cpuid_phys;
    uint32 size_dt_strings;
    uint32 size_dt_struct;
};

#define FDT_MAGIC 0xd00dfeed
#define FDT_BEGIN_NODE 1
#define FDT_END_NODE 2
#define FDT_PROP 3
#define FDT_NOP 4
#define FDT_END 9

// Check if 'str' starts with 'prefix'
static bool starts_with(const char *str, const char *prefix)
{
    while (*prefix)
    {
        if (*str != *prefix)
            return false;
        str++;
        prefix++;
    }
    return true;
}

// Check if 'haystack' contains 'needle' as a substring within 'len' bytes
// (compatible strings may have multiple null-separated entries)
static bool compat_match(const uint8 *data, uint32 len, const char *needle)
{
    uint32 nlen = strlen(needle);
    for (uint32 i = 0; i + nlen <= len; i++)
    {
        if (memcmp(data + i, needle, nlen) == 0)
            return true;
    }
    return false;
}

// Add a MMIO region to the registry (avoids duplicates)
static void add_mmio_region(uint64 base, uint64 size)
{
    if (base == 0 || size == 0)
        return;
    // Only track I/O regions below RAM
    if (base >= 0x80000000ULL)
        return;
    if (g_devices.mmio_count >= DeviceRegistry::MAX_MMIO)
        return;

    // Check for overlap/duplicate
    for (int i = 0; i < g_devices.mmio_count; i++)
    {
        if (g_devices.mmio_regions[i].base == base)
            return;
    }

    g_devices.mmio_regions[g_devices.mmio_count].base = base;
    g_devices.mmio_regions[g_devices.mmio_count].size = size;
    g_devices.mmio_count++;
}

void fdt_parse(uint64 dtb)
{
    // Clear registry
    memset(&g_devices, 0, sizeof(g_devices));

    if (dtb == 0)
        return;

    g_dtb_addr = dtb;

    struct fdt_header *header = (struct fdt_header *)dtb;
    if (bswap(header->magic) != FDT_MAGIC)
        return;

    uint8 *struct_ptr = (uint8 *)(dtb + bswap(header->off_dt_struct));
    char *strings_ptr = (char *)(dtb + bswap(header->off_dt_strings));

    // Parsing state
    char current_node_name[64];
    current_node_name[0] = '\0';

    // Per-node state
    uint64 current_reg_addr = 0;
    uint64 current_reg_size = 0;
    uint32 current_irq = 0;
    const uint8 *current_compat = nullptr;
    uint32 current_compat_len = 0;
    bool has_reg = false;
    bool has_compat = false;
    // bool has_irq = false; // Unused

    // Depth tracking (for #address-cells / #size-cells)
    // Default for root: 2 address-cells, 2 size-cells
    int depth = 0;

    while (1)
    {
        uint32 token = bswap(*(uint32 *)struct_ptr);
        struct_ptr += 4;

        if (token == FDT_END)
            break;
        if (token == FDT_NOP)
            continue;

        if (token == FDT_BEGIN_NODE)
        {
            // Save node name
            // char *name = (char *)struct_ptr;
            int i = 0;
            while (*struct_ptr != 0 && i < 63)
            {
                current_node_name[i++] = *struct_ptr;
                struct_ptr++;
            }
            current_node_name[i] = '\0';
            while (*struct_ptr != 0)
                struct_ptr++;
            struct_ptr++;
            struct_ptr = (uint8 *)(((uint64)struct_ptr + 3) & ~3);

            // Reset per-node state
            current_reg_addr = 0;
            current_reg_size = 0;
            current_irq = 0;
            current_compat = nullptr;
            current_compat_len = 0;
            has_reg = false;
            has_compat = false;
            // has_irq = false;

            depth++;
        }
        else if (token == FDT_END_NODE)
        {
            // Process the node we just finished
            if (has_reg && has_compat)
            {
                // UART: ns16550a
                if (compat_match(current_compat, current_compat_len, "ns16550"))
                {
                    g_devices.uart.base_addr = current_reg_addr;
                    g_devices.uart.size = current_reg_size ? current_reg_size : 0x100;
                    g_devices.uart.irq = current_irq;
                    add_mmio_region(current_reg_addr, g_devices.uart.size);
                }
                // PLIC
                else if (compat_match(current_compat, current_compat_len, "plic"))
                {
                    g_devices.plic.base_addr = current_reg_addr;
                    g_devices.plic.size = current_reg_size ? current_reg_size : 0x4000000;
                    g_devices.plic.irq = 0;
                    add_mmio_region(current_reg_addr, g_devices.plic.size);
                }
                // CLINT
                else if (compat_match(current_compat, current_compat_len, "clint"))
                {
                    g_devices.clint.base_addr = current_reg_addr;
                    g_devices.clint.size = current_reg_size ? current_reg_size : 0x10000;
                    g_devices.clint.irq = 0;
                    add_mmio_region(current_reg_addr, g_devices.clint.size);
                }
                // VirtIO
                else if (compat_match(current_compat, current_compat_len, "virtio"))
                {
                    if (g_devices.virtio_count < DeviceRegistry::MAX_VIRTIO)
                    {
                        int idx = g_devices.virtio_count++;
                        g_devices.virtio[idx].base_addr = current_reg_addr;
                        g_devices.virtio[idx].size = current_reg_size ? current_reg_size : 0x1000;
                        g_devices.virtio[idx].irq = current_irq;
                        add_mmio_region(current_reg_addr, g_devices.virtio[idx].size);
                    }
                }
            }

            // Memory node: name starts with "memory"
            if (has_reg && starts_with(current_node_name, "memory"))
            {
                g_devices.mem_base = current_reg_addr;
                g_devices.mem_size = current_reg_size;
            }

            depth--;
        }
        else if (token == FDT_PROP)
        {
            uint32 len = bswap(*(uint32 *)struct_ptr);
            struct_ptr += 4;
            uint32 nameoff = bswap(*(uint32 *)struct_ptr);
            struct_ptr += 4;

            char *name = strings_ptr + nameoff;
            uint8 *data = struct_ptr;

            struct_ptr += len;
            struct_ptr = (uint8 *)(((uint64)struct_ptr + 3) & ~3);

            if (strcmp(name, "reg") == 0 && len >= 8)
            {
                // Assume 2 address-cells, 2 size-cells (standard for QEMU virt)
                uint32 hi = bswap(*(uint32 *)data);
                uint32 lo = bswap(*(uint32 *)(data + 4));
                current_reg_addr = ((uint64)hi << 32) | lo;

                if (len >= 16)
                {
                    uint32 shi = bswap(*(uint32 *)(data + 8));
                    uint32 slo = bswap(*(uint32 *)(data + 12));
                    current_reg_size = ((uint64)shi << 32) | slo;
                }
                has_reg = true;
            }
            else if (strcmp(name, "compatible") == 0)
            {
                current_compat = data;
                current_compat_len = len;
                has_compat = true;
            }
            else if (strcmp(name, "interrupts") == 0 && len >= 4)
            {
                current_irq = bswap(*(uint32 *)data);
                // has_irq = true;
            }
            else if (strcmp(name, "interrupts-extended") == 0 && len >= 8)
            {
                // interrupts-extended = <&phandle irq_num>
                // IRQ number is typically the second cell
                current_irq = bswap(*(uint32 *)(data + 4));
                // has_irq = true;
            }
        }
    }

    // Legacy compat
    g_uart_base = g_devices.uart.base_addr;
}