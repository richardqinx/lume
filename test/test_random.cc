/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/selftest.h>
#include <lume/random.h>
#include <lume/kprintf.h>

void selftest_random()
{
    /* Test 1: Basic 64-bit generation */
    kprintf("[test] random: basic 64-bit generation ... ");
    uint64 v1 = get_random_u64();
    uint64 v2 = get_random_u64();
    if (v1 == v2) {
        kernel_panic("random: two consecutive generations were identical!");
    }
    kprintf("PASS\n");

    /* Test 2: Basic 32-bit generation */
    kprintf("[test] random: basic 32-bit generation ... ");
    uint32 v3 = get_random_u32();
    uint32 v4 = get_random_u32();
    if (v3 == v4) {
        kernel_panic("random: two consecutive 32-bit generations were identical!");
    }
    kprintf("PASS\n");

    /* Test 3: Byte generation */
    kprintf("[test] random: byte generation ... ");
    uint8 buf1[16];
    uint8 buf2[16];
    get_random_bytes(buf1, sizeof(buf1));
    get_random_bytes(buf2, sizeof(buf2));
    
    bool all_zero1 = true;
    bool all_zero2 = true;
    bool same = true;

    for (int i = 0; i < 16; i++) {
        if (buf1[i] != 0) all_zero1 = false;
        if (buf2[i] != 0) all_zero2 = false;
        if (buf1[i] != buf2[i]) same = false;
    }

    if (all_zero1 || all_zero2 || same) {
        kernel_panic("random: byte generation statistical failure!");
    }
    kprintf("PASS\n");
}
