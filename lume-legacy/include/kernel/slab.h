// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */

#pragma once
#include "common/types.h"

namespace Slab
{
    void init();

    void *kmalloc(uint64 size);
    void kfree(void *ptr);
}