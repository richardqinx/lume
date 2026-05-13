/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/relocate.h>

static inline bool range_ok(uint64 offset, uint64 size, uint64 image_size)
{
    if (offset > image_size) {
        return false;
    }
    if (size > image_size - offset) {
        return false;
    }
    return true;
}

RelocStatus relocate_apply(uint64 load_base, uint64 image_size,
                           uint64 link_base, const void* reloc_blob,
                           uint64 reloc_size)
{
    if (!reloc_blob || reloc_size == 0) {
        return RELOC_OK;
    }
    if (reloc_size < sizeof(RelocTableHeader)) {
        return RELOC_ERR_SIZE;
    }

    const auto* hdr = reinterpret_cast<const RelocTableHeader*>(reloc_blob);
    if (hdr->magic != kRelocTableMagic) {
        return RELOC_ERR_MAGIC;
    }
    if (hdr->version != kRelocTableVersion) {
        return RELOC_ERR_VERSION;
    }
    if (hdr->arch != RELOC_ARCH_RISCV) {
        return RELOC_ERR_ARCH;
    }
    if (hdr->entry_size < sizeof(RelocEntry) || (hdr->entry_size % 8) != 0) {
        return RELOC_ERR_SIZE;
    }

    uint64 max_entries = (reloc_size - sizeof(RelocTableHeader)) /
        static_cast<uint64>(hdr->entry_size);
    if (hdr->entry_count > max_entries) {
        return RELOC_ERR_SIZE;
    }

    if (image_size < sizeof(uint64)) {
        return RELOC_ERR_RANGE;
    }

    const uint64 delta = load_base - link_base;
    const uint8* p = reinterpret_cast<const uint8*>(reloc_blob) +
                     sizeof(RelocTableHeader);

    for (uint32 i = 0; i < hdr->entry_count; ++i) {
        const auto* ent = reinterpret_cast<const RelocEntry*>(p);
        if ((ent->offset & 0x7) != 0 ||
            !range_ok(ent->offset, sizeof(uint64), image_size)) {
            return RELOC_ERR_RANGE;
        }

        uint64* target = reinterpret_cast<uint64*>(load_base + ent->offset);
        switch (ent->type) {
        case RELOC_RISCV_RELATIVE:
            *target = load_base + ent->addend;
            break;
        case RELOC_RISCV_64:
            *target = ent->addend + delta;
            break;
        default:
            return RELOC_ERR_UNSUPPORTED;
        }
        p += hdr->entry_size;
    }

    return RELOC_OK;
}

const char* reloc_status_str(RelocStatus st)
{
    switch (st) {
    case RELOC_OK:
        return "ok";
    case RELOC_ERR_MAGIC:
        return "bad magic";
    case RELOC_ERR_VERSION:
        return "bad version";
    case RELOC_ERR_ARCH:
        return "arch mismatch";
    case RELOC_ERR_SIZE:
        return "size mismatch";
    case RELOC_ERR_RANGE:
        return "range";
    case RELOC_ERR_UNSUPPORTED:
        return "unsupported";
    default:
        return "unknown";
    }
}
