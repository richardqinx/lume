/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/selftest.h>
#include <lume/uaccess.h>
#include <lume/errno.h>

#include <lume/vmm.h>
#include <lume/pmm.h>
#include <arch/pmap.h>

constexpr uint64 kKernelVABase = 0xFFFFFFC000000000ULL;

void selftest_uaccess()
{
    /* To test valid user addresses (< kKernelVABase), we need a writable page mapped there.
     * We cannot use VmSpace::create() because it does not yet inherit kernel mappings, 
     * so switching to it hangs. We also cannot map it with the U bit because S-mode 
     * would need the SUM bit enabled.
    * So we manually allocate a physical page and map it into the CURRENT page table 
     * at 0x100000 without the U bit, just for this test.
     */
    uint64 mock_user_addr = 0x100000;
    
    uint64 satp;
    asm volatile("csrr %0, satp" : "=r"(satp));
    uint64 root_pa = (satp & 0xFFFFFFFFFFFULL) << 12;
    
    Page* page = pmm_alloc_page();
    ST_ASSERT(page != nullptr);
    uint64 paddr = page_to_pa(page).raw;
    
    pmap::map(root_pa, mock_user_addr, paddr, pmap::PTE_R | pmap::PTE_W | pmap::PTE_V | pmap::PTE_A | pmap::PTE_D);
    
    /* Flush TLB to see the new mapping */
    asm volatile("sfence.vma" : : : "memory");

    st_begin("uaccess: copy_to_user valid range");
    char kernel_buf[32] = "Hello User Space!";
    int ret = copy_to_user(mock_user_addr, kernel_buf, 18);
    ST_ASSERT_EQ(ret, 0);
    st_pass();

    st_begin("uaccess: copy_from_user valid range");
    char read_buf[32] = {0};
    /* We wrote "Hello User Space!" to mock_user_addr previously */
    ret = copy_from_user(read_buf, mock_user_addr, 18);
    ST_ASSERT_EQ(ret, 0);
    ST_ASSERT(read_buf[0] == 'H');
    ST_ASSERT(read_buf[1] == 'e');
    ST_ASSERT(read_buf[6] == 'U');
    st_pass();

    st_begin("uaccess: strncpy_from_user valid range");
    char str_buf[32] = {0};
    int64 len = strncpy_from_user(str_buf, mock_user_addr, 32);
    ST_ASSERT_EQ(len, 17); /* "Hello User Space!" is 17 chars long */
    ST_ASSERT(str_buf[0] == 'H');
    st_pass();

    st_begin("uaccess: strncpy_from_user max_len truncation");
    char trunc_buf[32] = {0};
    len = strncpy_from_user(trunc_buf, mock_user_addr, 6);
    ST_ASSERT_EQ(len, 5); /* Will copy 5 chars and NUL terminate */
    ST_ASSERT(trunc_buf[4] == 'o');
    ST_ASSERT(trunc_buf[5] == '\0');
    st_pass();

    st_begin("uaccess: copy_to_user invalid range (crosses boundary)");
    ret = copy_to_user(kKernelVABase - 10, kernel_buf, 20);
    ST_ASSERT_EQ(ret, -EFAULT);
    st_pass();

    st_begin("uaccess: copy_to_user invalid range (entirely in kernel)");
    ret = copy_to_user(kKernelVABase + 0x1000, kernel_buf, 20);
    ST_ASSERT_EQ(ret, -EFAULT);
    st_pass();

    st_begin("uaccess: copy_to_user invalid range (overflow)");
    ret = copy_to_user(0xFFFFFFFFFFFFFFF0ULL, kernel_buf, 0x100);
    ST_ASSERT_EQ(ret, -EFAULT);
    st_pass();

    st_begin("uaccess: copy_from_user invalid ranges");
    ret = copy_from_user(read_buf, kKernelVABase - 5, 10);
    ST_ASSERT_EQ(ret, -EFAULT);
    
    ret = copy_from_user(read_buf, kKernelVABase, 10);
    ST_ASSERT_EQ(ret, -EFAULT);
    st_pass();

    st_begin("uaccess: strncpy_from_user invalid range");
    uint64 invalid_addr = kKernelVABase + 0x1000;
    len = strncpy_from_user(str_buf, invalid_addr, 10);
    ST_ASSERT_EQ(len, -EFAULT);
    st_pass();
}
