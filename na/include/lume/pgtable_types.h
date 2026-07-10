/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Page Table Entry Types — strongly typed wrappers.
 *
 * Layout and macro names mirror Linux's arch/riscv/include/asm/page.h
 * and pgtable-64.h so that arch/riscv/mm/init.c can be copied from
 * Linux without source edits.  The wrapped struct prevents accidental
 * mixing of a pte_t with a pgd_t or a raw physical address, which the
 * previous bare-uint64 design in pmap.cc could not catch.
 *
 * Underlying width on RV64 LP64 is `unsigned long` = 64 bits, matching
 * Linux exactly — assembly references (e.g. REG_S/REG_L on a pte_t*)
 * see the same byte layout.
 *
 * SV39 uses 3 levels (pgd -> pmd -> pte); SV48 uses 4 (pgd -> pud ->
 * pmd -> pte).  p4d_t/pud_t are emitted unconditionally so that the
 * higher-level abstractions in asm-generic/pgtable-nopud.h and friends
 * (which Linux uses to collapse unused levels) work without #ifdef.
 */

#include <lume/types.h>

typedef struct {
    unsigned long pte;
} pte_t;

typedef struct {
    unsigned long pmd;
} pmd_t;

typedef struct {
    unsigned long pud;
} pud_t;

typedef struct {
    unsigned long p4d;
} p4d_t;

typedef struct {
    unsigned long pgd;
} pgd_t;

typedef struct {
    unsigned long pgprot;
} pgprot_t;

typedef struct page *pgtable_t;

/* Field accessors */
#define pte_val(x)    ((x).pte)
#define pmd_val(x)    ((x).pmd)
#define pud_val(x)    ((x).pud)
#define p4d_val(x)    ((x).p4d)
#define pgd_val(x)    ((x).pgd)
#define pgprot_val(x) ((x).pgprot)

/* Constructors (cast raw uint64 to wrapped type) */
#define __pte(x)    ((pte_t)    { (x) })
#define __pmd(x)    ((pmd_t)    { (x) })
#define __pud(x)    ((pud_t)    { (x) })
#define __p4d(x)    ((p4d_t)    { (x) })
#define __pgd(x)    ((pgd_t)    { (x) })
#define __pgprot(x) ((pgprot_t) { (x) })

#define PTE_FMT "%016lx"
