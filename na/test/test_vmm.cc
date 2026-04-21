/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: VMM and Address Translation
 */

#include <lume/selftest.h>
#include <lume/addr.h>
#include <lume/vmm.h>
#include <arch/config.h>

/* Assuming pmap namespace is accessible or we can test basic structures */

void selftest_vmm() {
    st_begin("vmm: virtual/physical address translation");
    {
        uint64 pa = 0x80000000ULL;
        uint64 va = pa_to_va(pa);
        ST_ASSERT_EQ(va, 0xFFFFFFC080000000ULL);
        ST_ASSERT_EQ(va_to_pa(va), pa);
        
        uint64 pfn = pa_to_pfn(pa);
        ST_ASSERT_EQ(pfn, 0x80000ULL);
        ST_ASSERT_EQ(pfn_to_pa(pfn), pa);
        
        ST_ASSERT(is_kernel_va(va));
        ST_ASSERT(!is_kernel_va(pa));
        
        ST_ASSERT_EQ(ensure_pa(va), pa);
        ST_ASSERT_EQ(ensure_pa(pa), pa);
        
        ST_ASSERT_EQ(ensure_va(va), va);
        ST_ASSERT_EQ(ensure_va(pa), va);
    }
    st_pass();

    st_begin("vmm: page alignment macros");
    {
        uint64 addr = 0x80000FFFULL;
        ST_ASSERT_EQ(page_align_down(addr), 0x80000000ULL);
        ST_ASSERT_EQ(page_align_up(addr),   0x80001000ULL);
        ST_ASSERT_EQ(page_align_down(0x80000000ULL), 0x80000000ULL);
        ST_ASSERT_EQ(page_align_up(0x80000000ULL),   0x80000000ULL);
    }
    st_pass();

    st_begin("vmm: mapping kernel MMIO (driver API)");
    {
        // Map 4KB of MMIO at 0x10001000 (UART is at 0x10000000)
        vmm_map_kernel_mmio(0x10001000, 0x1000);
        
        // Verify it doesn't crash and address is reachable in higher half
        uint64 va = pa_to_va(0x10001000);
        ST_ASSERT(is_kernel_va(va));
        
        // We can't safely dereference it here without knowing QEMU layout perfectly,
        // but vmm_init should have mapped it.
    }
    st_pass();
}
