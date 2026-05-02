/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

enum class RandomSeedSource : uint8 {
	Unknown = 0,
	FdtProvided,
	HwRandom,
	CycleFallback,
};

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

/* Early-seed metadata (for boot diagnostics/KASLR logs). */
RandomSeedSource random_early_seed_source();
uint64 random_early_seed_value();
const char* random_seed_source_name(RandomSeedSource source);
