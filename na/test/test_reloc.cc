/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: relocation engine
 */

#include <lume/relocate.h>
#include <lume/selftest.h>

struct RelocBlob {
    RelocTableHeader hdr;
    RelocEntry entries[2];
};

void selftest_reloc()
{
    st_begin("reloc: relative + abs64");

    alignas(8) uint8 buf[64] = {};
    uint64 base = reinterpret_cast<uint64>(buf);
    uint64 link_base = base - 0x1000;

    RelocBlob blob = {};
    blob.hdr.magic = kRelocTableMagic;
    blob.hdr.version = kRelocTableVersion;
    blob.hdr.arch = RELOC_ARCH_RISCV;
    blob.hdr.entry_size = sizeof(RelocEntry);
    blob.hdr.entry_count = 2;

    blob.entries[0].offset = 8;
    blob.entries[0].addend = 0x200;
    blob.entries[0].type = RELOC_RISCV_RELATIVE;

    blob.entries[1].offset = 16;
    blob.entries[1].addend = link_base + 0x1234;
    blob.entries[1].type = RELOC_RISCV_64;

    RelocStatus st = relocate_apply(base, sizeof(buf), link_base,
                                    &blob, sizeof(blob));
    ST_ASSERT_EQ(st, RELOC_OK);
    ST_ASSERT_EQ(*reinterpret_cast<uint64*>(base + 8), base + 0x200);
    ST_ASSERT_EQ(*reinterpret_cast<uint64*>(base + 16), base + 0x1234);

    st_pass();
}
