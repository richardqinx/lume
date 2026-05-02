/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * RISC-V Architecture Configuration — runtime state and KASLR
 *
 * Provides the runtime (post-KASLR) values of the higher-half
 * virtual address bases.  kaslr_init() is called once during
 * early boot, before vmm_init(), to slide these bases by a
 * random, 1GB-aligned offset.
 *
 * KASLR slide budget:
 *   The default Direct Map starts at 0xFFFFFFC0_0000_0000 (VPN[2]=256).
 *   The default Vmemmap starts at 0xFFFFFFD0_0000_0000 (VPN[2]=320).
 *   A 1GB superpage occupies one VPN[2] slot.  We allow a slide of
 *   0..63 slots (0..63 GB) downward, which keeps both regions inside
 *   the upper canonical half and avoids colliding with the kernel
 *   text region (linked at VPN[2] = 258 + 2 = ~0xFFFFFFC0_8020_0000).
 *
 *   In practice, with 128MB RAM the kernel+direct map only touches
 *   VPN[2] 258-259, so a slide of up to 63GB is safe.
 */

#include <arch/config.h>
#include <lume/fdt.h>
#include <lume/frame.h>
#include <lume/config.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/random.h>

extern "C" char _stext[], _kernel_end[];

namespace arch {

/* Runtime bases — default to the compile-time constants. */
uint64 g_direct_map_base = kDirectMapBaseDefault;
uint64 g_vmemmap_base    = kVmemmapBaseDefault;

struct VaRange {
    const char* name;
    uint64 start;
    uint64 end;   // exclusive
};

static inline uint64 align_down_page(uint64 v)
{
    return v & ~(kPageSize - 1);
}

static inline uint64 align_up_page(uint64 v)
{
    return (v + kPageSize - 1) & ~(kPageSize - 1);
}

static uint64 checked_add_u64(uint64 a, uint64 b, const char* detail)
{
    if (a > (~0ULL - b)) {
        kernel_panic("kaslr: address overflow", detail);
    }
    return a + b;
}

/* SV39 canonical VA check: bits [63:39] must equal sign bit 38. */
static bool is_sv39_canonical(uint64 va)
{
    uint64 sign = (va >> 38) & 1ULL;
    uint64 upper = va >> 39;
    return sign ? (upper == ((1ULL << 25) - 1ULL)) : (upper == 0);
}

static bool is_sv39_kernel_half(uint64 va)
{
    return is_sv39_canonical(va) && (((va >> 38) & 1ULL) == 1ULL);
}

static bool ranges_overlap(const VaRange& a, const VaRange& b)
{
    return (a.start < b.end) && (b.start < a.end);
}

static void kaslr_self_check(uint64 slot)
{
    uint64 mem_base = 0;
    uint64 mem_size = 0;
    fdt_early_get_mem_info(&mem_base, &mem_size);
    if (mem_size == 0) {
        kernel_panic("kaslr: invalid memory size from FDT");
    }

    /* Direct-map covers the discovered physical memory window. */
    VaRange direct_map {
        "direct-map",
        checked_add_u64(g_direct_map_base, mem_base, "direct_map start"),
        checked_add_u64(checked_add_u64(g_direct_map_base, mem_base,
                                        "direct_map start"),
                        mem_size, "direct_map end"),
    };

    /* Vmemmap covers the Frame descriptor array span. */
    uint64 num_frames = mem_size / kPageSize;
    uint64 frame_bytes = num_frames * sizeof(Frame);
    uint64 frame_span = align_up_page(frame_bytes);
    VaRange vmemmap {
        "vmemmap",
        g_vmemmap_base,
        checked_add_u64(g_vmemmap_base, frame_span, "vmemmap end"),
    };

    /* Kernel image window is linked at fixed higher-half addresses. */
    VaRange kernel_img {
        "kernel-image",
        align_down_page(reinterpret_cast<uint64>(_stext)),
        align_up_page(reinterpret_cast<uint64>(_kernel_end)),
    };

    auto check_kernel_half = [](const VaRange& r) {
        if (r.start >= r.end) {
            kernel_panic("kaslr: invalid VA range", r.name);
        }
        if (!is_sv39_kernel_half(r.start) || !is_sv39_kernel_half(r.end - 1)) {
            kernel_panic("kaslr: non-canonical kernel VA range", r.name);
        }
    };

    check_kernel_half(direct_map);
    check_kernel_half(vmemmap);
    check_kernel_half(kernel_img);

    if (ranges_overlap(direct_map, kernel_img)) {
        kernel_panic("kaslr: direct-map overlaps kernel image");
    }
    if (ranges_overlap(vmemmap, kernel_img)) {
        kernel_panic("kaslr: vmemmap overlaps kernel image");
    }
    if (ranges_overlap(direct_map, vmemmap)) {
        kernel_panic("kaslr: direct-map overlaps vmemmap");
    }

    kprintf("[boot][kaslr] seed=0x%llx source=%s slot=%llu slide_gb=%llu\n",
            random_early_seed_value(),
            random_seed_source_name(random_early_seed_source()),
            slot, slot);
    kprintf("[boot][kaslr] direct-map=[0x%llx,0x%llx)\n",
            direct_map.start, direct_map.end);
    kprintf("[boot][kaslr] vmemmap=[0x%llx,0x%llx)\n",
            vmemmap.start, vmemmap.end);
    kprintf("[boot][kaslr] kernel-image=[0x%llx,0x%llx)\n",
            kernel_img.start, kernel_img.end);
}

void kaslr_init()
{
#ifdef CONFIG_KASLR
    /*
     * Generate a random 1GB-aligned slide.
     *
     * Strategy (matching Linux's approach):
     *   1. Pull 64 random bits from the early PRNG.
     *   2. Reduce to a slot number in [0, kMaxSlots).
     *   3. Convert to a byte offset (slot * 1GB).
     *   4. Add to both bases (slide upward in VA space).
     *
     * Why 1GB alignment?
     *   SV39 L2 (root) PTEs map 1GB superpages.  Keeping the slide
     *   1GB-aligned means the direct-map can still use gigapages,
     *   avoiding TLB pressure.  This matches Linux's KASLR on RISC-V.
     */
    constexpr uint64 k1GB = 1ULL << 30;
    constexpr uint64 kMaxSlots = 64;        /* 0..63 GB slide range */

    uint64 raw = get_random_u64();
    uint64 slot = raw % kMaxSlots;
    uint64 slide = slot * k1GB;

    g_direct_map_base = kDirectMapBaseDefault + slide;
    g_vmemmap_base    = kVmemmapBaseDefault   + slide;

        kaslr_self_check(slot);
#else
        g_direct_map_base = kDirectMapBaseDefault;
        g_vmemmap_base = kVmemmapBaseDefault;
        kprintf("[boot][kaslr] disabled source=%s seed=0x%llx slot=0 slide_gb=0\n",
            random_seed_source_name(random_early_seed_source()),
            random_early_seed_value());
        kprintf("[boot][kaslr] direct-map=[0x%llx,0x%llx)\n",
            g_direct_map_base, g_direct_map_base);
        kprintf("[boot][kaslr] vmemmap=[0x%llx,0x%llx)\n",
            g_vmemmap_base, g_vmemmap_base);
#endif
}

} // namespace arch
