/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/decompress.h>

int lz4_decompress(const uint8* src, uint32 src_len, uint8* dst, uint32 dst_cap)
{
    const uint8* ip = src;
    const uint8* iend = src + src_len;
    uint8* op = dst;
    uint8* oend = dst + dst_cap;

    while (ip < iend) {
        uint8 token = *ip++;
        uint32 lit_len = token >> 4;

        if (lit_len == 15) {
            uint8 s = 0;
            do {
                if (ip >= iend) {
                    return -1;
                }
                s = *ip++;
                lit_len += s;
            } while (s == 255);
        }

        if (ip + lit_len > iend) {
            return -1;
        }
        if (op + lit_len > oend) {
            return -1;
        }

        for (uint32 i = 0; i < lit_len; ++i) {
            *op++ = *ip++;
        }

        if (ip >= iend) {
            break;
        }
        if (ip + 2 > iend) {
            return -1;
        }

        uint32 off = static_cast<uint32>(ip[0]) | (static_cast<uint32>(ip[1]) << 8);
        ip += 2;
        if (off == 0 || off > static_cast<uint32>(op - dst)) {
            return -1;
        }

        uint32 match_len = token & 0x0F;
        if (match_len == 15) {
            uint8 s = 0;
            do {
                if (ip >= iend) {
                    return -1;
                }
                s = *ip++;
                match_len += s;
            } while (s == 255);
        }
        match_len += 4;

        if (op + match_len > oend) {
            return -1;
        }

        uint8* match = op - off;
        for (uint32 i = 0; i < match_len; ++i) {
            op[i] = match[i];
        }
        op += match_len;
    }

    return static_cast<int>(op - dst);
}
