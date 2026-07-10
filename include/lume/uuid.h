/* SPDX-License-Identifier: GPL-2.0 */
/*
 * UUID/GUID definition
 *
 * Copyright (C) 2010, 2016 Intel Corp.
 *	Huang Ying <ying.huang@intel.com>
 */

#pragma once

#include <lume/types.h>
#include <libc-shim/string.h>

constexpr uint32 UUID_SIZE = 16;
constexpr uint32 UUID_STRING_LEN = 36;

static inline int uuid_hex_value(char c)
{
    if (c >= '0' && c <= '9') {
        return c - '0';
    }
    if (c >= 'a' && c <= 'f') {
        return c - 'a' + 10;
    }
    if (c >= 'A' && c <= 'F') {
        return c - 'A' + 10;
    }
    return -1;
}

static inline bool uuid_parse_raw(const char* uuid, uint8 out[UUID_SIZE])
{
    if (!uuid) {
        return false;
    }
    if (strlen(uuid) != UUID_STRING_LEN) {
        return false;
    }
    if (uuid[8] != '-' || uuid[13] != '-' || uuid[18] != '-' || uuid[23] != '-') {
        return false;
    }

    int out_index = 0;
    for (int i = 0; i < static_cast<int>(UUID_STRING_LEN); ) {
        if (uuid[i] == '-') {
            ++i;
            continue;
        }

        int hi = uuid_hex_value(uuid[i]);
        int lo = uuid_hex_value(uuid[i + 1]);
        if (hi < 0 || lo < 0) {
            return false;
        }

        out[out_index++] = static_cast<uint8>((hi << 4) | lo);
        i += 2;
    }

    return out_index == static_cast<int>(UUID_SIZE);
}

struct uuid_base {
    uint8 b[UUID_SIZE];

    bool is_null() const
    {
        for (uint32 i = 0; i < UUID_SIZE; ++i) {
            if (b[i] != 0) {
                return false;
            }
        }
        return true;
    }

    bool operator==(const uuid_base& other) const
    {
        return memcmp(b, other.b, UUID_SIZE) == 0;
    }

    bool operator!=(const uuid_base& other) const
    {
        return !(*this == other);
    }
};

struct uuid_t : public uuid_base {
    explicit uuid_t(const uint8 in_b[UUID_SIZE])
    {
        memcpy(b, in_b, UUID_SIZE);
    }

    explicit constexpr uuid_t(uint32 a, uint16 b, uint16 c, uint8 d0, uint8 d1,
                              uint8 d2, uint8 d3, uint8 d4, uint8 d5,
                              uint8 d6, uint8 d7)
        : uuid_base{{
              static_cast<uint8>((a >> 24) & 0xff),
              static_cast<uint8>((a >> 16) & 0xff),
              static_cast<uint8>((a >> 8) & 0xff),
              static_cast<uint8>(a & 0xff),
              static_cast<uint8>((b >> 8) & 0xff),
              static_cast<uint8>(b & 0xff),
              static_cast<uint8>((c >> 8) & 0xff),
              static_cast<uint8>(c & 0xff),
              d0, d1, d2, d3, d4, d5, d6, d7
          }}
    {
    }

    constexpr uuid_t() : uuid_base{{0}} {}

    static bool parse(const char* uuid, uuid_t& out)
    {
        uint8 tmp[UUID_SIZE];
        if (!uuid_parse_raw(uuid, tmp)) {
            return false;
        }

        memcpy(out.b, tmp, UUID_SIZE);
        return true;
    }

    static bool is_valid(const char* uuid)
    {
        uint8 tmp[UUID_SIZE];
        return uuid_parse_raw(uuid, tmp);
    }

    static constexpr uuid_t null()
    {
        return uuid_t();
    }

    void import_bytes(const uint8* src)
    {
        memcpy(b, src, UUID_SIZE);
    }

    void export_bytes(uint8* dst) const
    {
        memcpy(dst, b, UUID_SIZE);
    }
};

struct guid_t : public uuid_base {
    explicit guid_t(const uint8 in_b[UUID_SIZE])
    {
        memcpy(b, in_b, UUID_SIZE);
    }

    explicit constexpr guid_t(uint32 a, uint16 b, uint16 c, uint8 d0, uint8 d1,
                              uint8 d2, uint8 d3, uint8 d4, uint8 d5,
                              uint8 d6, uint8 d7)
        : uuid_base{{
              static_cast<uint8>(a & 0xff),
              static_cast<uint8>((a >> 8) & 0xff),
              static_cast<uint8>((a >> 16) & 0xff),
              static_cast<uint8>((a >> 24) & 0xff),
              static_cast<uint8>(b & 0xff),
              static_cast<uint8>((b >> 8) & 0xff),
              static_cast<uint8>(c & 0xff),
              static_cast<uint8>((c >> 8) & 0xff),
              d0, d1, d2, d3, d4, d5, d6, d7
          }}
    {
    }

    constexpr guid_t() : uuid_base{{0}} {}
    static bool parse(const char* uuid, guid_t& out)
    {
        uint8 tmp[UUID_SIZE];
        if (!uuid_parse_raw(uuid, tmp)) {
            return false;
        }

        static constexpr uint8 guid_index[UUID_SIZE] = {
            3, 2, 1, 0, 5, 4, 7, 6, 8, 9, 10, 11, 12, 13, 14, 15,
        };

        for (int i = 0; i < static_cast<int>(UUID_SIZE); ++i) {
            out.b[guid_index[i]] = tmp[i];
        }
        return true;
    }

    static bool is_valid(const char* uuid)
    {
        uint8 tmp[UUID_SIZE];
        return uuid_parse_raw(uuid, tmp);
    }

    static constexpr guid_t null()
    {
        return guid_t();
    }

    void import_bytes(const uint8* src)
    {
        memcpy(b, src, UUID_SIZE);
    }

    void export_bytes(uint8* dst) const
    {
        memcpy(dst, b, UUID_SIZE);
    }
};

