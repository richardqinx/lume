/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * SLUB public API
 *
 * This header exposes the allocator entry points to the rest of the kernel.
 * Implementation details stay in mm/slab.h and mm/slab.cc.
 */

#include <lume/types.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize global slab caches. */
void slab_init();

/* Allocate/free kernel memory. */
void* kmalloc(uint32 size);
void kfree(void* ptr);

#ifdef __cplusplus
}
#endif
