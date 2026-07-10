/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/selftest.h>
#include <lume/task.h>
#include <lume/vmm.h>
#include <lume/mman.h>
#include <lume/errno.h>

/* sys_mm.cc APIs */
int64 sys_brk(uint64 new_brk, uint64, uint64, uint64, uint64, uint64);
int64 sys_mmap(uint64 addr, uint64 length, uint64 prot,
               uint64 flags, uint64 fd, uint64 offset);
int64 sys_munmap(uint64 addr, uint64 length, uint64, uint64, uint64, uint64);
int64 sys_mprotect(uint64 addr, uint64 len, uint64 prot,
                   uint64, uint64, uint64);

void selftest_sys_mm()
{
    st_begin("sys_mm: mmap invalid arguments");
    {
        TaskControlBlock* curr = current_task();
        VmSpace* old_mm = curr->mm;

        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        curr->mm = space;

        ST_ASSERT_EQ(sys_mmap(0, 0, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0), -EINVAL);
        ST_ASSERT_EQ(sys_mmap(0, 0x1000, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, 0, 1), -EINVAL);
        ST_ASSERT_EQ(sys_mmap(0, 0x1000, PROT_READ, 0, 0, 0), -EINVAL);
        ST_ASSERT_EQ(sys_mmap(0, 0x1000, PROT_READ, MAP_PRIVATE | MAP_SHARED, 0, 0), -EINVAL);
        ST_ASSERT_EQ(sys_mmap(0x123, 0x1000, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, 0, 0), -EINVAL);

        curr->mm = old_mm;
        space->destroy();
    }
    st_pass();

    st_begin("sys_mm: mmap/munmap/mprotect basic flow");
    {
        TaskControlBlock* curr = current_task();
        VmSpace* old_mm = curr->mm;

        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        curr->mm = space;

        int64 addr = sys_mmap(0, 0x3000, PROT_READ | PROT_WRITE,
                              MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
        ST_ASSERT(addr > 0);

        ST_ASSERT_EQ(vmm_handle_page_fault(space, addr, VmFaultCause::Read), 0);

        int64 mp = sys_mprotect(addr + kPageSize, kPageSize, PROT_READ, 0, 0, 0);
        ST_ASSERT_EQ(mp, 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, addr + kPageSize, VmFaultCause::Write), -EFAULT);

        int64 mu = sys_munmap(addr, 0x3000, 0, 0, 0, 0);
        ST_ASSERT_EQ(mu, 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, addr, VmFaultCause::Read), -EFAULT);

        curr->mm = old_mm;
        space->destroy();
    }
    st_pass();

    st_begin("sys_mm: MAP_FIXED replaces existing mapping");
    {
        TaskControlBlock* curr = current_task();
        VmSpace* old_mm = curr->mm;

        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        curr->mm = space;

        uint64 base = 0x600000;
        ST_ASSERT_EQ(sys_mmap(base, 0x2000, PROT_READ,
                              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, 0, 0),
                     static_cast<int64>(base));

        ST_ASSERT_EQ(sys_mmap(base, 0x1000, PROT_READ | PROT_WRITE,
                              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, 0, 0),
                     static_cast<int64>(base));

        ST_ASSERT_EQ(vmm_handle_page_fault(space, base, VmFaultCause::Read), 0);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, base, VmFaultCause::Write), 0);

        curr->mm = old_mm;
        space->destroy();
    }
    st_pass();

    st_begin("sys_mm: mmap hint fallback on overlap");
    {
        TaskControlBlock* curr = current_task();
        VmSpace* old_mm = curr->mm;

        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        curr->mm = space;

        uint64 base = 0x700000;
        ST_ASSERT_EQ(sys_mmap(base, 0x2000, PROT_READ,
                              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, 0, 0),
                     static_cast<int64>(base));

        int64 hint = sys_mmap(base, 0x1000, PROT_READ,
                              MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
        ST_ASSERT(hint > 0);
        ST_ASSERT(hint != static_cast<int64>(base));
        ST_ASSERT_EQ(vmm_handle_page_fault(space, hint, VmFaultCause::Read), 0);

        curr->mm = old_mm;
        space->destroy();
    }
    st_pass();

    st_begin("sys_mm: brk growth and shrink");
    {
        TaskControlBlock* curr = current_task();
        VmSpace* old_mm = curr->mm;

        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        curr->mm = space;

        int64 brk0 = sys_brk(0x400000, 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(brk0, 0x400000);

        int64 brk1 = sys_brk(0x402000, 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(brk1, 0x402000);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x400000, VmFaultCause::Read), 0);

        int64 brk2 = sys_brk(0x400000, 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(brk2, 0x400000);
        ST_ASSERT_EQ(vmm_handle_page_fault(space, 0x401000, VmFaultCause::Read), -EFAULT);

        curr->mm = old_mm;
        space->destroy();
    }
    st_pass();

    st_begin("sys_mm: brk invalid shrink below start");
    {
        TaskControlBlock* curr = current_task();
        VmSpace* old_mm = curr->mm;

        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        curr->mm = space;

        ST_ASSERT_EQ(sys_brk(0x500000, 0, 0, 0, 0, 0), 0x500000);
        ST_ASSERT_EQ(sys_brk(0x4FF000, 0, 0, 0, 0, 0), -EINVAL);

        curr->mm = old_mm;
        space->destroy();
    }
    st_pass();

    st_begin("sys_mm: mprotect invalid range");
    {
        TaskControlBlock* curr = current_task();
        VmSpace* old_mm = curr->mm;

        VmSpace* space = VmSpace::create();
        ST_ASSERT(space != nullptr);
        curr->mm = space;

        ST_ASSERT_EQ(sys_mmap(0, 0x1000, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0) > 0, true);
        ST_ASSERT_EQ(sys_mprotect(0x123, 0x1000, PROT_READ, 0, 0, 0), -EINVAL);
        ST_ASSERT_EQ(sys_mprotect(0x900000, 0x1000, PROT_READ, 0, 0, 0), -ENOMEM);

        curr->mm = old_mm;
        space->destroy();
    }
    st_pass();
}
