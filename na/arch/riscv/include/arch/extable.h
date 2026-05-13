/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#ifndef __ASSEMBLER__

#include <lume/types.h>

/*
 * Exception table entry.
 * insn: offset from this struct to the faulting instruction.
 * fixup: offset from this struct to the fixup code.
 * 
 * Using relative offsets avoids absolute relocations and saves space.
 */
struct ExceptionTableEntry {
    int32 insn;
    int32 fixup;
};

/* Search the exception table for a given PC. Returns fixup address, or 0 if not found. */
uint64 search_extable(uint64 pc);

/* Sorts the exception table at boot for binary search O(log N). */
void extable_init();

#endif /* __ASSEMBLER__ */

/*
 * EXTABLE macro for assembly usage.
 * Appends an entry to the .extable section.
 */
#ifdef __ASSEMBLER__

#define EXTABLE(insn, fixup) \
    .pushsection .extable, "a"; \
    .balign 4; \
    .long insn - .; \
    .long fixup - .; \
    .popsection

#else /* !__ASSEMBLER__ */

/* Stringified macro for inline assembly */
#define _ASM_EXTABLE(insn, fixup) \
    ".pushsection .extable, \"a\"\n" \
    ".balign 4\n" \
    ".long " #insn " - .\n" \
    ".long " #fixup " - .\n" \
    ".popsection\n"

#define EXTABLE(insn, fixup) _ASM_EXTABLE(insn, fixup)

#endif /* __ASSEMBLER__ */
