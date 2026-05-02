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
#include <lume/random.h>
#include <lume/kprintf.h>

namespace arch {

/* Runtime bases — default to the compile-time constants. */
uint64 g_direct_map_base = kDirectMapBaseDefault;
uint64 g_vmemmap_base    = kVmemmapBaseDefault;

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

    kprintf("[kaslr] slide = %llu GB (slot %llu/64)\n", slide >> 30, slot);
    kprintf("[kaslr] direct_map_base = 0x%llx\n", g_direct_map_base);
    kprintf("[kaslr] vmemmap_base    = 0x%llx\n", g_vmemmap_base);
#else
    kprintf("[kaslr] CONFIG_KASLR disabled, using fixed layout\n");
#endif
}

} // namespace arch
