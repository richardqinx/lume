/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: VMM and Address Translation
 */

#include <lume/selftest.h>
#include <lume/klog.h>
#include <lume/config.h>
#include <lume/addr.h>
#include <lume/vmm.h>
#include <lume/pmm.h>
#include <arch/config.h>

namespace {
constexpr uint64 kUartBase = 0x10000000ULL;
constexpr uint64 kPageOffsetMask = kPageSize - 1;
}

void selftest_vmm() {
    st_begin("vmm: virtual/physical address translation");
    {
        PhysAddr pa = pmm_get_mem_base();
        VirtAddr va = pa_to_va(pa);
        ST_ASSERT_EQ(va.raw, arch::g_direct_map_base + pa.raw);
        ST_ASSERT_EQ(va_to_pa(va).raw, pa.raw);

        Pfn p = pa_to_pfn(pa);
        ST_ASSERT_EQ(p.raw, pa.raw / kPageSize);
        ST_ASSERT_EQ(pfn_to_pa(p).raw, pa.raw);
    }
    st_pass();

    st_begin("vmm: page alignment macros");
    {
        uint64 base = pmm_get_mem_base().raw;
        uint64 addr = base + kPageOffsetMask;
        ST_ASSERT_EQ(page_align_down(addr), base);
        ST_ASSERT_EQ(page_align_up(addr),   base + kPageSize);
        ST_ASSERT_EQ(page_align_down(base), base);
        ST_ASSERT_EQ(page_align_up(base),   base);
    }
    st_pass();

    st_begin("vmm: mapping kernel MMIO (driver API)");
    {
        /* Use UART MMIO address (0x10000000 on RISC-V virt).
         * Must NOT use pmm_get_mem_base() — that's PMP-protected firmware. */
        uint64 mmio_pa = kUartBase;
        vmm_map_kernel_mmio(mmio_pa, kPageSize);
        
        // Verify it doesn't crash and address is reachable in higher half
        uint64 va = pa_to_va(phys_addr(mmio_pa)).raw;
        ST_ASSERT(va >= arch::g_direct_map_base);
    }
    st_pass();
}
