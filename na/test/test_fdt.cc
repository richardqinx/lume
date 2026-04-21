/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Boot Self-Test: FDT (Flattened Device Tree)
 */

#include <lume/selftest.h>
#include <lume/fdt.h>

// Manually declare what we need to avoid header conflicts with toolchain libc
extern "C" int strcmp(const char *s1, const char *s2);

void selftest_fdt() {
    st_begin("fdt: tree root access");
    {
        DeviceNode* root = fdt_get_node_by_path("/");
        ST_ASSERT(root != nullptr);
        ST_ASSERT_EQ(strcmp(root->get_name(), ""), 0); 
    }
    st_pass();

    st_begin("fdt: find existing compatible node (UART)");
    {
        // QEMU virt RISC-V platform always has a ns16550a UART
        DeviceNode* uart = fdt_find_compatible("ns16550a");
        ST_ASSERT(uart != nullptr);
        
        // Use get_prop_string which is convenience helper
        const char* compat = uart->get_prop_string("compatible");
        ST_ASSERT(compat != nullptr);
        
        // Check raw property access
        const FdtProperty* reg = uart->get_prop("reg");
        ST_ASSERT(reg != nullptr);
        ST_ASSERT(reg->value != nullptr);
        ST_ASSERT(reg->len > 0);
    }
    st_pass();

    st_begin("fdt: non-existent node/compatible queries");
    {
        DeviceNode* missing1 = fdt_get_node_by_path("/definitely_does_not_exist_node_12345");
        ST_ASSERT(missing1 == nullptr);

        DeviceNode* missing2 = fdt_find_compatible("invalid_compatible_string_xyz");
        ST_ASSERT(missing2 == nullptr);
    }
    st_pass();
}
