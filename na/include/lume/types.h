/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * LumeOS Base Type Definitions
 *
 * All kernel code should use these types instead of
 * stdint.h (which may not exist in freestanding mode).
 *
 * Kernel-wide configuration constants are in <lume/config.h>.
 */

using uint8  = unsigned char;
using uint16 = unsigned short;
using uint32 = unsigned int;
using uint64 = unsigned long long;

using int8   = signed char;
using int16  = signed short;
using int32  = signed int;
using int64  = signed long long;

using size_t  = uint64;
using ssize_t = int64;
using uintptr = uint64;

/* Null pointer constant */
#ifndef nullptr
/* C++11 and later have nullptr built-in */
#endif
