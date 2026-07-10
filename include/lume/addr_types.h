/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

struct PhysAddr {
    uint64 raw;
};

struct VirtAddr {
    uint64 raw;
};

struct Pfn {
    uint64 raw;
};

inline constexpr PhysAddr phys_addr(uint64 raw) { return PhysAddr{raw}; }
inline constexpr VirtAddr virt_addr(uint64 raw) { return VirtAddr{raw}; }
inline constexpr Pfn pfn(uint64 raw) { return Pfn{raw}; }

inline constexpr bool operator==(PhysAddr a, PhysAddr b) { return a.raw == b.raw; }
inline constexpr bool operator!=(PhysAddr a, PhysAddr b) { return a.raw != b.raw; }
inline constexpr bool operator==(VirtAddr a, VirtAddr b) { return a.raw == b.raw; }
inline constexpr bool operator!=(VirtAddr a, VirtAddr b) { return a.raw != b.raw; }
inline constexpr bool operator==(Pfn a, Pfn b) { return a.raw == b.raw; }
inline constexpr bool operator!=(Pfn a, Pfn b) { return a.raw != b.raw; }
