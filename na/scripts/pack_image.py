#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin

import argparse
import struct
import sys

MAGIC = 0x4C554D45434F4D50  # "LUMECOMP"
COMP_NONE = 0
COMP_LZ4 = 1

HDR_FMT = "<QIHHIIQQQQQQII"
HDR_SIZE = struct.calcsize(HDR_FMT)
HDR_OFFSET = 64


def crc32_update(crc: int, data: bytes) -> int:
    for b in data:
        crc ^= b
        for _ in range(8):
            mask = -(crc & 1) & 0xFFFFFFFF
            crc = ((crc >> 1) ^ (0xEDB88320 & mask)) & 0xFFFFFFFF
    return crc


def crc32_ieee(data: bytes) -> int:
    crc = 0xFFFFFFFF
    crc = crc32_update(crc, data)
    return (crc ^ 0xFFFFFFFF) & 0xFFFFFFFF


def lz4_compress(data: bytes) -> bytes:
    n = len(data)
    if n == 0:
        return b""

    min_match = 4
    hash_log = 16
    hash_size = 1 << hash_log
    max_offset = 65535

    def hash4(b0, b1, b2, b3):
        v = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
        return (v * 2654435761) & (hash_size - 1)

    htab = [-1] * hash_size
    out = bytearray()
    anchor = 0
    i = 0

    while i + min_match <= n:
        h = hash4(data[i], data[i + 1], data[i + 2], data[i + 3])
        ref = htab[h]
        htab[h] = i

        if ref >= 0 and i - ref <= max_offset and data[ref:ref + min_match] == data[i:i + min_match]:
            match_len = min_match
            while i + match_len < n and data[ref + match_len] == data[i + match_len]:
                match_len += 1

            lit_len = i - anchor
            token = (15 if lit_len >= 15 else lit_len) << 4
            match_field = match_len - min_match
            token |= 15 if match_field >= 15 else match_field
            out.append(token)

            if lit_len >= 15:
                l = lit_len - 15
                while l >= 255:
                    out.append(255)
                    l -= 255
                out.append(l)

            out.extend(data[anchor:i])

            offset = i - ref
            out.append(offset & 0xFF)
            out.append((offset >> 8) & 0xFF)

            if match_field >= 15:
                l = match_field - 15
                while l >= 255:
                    out.append(255)
                    l -= 255
                out.append(l)

            i += match_len
            anchor = i
            continue

        i += 1

    lit_len = n - anchor
    token = (15 if lit_len >= 15 else lit_len) << 4
    out.append(token)
    if lit_len >= 15:
        l = lit_len - 15
        while l >= 255:
            out.append(255)
            l -= 255
        out.append(l)
    out.extend(data[anchor:])
    return bytes(out)


def get_header_offset(data: bytes) -> int:
    if len(data) < HDR_OFFSET + HDR_SIZE:
        return -1
    if data[HDR_OFFSET:HDR_OFFSET + 8] != struct.pack("<Q", MAGIC):
        return -1
    return HDR_OFFSET


def read_struct(fmt, data, offset):
    size = struct.calcsize(fmt)
    return struct.unpack_from(fmt, data, offset), size


def parse_elf_symbols(path: str):
    data = open(path, "rb").read()
    if data[:4] != b"\x7fELF":
        return {}
    if data[4] != 2 or data[5] != 1:
        return {}
    (e_ident, e_type, e_machine, e_version, e_entry, e_phoff, e_shoff,
     e_flags, e_ehsize, e_phentsize, e_phnum, e_shentsize, e_shnum,
     e_shstrndx), _ = read_struct("<16sHHIQQQIHHHHHH", data, 0)

    symbols = {}
    for i in range(e_shnum):
        off = e_shoff + i * e_shentsize
        (sh_name, sh_type, sh_flags, sh_addr, sh_offset, sh_size,
         sh_link, sh_info, sh_addralign, sh_entsize), _ = read_struct(
            "<IIQQQQIIQQ", data, off)
        if sh_type != 2:
            continue
        if sh_link >= e_shnum:
            continue
        str_off = e_shoff + sh_link * e_shentsize
        (sname, stype, sflags, saddr, soff, ssize, slink, sinfo,
         salign, sentsz), _ = read_struct("<IIQQQQIIQQ", data, str_off)
        strtab = data[soff:soff + ssize]
        entsize = sh_entsize or 24
        count = sh_size // entsize
        for j in range(count):
            ent_off = sh_offset + j * entsize
            (st_name, st_info, st_other, st_shndx, st_value, st_size), _ = read_struct(
                "<IBBHQQ", data, ent_off)
            if st_name == 0:
                continue
            end = strtab.find(b"\x00", st_name)
            if end < 0:
                continue
            name = strtab[st_name:end].decode("ascii", errors="ignore")
            if name:
                symbols[name] = st_value
        break
    return symbols


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--elf")
    ap.add_argument("--input", required=True)
    ap.add_argument("--output", required=True)
    ap.add_argument("--compress", choices=["none", "lz4"], default="none")
    args = ap.parse_args()

    raw = open(args.input, "rb").read()
    hdr_off = get_header_offset(raw)
    if hdr_off < 0:
        raise ValueError("compressed header magic not found")

    header = list(struct.unpack_from(HDR_FMT, raw, hdr_off))
    if header[0] != MAGIC:
        raise ValueError("bad header magic")
    if header[2] < HDR_SIZE:
        raise ValueError("header_size too small")

    if args.compress == "lz4":
        payload = lz4_compress(raw)
        comp = COMP_LZ4
    else:
        payload = b""
        comp = COMP_NONE

    uncompressed_size = len(raw)
    compressed_size = len(payload)
    payload_offset = (len(raw) + 7) & ~7 if payload else 0
    if payload and args.elf:
        syms = parse_elf_symbols(args.elf)
        link_base = syms.get("_start")
        bss_end = syms.get("_ebss")
        if link_base is not None and bss_end is not None and bss_end >= link_base:
            payload_offset = (bss_end - link_base + 7) & ~7

    header[4] = comp
    header[6] = uncompressed_size
    header[7] = compressed_size
    header[8] = 0  # load_phys_base auto
    header[11] = payload_offset
    header[12] = 0
    header[13] = crc32_ieee(payload) if payload else 0

    header_bytes = struct.pack(HDR_FMT, *header)
    header[12] = crc32_ieee(header_bytes)

    out = bytearray(raw)
    struct.pack_into(HDR_FMT, out, hdr_off, *header)
    if payload:
        if payload_offset > len(out):
            out.extend(b"\x00" * (payload_offset - len(out)))
        out.extend(payload)

    with open(args.output, "wb") as f:
        f.write(out)

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:
        print("pack_image: " + str(e), file=sys.stderr)
        sys.exit(1)
