/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

inline constexpr uint64 kCompressedKernelMagic = 0x4C554D45434F4D50ULL; /* LUMECOMP */
inline constexpr uint32 kCompressedKernelVersion = 1;

enum KernelCompressionType : uint32 {
    KERNEL_COMP_NONE = 0,
    KERNEL_COMP_LZ4  = 1,
};

enum CompressedHeaderFlags : uint16 {
    LUME_HDR_FLAG_STAGE3_DONE = 1u << 0,
};

struct CompressedKernelHeader {
    uint64 magic;
    uint32 version;
    uint16 header_size;
    uint16 flags;
    uint32 compression;
    uint32 reserved0;
    uint64 uncompressed_size;
    uint64 compressed_size;
    uint64 load_phys_base;
    uint64 reloc_offset;
    uint64 reloc_size;
    uint64 payload_offset;
    uint32 header_crc32;
    uint32 payload_crc32;
};

static_assert(sizeof(CompressedKernelHeader) == 80);
