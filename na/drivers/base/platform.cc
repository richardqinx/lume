/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * drivers/base/platform.cc — platform bus + FDT-driven device creation.
 *
 * Mirrors Linux drivers/base/platform.c.  Provides:
 *   - platform_bus       — the bus_type instance
 *   - platform_match     — compatible-string matching via of_match_table
 *   - platform_dispatch  — bus->probe forwarder that down-casts and calls
 *                          platform_driver::probe(platform_device*)
 *   - driver_probe_all() — boot entry: register bus, register linker-set
 *                          drivers, walk FDT, register platform_devices
 *
 * Reference: docs/specs/storage_stack.md §4.3
 */

#include <lume/platform_device.h>
#include <lume/driver.h>
#include <lume/device_node.h>
#include <lume/fdt.h>
#include <string.h>

/* kmalloc is declared extern "C" in <lume/slab.h>, but mm/slab.cc defines
 * it WITHOUT extern "C" (i.e. C++-mangled).  Declare locally with C++
 * linkage so the symbol matches what mm/slab.o exports. */
void* kmalloc(uint32 size);
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/errno.h>
#include <lume/container_of.h>

/* ------------------------------------------------------------------ */
/*  Linker-section registry                                            */
/* ------------------------------------------------------------------ */

extern "C" {
    extern platform_driver* __drivers_start[];
    extern platform_driver* __drivers_end[];
}

/* ------------------------------------------------------------------ */
/*  platform_bus_type                                                  */
/* ------------------------------------------------------------------ */

static int platform_match(device* dev, device_driver* drv)
{
    platform_device* pdev = to_platform_device(dev);
    platform_driver* pdrv = to_platform_driver(drv);

    if (pdrv->of_match_table == nullptr || pdev->of_node == nullptr) {
        return 0;
    }
    const char* node_compat = pdev->of_node->get_prop_string("compatible");
    if (node_compat == nullptr) {
        return 0;
    }
    for (const of_device_id* id = pdrv->of_match_table;
         id->compatible != nullptr; ++id) {
        if (strcmp(id->compatible, node_compat) == 0) {
            return 1;
        }
    }
    return 0;
}

static int platform_dispatch(device* dev)
{
    platform_device* pdev = to_platform_device(dev);
    platform_driver* pdrv = to_platform_driver(dev->driver);
    if (pdrv->probe == nullptr) {
        return 0;
    }
    return pdrv->probe(pdev);
}

bus_type platform_bus = {
    .name       = "platform",
    .match      = platform_match,
    .probe      = platform_dispatch,
    .devices    = {},
    .drivers    = {},
    .lock       = {},
    .registered = false,
};

void platform_bus_init()
{
    bus_register(&platform_bus);
}

/* ------------------------------------------------------------------ */
/*  platform_driver_register / platform_device_register                */
/* ------------------------------------------------------------------ */

int platform_driver_register(platform_driver* pdrv)
{
    if (pdrv == nullptr) {
        return -EINVAL;
    }
    pdrv->driver.bus = &platform_bus;
    /* driver.probe is unused — we route through bus->probe. Set name
     * from the first of_match if not already provided. */
    if (pdrv->driver.name == nullptr && pdrv->of_match_table != nullptr) {
        pdrv->driver.name = pdrv->of_match_table[0].compatible;
    }
    return driver_register(&pdrv->driver);
}

int platform_device_register(platform_device* pdev)
{
    if (pdev == nullptr) {
        return -EINVAL;
    }
    pdev->dev.bus = &platform_bus;
    if (pdev->dev.init_name == nullptr && pdev->of_node != nullptr) {
        pdev->dev.init_name = pdev->of_node->get_prop_string("compatible");
    }
    device_initialize(&pdev->dev);
    return device_register(&pdev->dev);
}

/* ------------------------------------------------------------------ */
/*  FDT-driven device instantiation                                    */
/* ------------------------------------------------------------------ */

