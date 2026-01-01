#pragma once
#include "common/types.h"

#define ELF_MAGIC 0x464C457F // "\x7FELF" in little endian

// ELF File Header
struct elfhdr
{
    uint32 magic; // Must equal ELF_MAGIC
    uint8 elf[12];
    uint16 type;
    uint16 machine;
    uint32 version;
    uint64 entry; // Program Entry Point (Virtual Address)
    uint64 phoff; // File offset of the Program Header Table
    uint64 shoff;
    uint32 flags;
    uint16 ehsize;
    uint16 phentsize;
    uint16 phnum; // Number of Program Headers
    uint16 shentsize;
    uint16 shnum;
    uint16 shstrndx;
};

// Program Header
// Describes how to load segments from a file into memory
struct proghdr
{
    uint32 type;
    uint32 flags;
    uint64 off;   // Offset of the section in the file
    uint64 vaddr; // Virtual address of the segment in memory
    uint64 paddr;
    uint64 filesz; // Size of the section in the file
    uint64 memsz;  // The size of the segment in memory (memsz >= filesz)
    uint64 align;
};

// Values for Proghdr type
#define ELF_PROG_LOAD 1

// Flag bits for Proghdr flags
#define ELF_PROG_FLAG_EXEC 1
#define ELF_PROG_FLAG_WRITE 2
#define ELF_PROG_FLAG_READ 4