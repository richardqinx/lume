/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/selftest.h>
#include <lume/vmm.h>
#include <lume/addr.h>
#include <lume/errno.h>
#include <arch/pmap.h>

void selftest_vma() {
    st_begin("vma: create and destroy VmSpace");
    {
        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        ST_ASSERT(space->root_pa != 0);

        // Add a few regions to ensure destruction works
        vmm_map_user(space, 0x1000, 0x1000, VM_READ);
        vmm_map_user(space, 0x3000, 0x1000, VM_READ | VM_WRITE);

        space->destroy();
    }
    st_pass();

    st_begin("vma: map user region and handle demand paging");
    {
        VmSpace* space = VmSpace::create();

        // Map 8KB (2 pages) at 0x400000 using MI-layer flags
        int ret = vmm_map_user(space, 0x400000, 0x2000, VM_READ | VM_WRITE);
        ST_ASSERT_EQ(ret, 0);

        // Fault in the first page
        ret = vmm_handle_page_fault(space, 0x400500, VmFaultCause::Read);
        ST_ASSERT_EQ(ret, 0);

        // Verify mapping in hardware page table
        uint64 pa = 0;
        bool mapped = pmap::lookup(space->root_pa, 0x400000, &pa);
        ST_ASSERT(mapped);
        ST_ASSERT_NE(pa, 0ULL);

        // Fault in the second page
        ret = vmm_handle_page_fault(space, 0x401FFF, VmFaultCause::Read);
        ST_ASSERT_EQ(ret, 0);

        // Should reject fault outside VMA with -EFAULT
        ret = vmm_handle_page_fault(space, 0x402000, VmFaultCause::Read);
        ST_ASSERT_EQ(ret, -EFAULT);

        space->destroy();
    }
    st_pass();

    st_begin("vma: unmap user region prevents page fault");
    {
        VmSpace* space = VmSpace::create();
        vmm_map_user(space, 0x10000, 0x2000, VM_READ);

        // Inside the region — should succeed
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x10500, VmFaultCause::Read), 0);

        // Unmap exactly
        vmm_unmap_user(space, 0x10000, 0x2000);

        // Should fail now with -EFAULT
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x10500, VmFaultCause::Read), -EFAULT);

        space->destroy();
    }
    st_pass();

    st_begin("vma: duplicate page fault on same page returns 0");
    {
        VmSpace* space = VmSpace::create();
        vmm_map_user(space, 0x200000, 0x1000, VM_READ | VM_WRITE);

        // First fault allocates the physical page
        int ret = vmm_handle_page_fault(space, 0x200000, VmFaultCause::Read);
        ST_ASSERT_EQ(ret, 0);

        // Second fault on the same page should hit "already mapped" path
        ret = vmm_handle_page_fault(space, 0x200100, VmFaultCause::Read);
        ST_ASSERT_EQ(ret, 0);

        // Verify both land on the same physical page
        uint64 pa1 = 0, pa2 = 0;
        pmap::lookup(space->root_pa, 0x200000, &pa1);
        pmap::lookup(space->root_pa, 0x200100, &pa2);
        // Same page, so PA for both addresses should be the same base page
        ST_ASSERT_EQ(pa1, pa2);

        space->destroy();
    }
    st_pass();

    st_begin("vma: vm_perm_to_pte flag translation correctness");
    {
        // Test each MI flag maps to correct hardware PTE bit
        uint64 pte_r = pmap::vm_perm_to_pte(VM_READ);
        ST_ASSERT(pte_r & pmap::PTE_R);
        ST_ASSERT(!(pte_r & pmap::PTE_W));
        ST_ASSERT(!(pte_r & pmap::PTE_X));
        ST_ASSERT(!(pte_r & pmap::PTE_U));

        uint64 pte_rw = pmap::vm_perm_to_pte(VM_READ | VM_WRITE);
        ST_ASSERT(pte_rw & pmap::PTE_R);
        ST_ASSERT(pte_rw & pmap::PTE_W);

        uint64 pte_rx = pmap::vm_perm_to_pte(VM_READ | VM_EXEC);
        ST_ASSERT(pte_rx & pmap::PTE_R);
        ST_ASSERT(pte_rx & pmap::PTE_X);
        ST_ASSERT(!(pte_rx & pmap::PTE_W));

        uint64 pte_u = pmap::vm_perm_to_pte(VM_READ | VM_USER);
        ST_ASSERT(pte_u & pmap::PTE_R);
        ST_ASSERT(pte_u & pmap::PTE_U);

        // All combined
        uint64 pte_all = pmap::vm_perm_to_pte(VM_READ | VM_WRITE | VM_EXEC | VM_USER);
        ST_ASSERT(pte_all & pmap::PTE_R);
        ST_ASSERT(pte_all & pmap::PTE_W);
        ST_ASSERT(pte_all & pmap::PTE_X);
        ST_ASSERT(pte_all & pmap::PTE_U);
        ST_ASSERT(pte_all & pmap::PTE_V);  // Always valid
    }
    st_pass();

    st_begin("vma: unmap subset only removes contained VMAs");
    {
        VmSpace* space = VmSpace::create();
        // Map three separate regions
        vmm_map_user(space, 0x50000, 0x1000, VM_READ);
        vmm_map_user(space, 0x60000, 0x1000, VM_READ);
        vmm_map_user(space, 0x70000, 0x1000, VM_READ);

        // Unmap only the middle one (range covers 0x60000-0x61000)
        vmm_unmap_user(space, 0x60000, 0x1000);

        // First and third should still be reachable
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x50000, VmFaultCause::Read), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x70000, VmFaultCause::Read), 0);

        // Middle should fail
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x60000, VmFaultCause::Read), -EFAULT);

        space->destroy();
    }
    st_pass();

    st_begin("vma: null space returns -EINVAL");
    {
        ST_ASSERT_EQ(vmm_map_user(nullptr, 0x1000, 0x1000, VM_READ), -EINVAL);
        ST_ASSERT_EQ(vmm_unmap_user(nullptr, 0x1000, 0x1000), -EINVAL);
        ST_ASSERT_EQ(vmm_handle_page_fault(nullptr, 0x1000, VmFaultCause::Read), -EINVAL);
    }
    st_pass();

    st_begin("vma: clone and copy-on-write");
    {
        VmSpace* parent = VmSpace::create();
        vmm_map_user(parent, 0x80000, 0x1000, VM_READ | VM_WRITE);
        
        /* Trigger read fault in parent to allocate physical page */
        ST_ASSERT_EQ(vmm_handle_page_fault(parent, 0x80000, VmFaultCause::Read), 0);
        uint64 parent_pa_initial;
        ST_ASSERT(pmap::lookup(parent->root_pa, 0x80000, &parent_pa_initial));
        
        /* Clone the address space */
        VmSpace* child = vmm_clone(parent);
        ST_ASSERT(child != nullptr);
        
        /* Verify child has the same physical page mapped but COW */
        uint64 child_pa;
        ST_ASSERT(pmap::lookup(child->root_pa, 0x80000, &child_pa));
        ST_ASSERT_EQ(child_pa, parent_pa_initial);
        ST_ASSERT(pmap::is_cow(child->root_pa, 0x80000));
        ST_ASSERT(pmap::is_cow(parent->root_pa, 0x80000)); /* Parent also marked COW */
        
        /* Trigger Store Page Fault (cause=15) in child */
        ST_ASSERT_EQ(vmm_handle_page_fault(child, 0x80000, VmFaultCause::Write), 0);
        
        /* Child should now have a new physical page, no longer COW */
        uint64 child_pa_new;
        ST_ASSERT(pmap::lookup(child->root_pa, 0x80000, &child_pa_new));
        ST_ASSERT(child_pa_new != parent_pa_initial);
        ST_ASSERT(!pmap::is_cow(child->root_pa, 0x80000));
        
        /* Parent is still mapped to the old page, still COW because it hasn't written */
        uint64 parent_pa_current;
        ST_ASSERT(pmap::lookup(parent->root_pa, 0x80000, &parent_pa_current));
        ST_ASSERT_EQ(parent_pa_current, parent_pa_initial);
        ST_ASSERT(pmap::is_cow(parent->root_pa, 0x80000));
        
        /* Trigger Store Page Fault in parent */
        ST_ASSERT_EQ(vmm_handle_page_fault(parent, 0x80000, VmFaultCause::Write), 0);
        ST_ASSERT(!pmap::is_cow(parent->root_pa, 0x80000));
        
        child->destroy();
        parent->destroy();
    }
    st_pass();

    st_begin("vma: gap search finds next free range");
    {
        VmSpace* space = VmSpace::create();
        vmm_map_user(space, 0x1000, 0x3000, VM_READ);

        uint64 va = mm_find_free_va(space, 0x1000, kPageSize);
        ST_ASSERT_EQ(va, 0x4000ULL);

        space->destroy();
    }
    st_pass();

    st_begin("vma: reject overlapping mapping");
    {
        VmSpace* space = VmSpace::create();
        ST_ASSERT_EQ(vmm_map_user(space, 0x20000, 0x2000, VM_READ), 0);
        ST_ASSERT_EQ(vmm_map_user(space, 0x21000, 0x1000, VM_READ), -EINVAL);
        space->destroy();
    }
    st_pass();

    st_begin("vma: partial unmap splits a single VMA");
    {
        VmSpace* space = VmSpace::create();
        ST_ASSERT_EQ(vmm_map_user(space, 0x80000, 0x3000, VM_READ | VM_WRITE), 0);

        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x80000, VmFaultCause::Read), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x81000, VmFaultCause::Read), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x82000, VmFaultCause::Read), 0);

        ST_ASSERT_EQ(vmm_unmap_user(space, 0x81000, 0x1000), 0);

        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x80000, VmFaultCause::Read), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x82000, VmFaultCause::Read), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x81000, VmFaultCause::Read), -EFAULT);

        space->destroy();
    }
    st_pass();

    st_begin("vma: mprotect read-only blocks write faults");
    {
        VmSpace* space = VmSpace::create();
        ST_ASSERT_EQ(vmm_map_user(space, 0x90000, 0x2000, VM_READ | VM_WRITE), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x90000, VmFaultCause::Read), 0);

        ST_ASSERT_EQ(vmm_protect_user(space, 0x90000, 0x1000, VM_READ), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x90000, VmFaultCause::Write), -EFAULT);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x91000, VmFaultCause::Write), 0);

        space->destroy();
    }
    st_pass();

    st_begin("vma: PROT_NONE unmaps existing pages");
    {
        VmSpace* space = VmSpace::create();
        ST_ASSERT_EQ(vmm_map_user(space, 0xA0000, 0x1000, VM_READ | VM_WRITE), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0xA0000, VmFaultCause::Read), 0);

        ST_ASSERT_EQ(vmm_protect_user(space, 0xA0000, 0x1000, 0), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0xA0000, VmFaultCause::Read), -EFAULT);

        space->destroy();
    }
    st_pass();

    st_begin("vma: range covered check");
    {
        VmSpace* space = VmSpace::create();
        ST_ASSERT_EQ(vmm_map_user(space, 0xB0000, 0x2000, VM_READ), 0);

        ST_ASSERT(vma_range_covered(space, 0xB0000, 0xB1000));
        ST_ASSERT(!vma_range_covered(space, 0xB0000, 0xB3000));

        space->destroy();
    }
    st_pass();
}
