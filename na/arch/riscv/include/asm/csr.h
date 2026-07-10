/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#ifndef _ASM_RISCV_CSR_H
#define _ASM_RISCV_CSR_H

/*
 * RISC-V CSR (Control & Status Register) definitions used by the early
 * boot / MMU-switch path.
 *
 * LumeOS-native subset of Linux arch/riscv/include/asm/csr.h.  Only the
 * symbols head.S and mm/init.cc actually reference are defined — adding
 * the rest is straightforward when new code needs them, and skipping the
 * Linux ALTERNATIVE / vendor-extension machinery keeps the cascade flat.
 */

/* SATP (Supervisor Address Translation and Protection) layout — RV64 */
#define SATP_PPN_MASK    0x00000FFFFFFFFFFFUL   /* bits [43:0] = root PPN */
#define SATP_ASID_SHIFT  44
#define SATP_MODE_SHIFT  60

/* SATP MODE encodings (RV64) */
#define SATP_MODE_BARE   (0UL << SATP_MODE_SHIFT)
#define SATP_MODE_SV39   (8UL << SATP_MODE_SHIFT)
#define SATP_MODE_SV48   (9UL << SATP_MODE_SHIFT)

/* Compose a SATP value from a page-table physical address.
 * Result: MODE | (root_ppn) where root_ppn = pgd_pa >> PAGE_SHIFT. */
#define MAKE_SATP(mode, pgd_pa)  ((mode) | (((pgd_pa) >> 12) & SATP_PPN_MASK))

/* SSTATUS bits we touch at boot — disable FP / vector at entry so that an
 * accidental FP / V instruction in early code traps cleanly rather than
 * silently using dirty state from before reset. */
#define SR_FS_OFF        (0UL << 13)
#define SR_VS_OFF        (0UL << 9)

#endif /* _ASM_RISCV_CSR_H */
