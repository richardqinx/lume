/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * RISC-V early memory-management bootstrap.
 *
 * Mirrors Linux arch/riscv/mm/init.c — same file name, same C function
 * names (setup_vm / relocate_enable_mmu / relocate_kernel), same global
 * state (kernel_map, early_pg_dir, trampoline_pg_dir).  head.S calls
 * setup_vm immediately after BSS-clear, then later calls
 * relocate_enable_mmu, which switches SATP, jumps to higher-half VA,
 * and finally calls relocate_kernel to apply .rela.dyn.
 *
 * Differences from Linux:
 *   - KASLR offset is hard-wired to 0 for now (no pi/ subsystem) — the
 *     code path that would consume kernel_map.virt_offset is in place
 *     so adding pi/-based seed reading later only requires populating
 *     that one field.
 *   - Only 1 GiB superpages supported in create_pgd_mapping; sufficient
 *     for the early page tables.  Finer-grained mappings come from
 *     vmm_init() once slab is up.
 */

#include <lume/init.h>
#include <lume/setup.h>
#include <lume/elf.h>
#include <lume/kernel_map.h>
#include <lume/types.h>
#include <asm/page.h>
#include <asm/csr.h>
#include <asm/pgtable.h>
#include <asm/sections.h>

/*
 * Global kernel mapping descriptor — single source of truth for the
 * runtime-vs-link address relationship.  Lives in .data so its initial
 * zero contents survive the BSS-clear that runs before setup_vm fills
 * the fields.  Read by VMM, page-fault handler, ptdump, etc.
 *
 * Linux equivalent: arch/riscv/mm/init.c::kernel_map
 */
struct kernel_mapping kernel_map __attribute__((section(".data")));

/*
 * create_pgd_mapping — install one PGD entry covering a 1 GiB region.
 *
 * Only 1 GiB superpages are supported in this early variant; setup_vm
 * needs nothing finer.  Identical interface to Linux's same-named
 * function in arch/riscv/mm/init.c, restricted in arity.
 */
extern "C" void create_pgd_mapping(pgd_t *pgdir, unsigned long va,
                                   unsigned long pa, unsigned long sz,
                                   unsigned long prot)
{
    /* This early variant only supports 1 GiB superpages. */
    if (sz != PGDIR_SIZE) {
        return;
    }

    /* SV39 PGD index = (va >> 30) & 0x1FF — see Volume II, §4.4.1.
     * Each PGD entry is 8 bytes; pgdir[i] is the slot for that VPN[2]. */
    unsigned long idx = (va >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1);

    /* PTE PPN field: physical page number shifted up by 10 (SV39 PTE
     * layout: bits [53:10] = PPN, bits [9:0] = flags). */
    unsigned long ppn = pa >> PAGE_SHIFT;
    pgdir[idx].pgd = (ppn << 10) | prot;
}

/*
 * setup_vm — fill kernel_map and build early_pg_dir + trampoline_pg_dir.
 *
 * Called from head.S after BSS is cleared, with:
 *   load_pa = runtime physical address of _start
 *   dtb_pa  = physical address of the device tree blob (from a1)
 *
 * Mirrors Linux arch/riscv/mm/init.c::setup_vm.  The actual SATP write
 * happens later in relocate_enable_mmu; here we only populate page
 * tables and the kernel_map descriptor.
 */
extern "C" void __init setup_vm(uintptr_t load_pa, uintptr_t dtb_pa)
{
    (void)dtb_pa;   /* KASLR pi/ subsystem will consume this later. */

    /* --- 1. Fill kernel_map ----------------------------------------- */

    /* KASLR offset = 0 in this configuration. */
    kernel_map.virt_offset         = 0;
    kernel_map.virt_addr           = KERNEL_LINK_ADDR + kernel_map.virt_offset;
    kernel_map.phys_addr           = load_pa;
    kernel_map.size                = (uintptr_t)_kernel_end - (uintptr_t)_start;
    kernel_map.page_offset         = PAGE_OFFSET;

    /* Mirrors Linux: va_pa_offset is the constant added to a physical
     * address to obtain its direct-map VA. */
    kernel_map.va_pa_offset        = PAGE_OFFSET - load_pa;

    /* va_kernel_pa_offset is the constant added to a load PA to obtain
     * the kernel's link VA (used by relocate_enable_mmu to fix sp/ra). */
    kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - load_pa;

    /* --- 2. Build early_pg_dir ------------------------------------- *
     *
     * SV39 root page table — 4 entries cover identity + higher-half for
     * both MMIO (PA 0x0000_0000, 1 GiB) and RAM (PA 0x8000_0000, 1 GiB):
     *
     *   [0]    identity  PA 0x0000_0000  →  VA 0x0000_0000
     *   [2]    identity  PA 0x8000_0000  →  VA 0x8000_0000
     *   [256]  high-half PA 0x0000_0000  →  VA 0xFFFFFFC000000000
     *   [258]  high-half PA 0x8000_0000  →  VA 0xFFFFFFC080000000
     *
     * Identity mappings keep PC valid right after csrw satp.  High-half
     * mappings let the post-MMU `jr` to .Lhigher_half resolve. */
    create_pgd_mapping(early_pg_dir, 0x00000000UL, 0x00000000UL,
                       PGDIR_SIZE, PAGE_KERNEL_EXEC);
    create_pgd_mapping(early_pg_dir, 0x80000000UL, 0x80000000UL,
                       PGDIR_SIZE, PAGE_KERNEL_EXEC);
    create_pgd_mapping(early_pg_dir, PAGE_OFFSET + 0x00000000UL,
                       0x00000000UL, PGDIR_SIZE, PAGE_KERNEL_EXEC);
    create_pgd_mapping(early_pg_dir, PAGE_OFFSET + 0x80000000UL,
                       0x80000000UL, PGDIR_SIZE, PAGE_KERNEL_EXEC);

    /* --- 3. Build trampoline_pg_dir -------------------------------- *
     *
     * The trampoline maps just the gigapage containing _start, both at
     * its identity PA and at its higher-half VA.  This is the page
     * table SATP holds during the single instruction window between
     * "MMU off" and "MMU on with early_pg_dir" — the PC must resolve
     * under both, so we re-use the same two entries above. */
    create_pgd_mapping(trampoline_pg_dir, load_pa & PGDIR_MASK,
                       load_pa & PGDIR_MASK, PGDIR_SIZE, PAGE_KERNEL_EXEC);
    create_pgd_mapping(trampoline_pg_dir,
                       (kernel_map.virt_addr) & PGDIR_MASK,
                       load_pa & PGDIR_MASK, PGDIR_SIZE, PAGE_KERNEL_EXEC);
}

