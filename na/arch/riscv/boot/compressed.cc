/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <arch/config.h>
#include <lume/boot_params.h>
#include <lume/compressed.h>
#include <lume/console.h>
#include <lume/config.h>
#include <lume/decompress.h>
#include <lume/fdt.h>
#include <lume/klog.h>
#include <lume/relocate.h>
#include <lume/types.h>

extern "C" const CompressedKernelHeader __lume_image_header;
extern "C" char _start[];
extern "C" char __lume_image_end[];
extern "C" char __lume_reloc_start[];
extern "C" char __lume_reloc_end[];

struct FdtHeader {
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

struct ReservedRange {
    uint64 start;
    uint64 end;
};

static inline uint32 bswap32(uint32 x)
{
    return ((x & 0xFF000000u) >> 24) |
           ((x & 0x00FF0000u) >> 8) |
           ((x & 0x0000FF00u) << 8) |
           ((x & 0x000000FFu) << 24);
}

static inline uint64 read_be64(const uint8* p)
{
    uint64 v = 0;
    for (int i = 0; i < 8; ++i) {
        v = (v << 8) | p[i];
    }
    return v;
}

static inline uint64 addr_to_phys_early(const void* ptr)
{
    uint64 addr = reinterpret_cast<uint64>(ptr);
    if (addr >= arch::kDirectMapBaseDefault) {
        return addr - arch::kDirectMapBaseDefault;
    }
    return addr;
}

static inline uint64 align_down_page(uint64 v)
{
    return v & ~(kPageSize - 1);
}

static inline bool ranges_overlap(uint64 base, uint64 size,
                                  const ReservedRange& r)
{
    if (size == 0) {
        return false;
    }
    if (base > ~0ULL - size) {
        return true;
    }
    uint64 end = base + size;
    return (base < r.end) && (end > r.start);
}

static uint32 crc32_init()
{
    return 0xFFFFFFFFu;
}

static uint32 crc32_update(uint32 crc, const uint8* data, uint64 len)
{
    for (uint64 i = 0; i < len; ++i) {
        crc ^= data[i];
        for (int b = 0; b < 8; ++b) {
            uint32 mask = static_cast<uint32>(-(crc & 1u));
            crc = (crc >> 1) ^ (0xEDB88320u & mask);
        }
    }
    return crc;
}

static uint32 crc32_final(uint32 crc)
{
    return crc ^ 0xFFFFFFFFu;
}

static uint32 crc32_bytes(const uint8* data, uint64 len)
{
    return crc32_final(crc32_update(crc32_init(), data, len));
}

static void early_put_hex_u64(const char* label, uint64 value)
{
    static const char kHex[] = "0123456789abcdef";
    early_puts(label);
    early_puts("0x");
    for (int i = 60; i >= 0; i -= 4) {
        early_putc(kHex[(value >> i) & 0xF]);
    }
    early_putc('\n');
}

/*
 * boot_stage3_trace — lightweight early-boot diagnostic hook.
 *
 * Called from entry.S at three points during the decompress/relocate
 * flow.  Arguments: a0=fdt_paddr, a1=link_base, a2=load_base, a3=phase.
 *
 * Phase 0: before decompress (load_base not yet known → 0)
 * Phase 1: after decompress, before jump
 * Phase 2: after flag-set, before re-entry jump
 */
extern "C" void boot_stage3_trace(uint64 fdt_paddr, uint64 link_base,
                                  uint64 load_base, uint64 phase)
{
    /* Phase 0 may fire before console is initialised — keep it cheap. */
    if (phase == 0) {
        console_early_init(fdt_paddr);
        early_puts("[boot] stage3 trace: phase 0 (pre-decompress)\n");
        return;
    }

    static const char* labels[] = {
        "[boot] stage3 trace: phase 0\n",
        "[boot] stage3 trace: phase 1 (post-decompress)\n",
        "[boot] stage3 trace: phase 2 (pre-reentry)\n",
    };
    if (phase < 3) {
        early_puts(labels[phase]);
    }
    early_put_hex_u64("  link_base=", link_base);
    early_put_hex_u64("  load_base=", load_base);
}

extern "C" void boot_stage3_loop_panic(uint64 fdt_paddr, uint64 link_base)
{
    console_early_init(fdt_paddr);
    early_puts("[boot] stage3 loop detected\n");

    auto* hdr = reinterpret_cast<const CompressedKernelHeader*>(link_base + 64);
    early_put_hex_u64("link_base=", link_base);
    early_put_hex_u64("hdr.flags=", hdr->flags);
    early_put_hex_u64("hdr.comp=", hdr->compression);
    early_put_hex_u64("hdr.uncomp=", hdr->uncompressed_size);
    early_put_hex_u64("hdr.comp_size=", hdr->compressed_size);
    early_put_hex_u64("hdr.payload_off=", hdr->payload_offset);
    early_put_hex_u64("hdr.load_base=", hdr->load_phys_base);
    early_put_hex_u64("hdr.reloc_off=", hdr->reloc_offset);
    early_put_hex_u64("hdr.reloc_size=", hdr->reloc_size);

    kernel_panic("boot: stage3 loop");
}

static int collect_fdt_reserved(uint64 fdt_paddr, ReservedRange* out, int max)
{
    if (!out || max <= 0 || fdt_paddr == 0) {
        return 0;
    }

    const FdtHeader* hdr = reinterpret_cast<const FdtHeader*>(fdt_paddr);
    if (bswap32(hdr->magic) != 0xd00dfeedu) {
        return 0;
    }

    int count = 0;
    uint64 totalsize = bswap32(hdr->totalsize);
    if (totalsize != 0 && count < max) {
        out[count++] = ReservedRange{fdt_paddr, fdt_paddr + totalsize};
    }

    uint64 rsv_off = bswap32(hdr->off_mem_rsvmap);
    const uint8* p = reinterpret_cast<const uint8*>(fdt_paddr + rsv_off);
    while (count < max) {
        uint64 addr = read_be64(p);
        uint64 size = read_be64(p + 8);
        p += 16;
        if (addr == 0 && size == 0) {
            break;
        }
        if (size == 0) {
            continue;
        }
        out[count++] = ReservedRange{addr, addr + size};
    }

    return count;
}

static uint64 xorshift64(uint64* state)
{
    uint64 x = *state;
    x ^= x << 13;
    x ^= x >> 7;
    x ^= x << 17;
    *state = x;
    return x;
}

static uint64 find_gap_from(uint64 start, uint64 min_base,
                            const ReservedRange* ranges, int count,
                            uint64 image_size)
{
    uint64 candidate = align_down_page(start);

    for (int iter = 0; iter < 64; ++iter) {
        if (candidate < min_base) {
            return 0;
        }

        bool hit = false;
        uint64 next = candidate;
        for (int i = 0; i < count; ++i) {
            if (!ranges_overlap(candidate, image_size, ranges[i])) {
                continue;
            }
            hit = true;
            if (ranges[i].start < image_size) {
                return 0;
            }
            uint64 below = ranges[i].start - image_size;
            below = align_down_page(below);
            if (below < next) {
                next = below;
            }
        }

        if (!hit) {
            return candidate;
        }
        if (next >= candidate) {
            return 0;
        }
        candidate = next;
    }

    return 0;
}

static uint64 choose_load_base(uint64 fdt_paddr, uint64 image_size,
                               uint64 link_base, uint64 payload_base,
                               uint64 payload_size)
{
    uint64 mem_base = 0;
    uint64 mem_size = 0;
    FdtManager::early_scan_mem(fdt_paddr, &mem_base, &mem_size);
    if (mem_size == 0) {
        return link_base;
    }

    uint64 mem_top = mem_base + mem_size;
    if (mem_top < mem_base || mem_top < image_size) {
        return link_base;
    }

    ReservedRange reserved[32] = {};
    int count = 0;

    if (count < static_cast<int>(sizeof(reserved) / sizeof(reserved[0]))) {
        reserved[count++] = ReservedRange{link_base, link_base + image_size};
    }
    if (payload_size != 0 &&
        count < static_cast<int>(sizeof(reserved) / sizeof(reserved[0]))) {
        reserved[count++] = ReservedRange{payload_base, payload_base + payload_size};
    }
    count += collect_fdt_reserved(fdt_paddr, reserved + count,
                                  static_cast<int>(sizeof(reserved) /
                                                   sizeof(reserved[0])) - count);

    uint64 min_base = align_down_page(mem_base);
    uint64 max_base = align_down_page(mem_top - image_size);
    if (max_base < min_base) {
        return link_base;
    }

    uint64 seed = 0;
    FdtManager::early_scan_kaslr(fdt_paddr, &seed);
    uint64 candidate = max_base;
    if (seed != 0) {
        seed ^= link_base;
        uint64 slots = (max_base - min_base) / kPageSize;
        uint64 pick = xorshift64(&seed) % (slots + 1);
        candidate = min_base + pick * kPageSize;
    }

    uint64 base = find_gap_from(candidate, min_base, reserved, count, image_size);
    if (base != 0) {
        return base;
    }
    if (candidate != max_base) {
        base = find_gap_from(max_base, min_base, reserved, count, image_size);
        if (base != 0) {
            return base;
        }
    }

    return link_base;
}

extern "C" uint64 boot_decompress_and_relocate(uint64 fdt_paddr)
{
    console_early_init(fdt_paddr);
    early_puts("[boot] stage3 start\n");

    const uint64 image_va_base = reinterpret_cast<uint64>(_start);
    uint64 image_size = reinterpret_cast<uint64>(__lume_image_end) - image_va_base;
    uint64 reloc_offset = reinterpret_cast<uint64>(__lume_reloc_start) - image_va_base;
    uint64 reloc_size = reinterpret_cast<uint64>(__lume_reloc_end) -
                        reinterpret_cast<uint64>(__lume_reloc_start);

    const uint64 link_base = addr_to_phys_early(_start);
    uint64 load_base = link_base;

    uint32 comp = KERNEL_COMP_NONE;
    uint32 flags = 0;
    uint64 compressed_size = 0;
    uint64 payload_offset = 0;

    const CompressedKernelHeader* hdr = &__lume_image_header;
    const uint64 header_offset = reinterpret_cast<uint64>(&__lume_image_header) -
                                 image_va_base;
    if (hdr->magic == kCompressedKernelMagic &&
        hdr->version == kCompressedKernelVersion &&
        hdr->header_size >= sizeof(CompressedKernelHeader)) {
        if (hdr->header_crc32 != 0) {
            uint32 crc = crc32_init();
            const uint8* hbytes = reinterpret_cast<const uint8*>(hdr);
            constexpr uint64 crc_off = offsetof(CompressedKernelHeader, header_crc32);
            uint64 header_size = hdr->header_size;
            if (header_size > sizeof(CompressedKernelHeader)) {
                header_size = sizeof(CompressedKernelHeader);
            }
            crc = crc32_update(crc, hbytes, crc_off);
            uint32 zero = 0;
            crc = crc32_update(crc, reinterpret_cast<const uint8*>(&zero), sizeof(zero));
            uint64 tail_off = crc_off + sizeof(uint32);
            if (header_size > tail_off) {
                crc = crc32_update(crc, hbytes + tail_off, header_size - tail_off);
            }
            uint32 calc = crc32_final(crc);
            if (calc != hdr->header_crc32) {
                early_puts("[boot] header crc mismatch\n");
                kernel_panic("boot: header crc mismatch");
            }
        }
        comp = hdr->compression;
        compressed_size = hdr->compressed_size;
        if (hdr->uncompressed_size != 0) {
            image_size = hdr->uncompressed_size;
        }
        if (hdr->load_phys_base != 0) {
            load_base = hdr->load_phys_base;
        } else if (comp != KERNEL_COMP_NONE) {
            uint64 payload_base = link_base + payload_offset;
            load_base = choose_load_base(fdt_paddr, image_size, link_base,
                                         payload_base, compressed_size);
        }
        if (hdr->reloc_size != 0) {
            reloc_offset = hdr->reloc_offset;
            reloc_size = hdr->reloc_size;
        }
        payload_offset = (hdr->payload_offset != 0)
                             ? hdr->payload_offset
                             : hdr->header_size;
    }

    if (comp != KERNEL_COMP_NONE && load_base == link_base) {
        early_puts("[boot] no safe relocation base\n");
        flags |= BOOT_IMAGE_RELOC_FAILED;
        boot_params_set_image_info(load_base, image_size, reloc_offset,
                                   reloc_size, comp, flags);
        kernel_panic("boot: no safe relocation base");
    }

    if (comp != KERNEL_COMP_NONE) {
        flags |= BOOT_IMAGE_COMPRESSED;

        if (compressed_size == 0 || payload_offset == 0) {
            early_puts("[boot] compressed header invalid\n");
            flags |= BOOT_IMAGE_DECOMP_FAILED;
            boot_params_set_image_info(load_base, image_size, reloc_offset,
                                       reloc_size, comp, flags);
            kernel_panic("boot: compressed header invalid");
        }

        if (hdr->payload_crc32 != 0) {
            const uint8* payload = reinterpret_cast<const uint8*>(
                image_va_base + payload_offset);
            uint32 calc = crc32_bytes(payload, compressed_size);
            if (calc != hdr->payload_crc32) {
                early_puts("[boot] payload crc mismatch\n");
                flags |= BOOT_IMAGE_DECOMP_FAILED;
                boot_params_set_image_info(load_base, image_size, reloc_offset,
                                           reloc_size, comp, flags);
                kernel_panic("boot: payload crc mismatch");
            }
        }

        if (comp == KERNEL_COMP_LZ4) {
            const uint8* payload = reinterpret_cast<const uint8*>(
                image_va_base + payload_offset);
            uint8* out = reinterpret_cast<uint8*>(load_base);
            int written = lz4_decompress(payload,
                                         static_cast<uint32>(compressed_size),
                                         out, static_cast<uint32>(image_size));
            if (written < 0 || static_cast<uint64>(written) != image_size) {
                early_puts("[boot] lz4 decompress failed\n");
                flags |= BOOT_IMAGE_DECOMP_FAILED;
                boot_params_set_image_info(load_base, image_size, reloc_offset,
                                           reloc_size, comp, flags);
                kernel_panic("boot: lz4 decompress failed");
            }
        } else {
            early_puts("[boot] unsupported compression\n");
            flags |= BOOT_IMAGE_DECOMP_FAILED;
            boot_params_set_image_info(load_base, image_size, reloc_offset,
                                       reloc_size, comp, flags);
            kernel_panic("boot: unsupported compression");
        }
    }

    if (reloc_size != 0 && load_base != link_base) {
        if (reloc_offset + reloc_size > image_size) {
            early_puts("[boot] reloc table out of range\n");
            flags |= BOOT_IMAGE_RELOC_FAILED;
            boot_params_set_image_info(load_base, image_size, reloc_offset,
                                       reloc_size, comp, flags);
            kernel_panic("boot: reloc table out of range");
        }
        const void* reloc_blob = reinterpret_cast<const void*>(
            image_va_base + reloc_offset);
        RelocStatus st = relocate_apply(load_base, image_size, link_base,
                                        reloc_blob, reloc_size);
        if (st != RELOC_OK) {
            early_puts("[boot] relocation failed\n");
            flags |= BOOT_IMAGE_RELOC_FAILED;
            boot_params_set_image_info(load_base, image_size, reloc_offset,
                                       reloc_size, comp, flags);
            kernel_panic("boot: relocation failed", reloc_status_str(st));
        }
        flags |= BOOT_IMAGE_RELOCATED;
    }

    if (load_base != link_base) {
        auto* new_hdr = reinterpret_cast<CompressedKernelHeader*>(
            load_base + header_offset);
        new_hdr->flags |= LUME_HDR_FLAG_STAGE3_DONE;
    }

    early_puts("[boot] stage3 done\n");
    boot_params_set_image_info(load_base, image_size, reloc_offset,
                               reloc_size, comp, flags);
    return load_base;
}
