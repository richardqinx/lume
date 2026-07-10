/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * RISC-V Architecture Configuration — runtime state and KASLR
 *
 * Provides the runtime (post-KASLR) values of the higher-half
 * virtual address bases.  kaslr_init() is called once during
 * early boot, before vmm_init(), to randomise the layout and
 * fill the unified KaslrLayout structure.
 *
 * KASLR slide budget:
 *   The default Direct Map starts at 0xFFFFFFC0_0000_0000 (VPN[2]=256).
 *   The default Vmemmap starts at 0xFFFFFFD0_0000_0000 (VPN[2]=320).
 *   A 1GB superpage occupies one VPN[2] slot.  We allow a slide of
 *   0..63 slots (0..63 GB) upward, which keeps both regions inside
 *   the upper canonical half and avoids colliding with the kernel
 *   text region (linked at VPN[2] = 258 + 2 = ~0xFFFFFFC0_8020_0000).
 *
 *   In practice, with 128MB RAM the kernel+direct map only touches
 *   VPN[2] 258-259, so a slide of up to 63GB is safe.
 */

#include <arch/config.h>
#include <lume/fdt.h>
#include <lume/page.h>
#include <lume/config.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/random.h>

extern "C" char _stext[], _kernel_end[];

namespace arch {

/*  Global KASLR Layout Structure*/
KaslrLayout g_kaslr_layout = {};

/* Runtime bases — updated by kaslr_layout_compute() */
uint64 g_direct_map_base = kDirectMapBaseDefault;
uint64 g_vmemmap_base    = kVmemmapBaseDefault;

/*  VA Range for validation */
struct VaRange {
    const char* name;
    uint64 start;
    uint64 end;   // exclusive
};

/* ================================================================
 * Utilities
 * ================================================================ */
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

/* Splitmix64: non-plaintext hash derived from seed (used for seed_hash) */
static uint64 splitmix64(uint64 x)
{
    x += 0x9e3779b97f4a7c15ULL;
    x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9ULL;
    x = x ^ (x >> 27);
    return x * 0x94d049bb133111ebULL;
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

/* ================================================================
 * KASLR Computation (Phase A: Centralized in single function)
 *
 * This function:
 *   1. Generates or derives random seed
 *   2. Selects 1GB-aligned slot [0..63]
 *   3. Computes seed_hash via splitmix64
 *   4. Fills KaslrLayout structure completely
 *   5. Validates ranges (canonical, overlaps)
 *   6. Logs according to CONFIG_KASLR_LOG_LEVEL
 * ================================================================ */
static void kaslr_layout_compute()
{
#ifdef CONFIG_KASLR
    constexpr uint64 k1GB = 1ULL << 30;
    constexpr uint64 kMaxSlots = 64;

    /* 1. Get seed and source */
    uint64 seed = random_early_seed_value();
    RandomSeedSource rsrc = random_early_seed_source();
    KaslrSeedSource source;
    switch (rsrc) {
    case RandomSeedSource::FdtProvided:
        source = KaslrSeedSource::kFdt;
        break;
    case RandomSeedSource::HwRandom:
        source = KaslrSeedSource::kHardware;
        break;
    case RandomSeedSource::CycleFallback:
    case RandomSeedSource::Unknown:
    default:
        source = KaslrSeedSource::kCycle;
        break;
    }

    /* 2. Select random slot and compute slide */
    uint64 raw = get_random_u64();
    uint64 slot = raw % kMaxSlots;
    if (slot == 0) {
        slot = 1; /* slot=0 causes direct_map to overlap with kernel image VA */
    }
    uint64 slide = slot * k1GB;

    /* 3. Compute non-plaintext hash */
    uint64 seed_hash = splitmix64(seed ^ 0xdeadbeefdeadbeefULL);

    /* 4. Compute randomised bases */
    uint64 direct_map_base = kDirectMapBaseDefault + slide;
    uint64 vmemmap_base    = kVmemmapBaseDefault   + slide;

    /* 5. Fill KaslrLayout */
    g_kaslr_layout.seed = seed;
    g_kaslr_layout.seed_hash = seed_hash;
    g_kaslr_layout.source = source;
    g_kaslr_layout.slot = slot;
    g_kaslr_layout.slide_bytes = slide;
    g_kaslr_layout.policy_id = kKaslrPolicyId;
    g_kaslr_layout.direct_map_base = direct_map_base;
    g_kaslr_layout.vmemmap_base = vmemmap_base;
    g_kaslr_layout.canonical_ok = false;
    g_kaslr_layout.overlap_ok = false;

    /* Update global runtime bases */
    g_direct_map_base = direct_map_base;
    g_vmemmap_base = vmemmap_base;

    /* 6. Self-check: canonical VA validation and overlap detection */
    uint64 mem_base = 0, mem_size = 0;
    fdt_early_get_mem_info(&mem_base, &mem_size);
    if (mem_size == 0) {
        kernel_panic("kaslr_layout_compute: invalid memory from FDT");
    }

    /* Construct VA ranges */
    uint64 num_pages = mem_size / kPageSize;
    uint64 page_bytes = num_pages * sizeof(Page);
    uint64 page_span = align_up_page(page_bytes);

    VaRange direct_map {
        "direct-map",
        checked_add_u64(g_direct_map_base, mem_base, "direct_map start"),
        checked_add_u64(checked_add_u64(g_direct_map_base, mem_base,
                                        "direct_map start"),
                        mem_size, "direct_map end"),
    };

    VaRange vmemmap {
        "vmemmap",
        g_vmemmap_base,
        checked_add_u64(g_vmemmap_base, page_span, "vmemmap end"),
    };

    VaRange kernel_img {
        "kernel-image",
        align_down_page(reinterpret_cast<uint64>(_stext)),
        align_up_page(reinterpret_cast<uint64>(_kernel_end)),
    };

    /* Validate each range is canonical */
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

    /* Validate no overlaps */
    if (ranges_overlap(direct_map, kernel_img)) {
        kernel_panic("kaslr: direct-map overlaps kernel image");
    }
    if (ranges_overlap(vmemmap, kernel_img)) {
        kernel_panic("kaslr: vmemmap overlaps kernel image");
    }
    if (ranges_overlap(direct_map, vmemmap)) {
        kernel_panic("kaslr: direct-map overlaps vmemmap");
    }

    /* Mark validation success */
    g_kaslr_layout.canonical_ok = true;
    g_kaslr_layout.overlap_ok = true;

    /* 7. Logging according to CONFIG_KASLR_LOG_LEVEL */
    if (kKaslrLogLevel >= 1) {
        /* Minimal logging: just the seed and slot (release mode) */
        kprintf("[boot][kaslr] policy_id=%u source=%s slot=%llu\n",
                g_kaslr_layout.policy_id,
                random_seed_source_name(rsrc),
                slot);
    }
    
    if (kKaslrLogLevel >= 2) {
        /* Debug logging: full ranges and hashes */
        kprintf("[boot][kaslr] seed=0x%llx seed_hash=0x%llx\n",
                seed, seed_hash);
        kprintf("[boot][kaslr] direct-map=[0x%llx,0x%llx)\n",
                direct_map.start, direct_map.end);
        kprintf("[boot][kaslr] vmemmap=[0x%llx,0x%llx)\n",
                vmemmap.start, vmemmap.end);
        kprintf("[boot][kaslr] kernel-image=[0x%llx,0x%llx)\n",
                kernel_img.start, kernel_img.end);
    }

#else /* CONFIG_KASLR disabled */
    g_kaslr_layout.seed = 0;
    g_kaslr_layout.seed_hash = 0;
    g_kaslr_layout.source = KaslrSeedSource::kCycle;
    g_kaslr_layout.slot = 0;
    g_kaslr_layout.slide_bytes = 0;
    g_kaslr_layout.policy_id = kKaslrPolicyId;
    g_kaslr_layout.direct_map_base = kDirectMapBaseDefault;
    g_kaslr_layout.vmemmap_base = kVmemmapBaseDefault;
    g_kaslr_layout.canonical_ok = true;
    g_kaslr_layout.overlap_ok = true;

    g_direct_map_base = kDirectMapBaseDefault;
    g_vmemmap_base = kVmemmapBaseDefault;

    if (kKaslrLogLevel >= 1) {
        kprintf("[boot][kaslr] disabled policy_id=%u\n",
                g_kaslr_layout.policy_id);
    }
#endif
}

/* ================================================================
 * Public entry point
 * ================================================================ */
void kaslr_init()
{
    kaslr_layout_compute();
}

} // namespace arch
