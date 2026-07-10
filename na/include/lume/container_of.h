/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * container_of.h — Recover containing struct from member pointer
 *
 * Equivalent to Linux include/linux/container_of.h.
 */

#include <lume/types.h>

#define container_of(ptr, type, member) \
    reinterpret_cast<type*>( \
        reinterpret_cast<uintptr>(ptr) - \
        reinterpret_cast<uintptr>(&(reinterpret_cast<type*>(0)->member)))
