/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/boot_params.h>

static BootParams g_boot_params = {};

static void boot_params_init_once()
{
    if (g_boot_params.magic == kBootParamsMagic) {
        return;
    }
    g_boot_params = {};
    g_boot_params.magic = kBootParamsMagic;
    g_boot_params.version = kBootParamsVersion;
    g_boot_params.size = static_cast<uint32>(sizeof(BootParams));
}

void boot_params_init_fdt(uint64 fdt_paddr)
{
    boot_params_init_once();
    g_boot_params.fdt_ptr = fdt_paddr;
    g_boot_params.seed_source = BOOT_SEED_NONE;
}

const BootParams* boot_params_get()
{
    if (g_boot_params.magic != kBootParamsMagic) {
        return nullptr;
    }
    return &g_boot_params;
}

void boot_params_set_image_info(uint64 phys_base, uint64 image_size,
                                uint64 reloc_offset, uint64 reloc_size,
                                uint32 comp, uint32 image_flags)
{
    boot_params_init_once();
    g_boot_params.kimage_phys_base = phys_base;
    g_boot_params.kimage_size = image_size;
    g_boot_params.kimage_reloc_offset = reloc_offset;
    g_boot_params.kimage_reloc_size = reloc_size;
    g_boot_params.kimage_comp = comp;
    g_boot_params.kimage_flags = image_flags;
}
