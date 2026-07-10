/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * FDT Property
 *
 * Represents a single property within a DeviceNode (e.g. "reg",
 * "compatible").  The value pointer points directly into the
 * original FDT blob — no copies are made.
 *
 * Reference: docs/specs/fdt.md §3.1
 */

#include <lume/types.h>
#include <lume/list.h>

struct FdtProperty {
    const char *name;   // Property name (points into FDT strings block)
    const void *value;  // Raw property data (points into FDT struct block)
    int len;            // Length of value in bytes
    list_node link;     // Intrusive link into DeviceNode's property list
};
