/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * plic.cc — Platform-Level Interrupt Controller stub
 */

#include <lume/fdt.h>
#include <lume/vmm.h>
#include <arch/config.h>

void plic_init() {
    /* 
     * In a fully implemented driver, we would discover the PLIC base 
     * and size via FDT. For now, we map the default QEMU virt PLIC.
     */
    uint64 plic_pa = arch::kDefaultPlicPA;
    /* QEMU virt PLIC is 0x4000000 in size */
    vmm_map_kernel_mmio(plic_pa, 0x4000000);
}

void plic_init_ap() {
    /* AP per-CPU init */
}