/*
 * relocate_kernel — walk .rela.dyn and apply R_RISCV_RELATIVE entries.
 *
 * Called from relocate_enable_mmu *after* the SATP switch and the jump
 * to higher-half VA — meaning __rela_dyn_start / __rela_dyn_end resolve
 * to valid higher-half pointers we can dereference directly.
 *
 * Mirrors Linux arch/riscv/mm/init.c::relocate_kernel.  Key invariant:
 * even when kaslr_offset == 0, the slot store MUST still happen — the
 * linker leaves R_RISCV_RELATIVE slots zero-filled at link time, and
 * only relocate_kernel writes the link-time addend into them.  Without
 * this pass, .init_array entries (and every other relocated symbol)
 * are NULL pointers.
 */
void __init relocate_kernel(void)
{
    auto *rela     = (Elf64_Rela *)__rela_dyn_start;
    auto *rela_end = (Elf64_Rela *)__rela_dyn_end;

    const uint64 kaslr_offset = kernel_map.virt_offset;

    for (; rela < rela_end; ++rela) {
        if (ELF64_R_TYPE(rela->r_info) != R_RISCV_RELATIVE) {
            continue;
        }
        auto *slot = (Elf64_Addr *)(rela->r_offset + kaslr_offset);
        *slot = (Elf64_Addr)(rela->r_addend) + kaslr_offset;
    }
}

/*
 * relocate_enable_mmu — switch SATP, jump to higher-half, apply relocations.
 *
 * Called from head.S after setup_vm has filled kernel_map and built the
 * page tables.  Equivalent to Linux's same-named asmlinkage routine but
 * written in C++ so it can share kernel_map / pgtable definitions with
 * setup_vm directly.
 *
 * Three logical steps:
 *
 *   1. csrw satp ← trampoline_pg_dir.  PC continues running at the
 *      identity PA, which the trampoline still maps; the high-half PA
 *      mapping is now also live.
 *
 *   2. la t0, .Lvirt; add t0, t0, va_kernel_pa_offset; jr t0.
 *      A PC-relative `la` under medany yields the runtime PA of the
 *      label; adding va_kernel_pa_offset (= link_va - load_pa) converts
 *      it to the link-time higher-half VA, which the trampoline maps.
 *      The `jr` then atomically pushes PC into higher-half space.
 *
 *   3. csrw satp ← early_pg_dir.  We're now executing at higher-half
 *      VA, so the trampoline can be retired in favour of the full
 *      early page table.  sp / ra / gp must be slid to higher-half too,
 *      otherwise the next ret-or-call uses physical-low addresses
 *      whose mapping is about to disappear when vmm_init drops the
 *      identity entries.
 *
 *   4. Call relocate_kernel — now safe, because all link-time VA
 *      pointers in __rela_dyn_start[..] dereference correctly.
 */
extern "C" void __init relocate_enable_mmu(pgd_t *pgdir)
{
    (void)pgdir;  /* head.S passes early_pg_dir for documentation; we
                   * read the global symbol directly inside the asm. */

    const unsigned long va_kernel_pa_offset = kernel_map.va_kernel_pa_offset;
    const unsigned long satp_mode           = SATP_MODE_SV39;

    asm volatile (
        /* Step 1: csrw satp <- trampoline */
        "la     t0, trampoline_pg_dir\n"
        "srli   t0, t0, 12\n"
        "or     t0, t0, %[mode]\n"
        "csrw   satp, t0\n"
        "sfence.vma\n"

        /* Step 2: jump to higher-half VA */
        "la     t0, 1f\n"
        "add    t0, t0, %[off]\n"
        "jr     t0\n"
        "1:\n"

        /* Step 3a: csrw satp <- early_pg_dir (now in higher-half) */
        "la     t0, early_pg_dir\n"
        "srli   t0, t0, 12\n"
        "or     t0, t0, %[mode]\n"
        "csrw   satp, t0\n"
        "sfence.vma\n"

        /* Step 3b: slide sp / ra / gp to higher-half */
        "add    sp, sp, %[off]\n"
        "add    ra, ra, %[off]\n"
        ".option push\n"
        ".option norelax\n"
        "la     gp, __global_pointer$\n"
        ".option pop\n"
        :
        : [off]  "r"(va_kernel_pa_offset),
          [mode] "r"(satp_mode)
        : "t0", "memory"
    );

    /* Step 4: apply .rela.dyn now that VA dereferences work. */
    relocate_kernel();
}