static platform_device* alloc_platform_device_from_node(DeviceNode* node,
                                                        const char* compat)
{
    auto* pdev = static_cast<platform_device*>(
        kmalloc(static_cast<uint32>(sizeof(platform_device))));
    if (pdev == nullptr) {
        return nullptr;
    }
    memset(pdev, 0, sizeof(*pdev));
    pdev->of_node = node;
    pdev->mmio_base = node->get_prop_u64("reg", 0);
    /* "reg" second cell is size — for now we don't bother parsing it
     * separately; drivers that need it pull from of_node directly. */
    pdev->mmio_size = 0;
    pdev->irq = -1;
    pdev->dev.init_name = compat;
    return pdev;
}

/* For each registered platform_driver, walk its of_match_table and
 * spawn a platform_device for each FDT compatible match found.
 *
 * NOTE: This is a simplified FDT walker — it only finds the FIRST FDT
 * node matching each compatible string (delegating to
 * fdt_find_compatible).  Devices with multiple FDT instances of the
 * same compatible will only see one bound here.  A full FDT tree walk
 * is left for when virtio-mmio or multi-instance UART arrives.
 */
static void instantiate_devices_for_driver(platform_driver* pdrv)
{
    if (pdrv == nullptr || pdrv->of_match_table == nullptr) {
        return;
    }
    for (const of_device_id* id = pdrv->of_match_table;
         id->compatible != nullptr; ++id) {
        DeviceNode* node = fdt_find_compatible(id->compatible);
        if (node == nullptr) {
            continue;
        }
        platform_device* pdev =
            alloc_platform_device_from_node(node, id->compatible);
        if (pdev == nullptr) {
            kprintf("[platform] OOM allocating pdev for %s\n", id->compatible);
            continue;
        }
        kprintf("[platform] instantiating '%s' -> pdev mmio=0x%llx\n",
                id->compatible, pdev->mmio_base);
        platform_device_register(pdev);
    }
}

/* ------------------------------------------------------------------ */
/*  Boot entry — replaces the old driver_probe_all()                   */
/* ------------------------------------------------------------------ */

void driver_probe_all()
{
    kprintf("[dpa] step 1: &platform_bus=%p (link 0xffffffc08033a0a8)\n",
            &platform_bus);
    kprintf("[dpa] step 1: pre-touch platform_bus.name slot...\n");
    const char** name_slot = &platform_bus.name;
    kprintf("[dpa] step 1: name_slot=%p\n", name_slot);
    kprintf("[dpa] step 1: about to deref *name_slot\n");
    const char* nm = *name_slot;
    kprintf("[dpa] step 1: *name_slot=%p\n", nm);
    kprintf("[dpa] step 1: about to read first byte of nm\n");
    char first = nm != nullptr ? nm[0] : '!';
    kprintf("[dpa] step 1: nm[0]='%c'\n", first);

    kprintf("[dpa] step 1: platform_bus_init enter\n");
    platform_bus_init();
    kprintf("[dpa] step 1: platform_bus_init done\n");

    platform_driver** start = __drivers_start;
    platform_driver** end   = __drivers_end;
    kprintf("[dpa] step 2: __drivers_start=%p __drivers_end=%p count=%lld\n",
            start, end, (long long)(end - start));

    for (platform_driver** slot = start; slot < end; ++slot) {
        kprintf("[dpa] step 2: slot=%p *slot=%p\n", slot, *slot);
        if (*slot != nullptr) {
            platform_driver* pdrv = *slot;
            kprintf("[dpa] step 2: pdrv->of_match_table=%p\n",
                    pdrv->of_match_table);
            if (pdrv->of_match_table != nullptr) {
                kprintf("[dpa] step 2: pdrv->of_match_table[0].compatible=%p\n",
                        pdrv->of_match_table[0].compatible);
                if (pdrv->of_match_table[0].compatible != nullptr) {
                    kprintf("[dpa] step 2: compatible='%s'\n",
                            pdrv->of_match_table[0].compatible);
                }
            }
            platform_driver_register(pdrv);
            kprintf("[dpa] step 2: registered\n");
        }
    }

    kprintf("[dpa] step 3: instantiate devices\n");
    for (platform_driver** slot = start; slot < end; ++slot) {
        if (*slot != nullptr) {
            instantiate_devices_for_driver(*slot);
        }
    }
    kprintf("[dpa] done\n");
}
