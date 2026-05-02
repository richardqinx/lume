/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

/*
 * MI: Machine-Independent Random Number Generator API
 *
 * Provides early PRNG and eventually a full CSPRNG.
 */

/*
 * Initialize early PRNG with a seed (e.g., from FDT).
 * If seed is 0, attempts to use hardware TRNG or falls back to timer jitter.
 */
void random_early_init(uint64 seed);

/* Consume random bits */
uint64 get_random_u64();
uint32 get_random_u32();
void get_random_bytes(void* buf, size_t len);

/* Inject entropy (for future interrupt/device mixing) */
void add_device_randomness(const void* buf, size_t len);
