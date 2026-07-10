/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Placement New for Freestanding Environments
 *
 * In -ffreestanding -nostdlib mode, <new> may not be available.
 * LumeOS provides its own placement new/delete operators.
 *
 * Usage: g_obj = new (g_obj_buf) MyClass(args...);
 *
 * Reference: docs/specs/global_init.md §3.1
 */

inline void* operator new(decltype(sizeof(0)), void* ptr) noexcept { return ptr; }
inline void  operator delete(void*, void*) noexcept {}
