/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

/*
 * Boot parameters shared between bootloader/firmware and kernel.
 */

inline constexpr uint64 kBootParamsMagic = 0x4C554D45424F4F54ULL; /* LUMEBOOT */
inline constexpr uint32 kBootParamsVersion = 2;

enum BootMemType : uint32 {
    BOOT_MEM_USABLE   = 1,
    BOOT_MEM_RESERVED = 2,
    BOOT_MEM_ACPI     = 3,
    BOOT_MEM_MMIO     = 4,
};

enum BootSeedSource : uint32 {
    BOOT_SEED_NONE  = 0,
    BOOT_SEED_FDT   = 1,
    BOOT_SEED_HW    = 2,
    BOOT_SEED_CYCLE = 3,
};

enum BootImageFlags : uint32 {
    BOOT_IMAGE_COMPRESSED    = 1u << 0,
    BOOT_IMAGE_RELOCATED     = 1u << 1,
    BOOT_IMAGE_DECOMP_FAILED = 1u << 2,
    BOOT_IMAGE_RELOC_FAILED  = 1u << 3,
};

struct BootMemRegion {
    uint64 base;
    uint64 size;
    uint32 type;
    uint32 reserved;
};

struct BootParams {
    uint64 magic;
    uint32 version;
    uint32 size;

    uint64 cmdline_ptr;
    uint32 cmdline_len;
    uint32 memmap_count;
    uint64 memmap_ptr;
    uint32 memmap_entry_size;
    uint32 reserved0;

    uint64 initrd_start;
    uint64 initrd_end;

    uint64 acpi_ptr;
    uint64 fdt_ptr;

    uint64 kaslr_seed;
    uint32 seed_source;
    uint32 flags;

    uint64 kimage_phys_base;
    uint64 kimage_size;
    uint64 kimage_reloc_offset;
    uint64 kimage_reloc_size;
    uint32 kimage_flags;
    uint32 kimage_comp;
};

#ifdef __cplusplus
extern "C" {
#endif

void boot_params_init_fdt(uint64 fdt_paddr);
const BootParams* boot_params_get();
void boot_params_set_image_info(uint64 phys_base, uint64 image_size,
                                uint64 reloc_offset, uint64 reloc_size,
                                uint32 comp, uint32 image_flags);

#ifdef __cplusplus
}
#endif
