/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

inline constexpr uint64 kRelocTableMagic = 0x4C554D45524C4F43ULL; /* LUMERLOC */
inline constexpr uint16 kRelocTableVersion = 1;

enum RelocArch : uint16 {
    RELOC_ARCH_RISCV = 1,
    RELOC_ARCH_AARCH64 = 2,
    RELOC_ARCH_X86_64 = 3,
};

enum RelocType : uint32 {
    RELOC_RISCV_RELATIVE = 1,
    RELOC_RISCV_64 = 2,
};

struct RelocTableHeader {
    uint64 magic;
    uint16 version;
    uint16 arch;
    uint32 entry_size;
    uint32 entry_count;
    uint32 reserved;
};

struct RelocEntry {
    uint64 offset;
    uint64 addend;
    uint32 type;
    uint32 reserved;
};

enum RelocStatus : uint32 {
    RELOC_OK = 0,
    RELOC_ERR_MAGIC,
    RELOC_ERR_VERSION,
    RELOC_ERR_ARCH,
    RELOC_ERR_SIZE,
    RELOC_ERR_RANGE,
    RELOC_ERR_UNSUPPORTED,
};

/* Apply relocations to the image loaded at load_base. */
RelocStatus relocate_apply(uint64 load_base, uint64 image_size,
                           uint64 link_base, const void* reloc_blob,
                           uint64 reloc_size);

const char* reloc_status_str(RelocStatus st);
