#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin

import argparse
import struct
import sys

ELF_MAGIC = b"\x7fELF"
ELFCLASS64 = 2
ELFDATA2LSB = 1
EM_RISCV = 243
SHT_SYMTAB = 2
SHT_RELA = 4
PT_LOAD = 1

R_RISCV_64 = 2
R_RISCV_RELATIVE = 3

RELOC_MAGIC = 0x4C554D45524C4F43  # "LUMERLOC"
RELOC_VERSION = 1
RELOC_ARCH_RISCV = 1


def read_struct(fmt, data, offset):
    size = struct.calcsize(fmt)
    return struct.unpack_from(fmt, data, offset), size


def parse_elf_header(data):
    if data[:4] != ELF_MAGIC:
        raise ValueError("not an ELF file")
    ei_class = data[4]
    ei_data = data[5]
    if ei_class != ELFCLASS64 or ei_data != ELFDATA2LSB:
        raise ValueError("unsupported ELF class/data")
    fmt = "<16sHHIQQQIHHHHHH"
    (e_ident, e_type, e_machine, e_version, e_entry, e_phoff, e_shoff,
     e_flags, e_ehsize, e_phentsize, e_phnum, e_shentsize, e_shnum,
     e_shstrndx), _ = read_struct(fmt, data, 0)
    return {
        "e_machine": e_machine,
        "e_phoff": e_phoff,
        "e_phentsize": e_phentsize,
        "e_phnum": e_phnum,
        "e_shoff": e_shoff,
        "e_shentsize": e_shentsize,
        "e_shnum": e_shnum,
        "e_shstrndx": e_shstrndx,
    }


def parse_program_headers(data, ehdr):
    phdrs = []
    fmt = "<IIQQQQQQ"
    for i in range(ehdr["e_phnum"]):
        off = ehdr["e_phoff"] + i * ehdr["e_phentsize"]
        (p_type, p_flags, p_offset, p_vaddr, p_paddr, p_filesz, p_memsz,
         p_align), _ = read_struct(fmt, data, off)
        phdrs.append({
            "p_type": p_type,
            "p_offset": p_offset,
            "p_vaddr": p_vaddr,
            "p_filesz": p_filesz,
            "p_memsz": p_memsz,
        })
    return phdrs


def parse_section_headers(data, ehdr):
    shdrs = []
    fmt = "<IIQQQQIIQQ"
    for i in range(ehdr["e_shnum"]):
        off = ehdr["e_shoff"] + i * ehdr["e_shentsize"]
        (sh_name, sh_type, sh_flags, sh_addr, sh_offset, sh_size,
         sh_link, sh_info, sh_addralign, sh_entsize), _ = read_struct(fmt, data, off)
        shdrs.append({
            "sh_name": sh_name,
            "sh_type": sh_type,
            "sh_addr": sh_addr,
            "sh_offset": sh_offset,
            "sh_size": sh_size,
            "sh_link": sh_link,
            "sh_entsize": sh_entsize,
        })
    return shdrs


def get_strtab(data, shdrs, idx):
    sh = shdrs[idx]
    return data[sh["sh_offset"]:sh["sh_offset"] + sh["sh_size"]]


def get_section_name(strtab, sh_name):
    end = strtab.find(b"\x00", sh_name)
    if end < 0:
        return ""
    return strtab[sh_name:end].decode("ascii", errors="ignore")


def find_symbol(data, shdrs, name):
    for i, sh in enumerate(shdrs):
        if sh["sh_type"] != SHT_SYMTAB:
            continue
        strtab = get_strtab(data, shdrs, sh["sh_link"])
        entsize = sh["sh_entsize"] or 24
        count = sh["sh_size"] // entsize
        for j in range(count):
            off = sh["sh_offset"] + j * entsize
            (st_name, st_info, st_other, st_shndx, st_value, st_size), _ = read_struct(
                "<IBBHQQ", data, off
            )
            sym_name = get_section_name(strtab, st_name)
            if sym_name == name:
                return st_value
    return None


def read_symtab(data, shdrs, idx):
    sh = shdrs[idx]
    entsize = sh["sh_entsize"] or 24
    count = sh["sh_size"] // entsize
    syms = []
    for j in range(count):
        off = sh["sh_offset"] + j * entsize
        (st_name, st_info, st_other, st_shndx, st_value, st_size), _ = read_struct(
            "<IBBHQQ", data, off
        )
        syms.append((st_value, st_size, st_info, st_shndx))
    return syms


def vaddr_in_load(vaddr, phdrs, size):
    for ph in phdrs:
        if ph["p_type"] != PT_LOAD:
            continue
        start = ph["p_vaddr"]
        end = ph["p_vaddr"] + ph["p_memsz"]
        if vaddr >= start and vaddr + size <= end:
            return True
    return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--elf", required=True)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    data = open(args.elf, "rb").read()
    ehdr = parse_elf_header(data)
    if ehdr["e_machine"] != EM_RISCV:
        raise ValueError("only EM_RISCV supported")

    phdrs = parse_program_headers(data, ehdr)
    shdrs = parse_section_headers(data, ehdr)

    link_base = find_symbol(data, shdrs, "_start")
    if link_base is None:
        raise ValueError("_start symbol not found")

    image_end = find_symbol(data, shdrs, "__lume_image_end")
    if image_end is None:
        raise ValueError("__lume_image_end symbol not found")
    image_size = image_end - link_base

    entries = []
    for sh in shdrs:
        if sh["sh_type"] != SHT_RELA:
            continue
        if sh["sh_link"] >= len(shdrs):
            continue
        symtab = read_symtab(data, shdrs, sh["sh_link"])
        entsize = sh["sh_entsize"] or 24
        count = sh["sh_size"] // entsize
        for i in range(count):
            off = sh["sh_offset"] + i * entsize
            (r_offset, r_info, r_addend), _ = read_struct("<QQq", data, off)
            r_type = r_info & 0xFFFFFFFF
            r_sym = r_info >> 32
            if r_type not in (R_RISCV_RELATIVE, R_RISCV_64):
                continue
            if r_offset < link_base or r_offset >= link_base + image_size:
                continue
            if not vaddr_in_load(r_offset, phdrs, 8):
                continue
            ent_offset = r_offset - link_base
            if r_type == R_RISCV_RELATIVE:
                ent_addend = r_addend
                ent_type = 1
            else:
                sym_val = 0
                if r_sym < len(symtab):
                    sym_val = symtab[r_sym][0]
                ent_addend = sym_val + r_addend
                if ent_addend < link_base or ent_addend >= link_base + image_size:
                    continue
                ent_type = 2
            entries.append((ent_offset, ent_addend, ent_type))

    header = struct.pack(
        "<QHHIII",
        RELOC_MAGIC,
        RELOC_VERSION,
        RELOC_ARCH_RISCV,
        24,
        len(entries),
        0,
    )

    with open(args.out, "wb") as f:
        f.write(header)
        for off, add, typ in entries:
            f.write(struct.pack("<QQII", off, add, typ, 0))

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:
        print("gen_reloc: " + str(e), file=sys.stderr)
        sys.exit(1)
