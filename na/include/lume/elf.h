/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * ELF64 Type Definitions — Minimal set for loading executables
 * AND for the kernel's own .rela.dyn relocation walk at boot.
 *
 * Follows the ELF specification (Tool Interface Standard, TIS).
 * Only includes what's needed for static ELF64 executable loading.
 *
 * Reference: https://refspecs.linuxfoundation.org/elf/elf.pdf
 */

#include <lume/types.h>

/* ================================================================== */
/*  Basic ELF types                                                   */
/* ================================================================== */

using Elf64_Addr   = uint64;
using Elf64_Off    = uint64;
using Elf64_Half   = uint16;
using Elf64_Word   = uint32;
using Elf64_Sword  = int32;
using Elf64_Xword  = uint64;
using Elf64_Sxword = int64;

/* ================================================================== */
/*  ELF Header                                                        */
/* ================================================================== */

inline constexpr int EI_NIDENT = 16;

struct Elf64_Ehdr {
    uint8      e_ident[EI_NIDENT];   /* ELF identification */
    Elf64_Half e_type;               /* Object file type */
    Elf64_Half e_machine;            /* Machine type */
    Elf64_Word e_version;            /* Object file version */
    Elf64_Addr e_entry;              /* Entry point address */
    Elf64_Off  e_phoff;              /* Program header table offset */
    Elf64_Off  e_shoff;              /* Section header table offset */
    Elf64_Word e_flags;              /* Processor-specific flags */
    Elf64_Half e_ehsize;             /* ELF header size */
    Elf64_Half e_phentsize;          /* Program header entry size */
    Elf64_Half e_phnum;              /* Number of program headers */
    Elf64_Half e_shentsize;          /* Section header entry size */
    Elf64_Half e_shnum;              /* Number of section headers */
    Elf64_Half e_shstrndx;           /* Section name string table index */
};

/* e_ident[] indices */
inline constexpr int EI_MAG0    = 0;
inline constexpr int EI_MAG1    = 1;
inline constexpr int EI_MAG2    = 2;
inline constexpr int EI_MAG3    = 3;
inline constexpr int EI_CLASS   = 4;
inline constexpr int EI_DATA    = 5;
inline constexpr int EI_VERSION = 6;
inline constexpr int EI_OSABI   = 7;

/* e_ident[] magic */
inline constexpr uint8 ELFMAG0 = 0x7f;
inline constexpr uint8 ELFMAG1 = 'E';
inline constexpr uint8 ELFMAG2 = 'L';
inline constexpr uint8 ELFMAG3 = 'F';

/* e_ident[EI_CLASS] */
inline constexpr uint8 ELFCLASS64 = 2;

/* e_ident[EI_DATA] */
inline constexpr uint8 ELFDATA2LSB = 1;   /* Little-endian */

/* e_type */
inline constexpr Elf64_Half ET_EXEC = 2;  /* Executable */
inline constexpr Elf64_Half ET_DYN  = 3;  /* Shared object (PIE) */

/* e_machine */
inline constexpr Elf64_Half EM_RISCV = 243;

/* ================================================================== */
/*  Program Header                                                    */
/* ================================================================== */

struct Elf64_Phdr {
    Elf64_Word  p_type;     /* Segment type */
    Elf64_Word  p_flags;    /* Segment flags */
    Elf64_Off   p_offset;   /* File offset */
    Elf64_Addr  p_vaddr;    /* Virtual address */
    Elf64_Addr  p_paddr;    /* Physical address (unused) */
    Elf64_Xword p_filesz;   /* Size in file */
    Elf64_Xword p_memsz;    /* Size in memory (>= p_filesz, diff is BSS) */
    Elf64_Xword p_align;    /* Alignment */
};

/* p_type values */
inline constexpr Elf64_Word PT_NULL    = 0;
inline constexpr Elf64_Word PT_LOAD    = 1;
inline constexpr Elf64_Word PT_DYNAMIC = 2;
inline constexpr Elf64_Word PT_INTERP  = 3;
inline constexpr Elf64_Word PT_NOTE    = 4;
inline constexpr Elf64_Word PT_PHDR    = 6;
inline constexpr Elf64_Word PT_GNU_STACK = 0x6474e551;

/* p_flags values */
inline constexpr Elf64_Word PF_X = 0x1;   /* Execute */
inline constexpr Elf64_Word PF_W = 0x2;   /* Write */
inline constexpr Elf64_Word PF_R = 0x4;   /* Read */

/* ================================================================== */
/*  Auxiliary Vector types                                            */
/* ================================================================== */

struct Elf64_auxv_t {
    uint64 a_type;
    uint64 a_val;
};

inline constexpr uint64 AT_NULL   = 0;
inline constexpr uint64 AT_PHDR   = 3;
inline constexpr uint64 AT_PHENT  = 4;
inline constexpr uint64 AT_PHNUM  = 5;
inline constexpr uint64 AT_PAGESZ = 6;
inline constexpr uint64 AT_ENTRY  = 9;
inline constexpr uint64 AT_UID    = 11;
inline constexpr uint64 AT_EUID   = 12;
inline constexpr uint64 AT_GID    = 13;
inline constexpr uint64 AT_EGID   = 14;
inline constexpr uint64 AT_RANDOM = 25;
inline constexpr uint64 AT_BASE   = 7;   /* PIE load base address */

/* ================================================================== */
/*  RELA relocation entry — used by the kernel's own .rela.dyn walk   */
/*  at boot (relocate_kernel in arch/riscv/mm/init.cc).               */
/* ================================================================== */

struct Elf64_Rela {
    Elf64_Addr   r_offset;   /* link-time VA of the slot to patch */
    Elf64_Xword  r_info;     /* r_sym << 32 | r_type */
    Elf64_Sxword r_addend;   /* link-time value of the target */
};

#define ELF64_R_TYPE(info)   ((info) & 0xFFFFFFFFULL)

/* RISC-V relocation types — only the ones a PIE-linked kernel emits
 * into .rela.dyn under `-shared -Bsymbolic`. */
inline constexpr uint32 R_RISCV_NONE     = 0;
inline constexpr uint32 R_RISCV_64       = 2;
inline constexpr uint32 R_RISCV_RELATIVE = 3;
