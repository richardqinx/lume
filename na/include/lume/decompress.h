/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

/*
 * LZ4 block decompressor (no frame headers). Returns bytes written or -1.
 */
int lz4_decompress(const uint8* src, uint32 src_len, uint8* dst, uint32 dst_cap);
