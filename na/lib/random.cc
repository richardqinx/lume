/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/random.h>
#include <arch/random.h>
#include <lume/klog.h>

#include <lume/kprintf.h>

/*
 * Early Boot PRNG (xoshiro256**)
 * State size: 256 bits (4 * 64-bit words)
 * Extremely fast, excellent statistical properties.
 */

static uint64 g_state[4];
static bool g_initialized = false;

static inline uint64 rotl(const uint64 x, int k) {
    return (x << k) | (x >> (64 - k));
}

/* SplitMix64 used to initialize xoshiro state from a single 64-bit seed */
static uint64 splitmix64(uint64& state) {
    uint64 z = (state += 0x9e3779b97f4a7c15ULL);
    z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
    return z ^ (z >> 31);
}

void random_early_init(uint64 seed)
{
    if (g_initialized) return;

    /* If seed is 0 (not provided by bootloader), try hardware */
    if (seed == 0) {
        uint64 hw_val;
        if (arch::get_hw_random(hw_val)) {
            seed = hw_val;
        } else {
            /* Fallback: use boot cycles mixed with a constant */
            seed = arch::get_cycles() ^ 0xdeadbeefbadc0ffeULL;
        }
    }

    uint64 sm_state = seed;
    g_state[0] = splitmix64(sm_state);
    g_state[1] = splitmix64(sm_state);
    g_state[2] = splitmix64(sm_state);
    g_state[3] = splitmix64(sm_state);

    g_initialized = true;
    kprintf("[random] early PRNG initialized, seed=0x%llx\n", seed);
}

uint64 get_random_u64()
{
    if (!g_initialized) {
        random_early_init(0);
    }

    const uint64 result = rotl(g_state[1] * 5, 7) * 9;

    const uint64 t = g_state[1] << 17;

    g_state[2] ^= g_state[0];
    g_state[3] ^= g_state[1];
    g_state[1] ^= g_state[2];
    g_state[0] ^= g_state[3];

    g_state[2] ^= t;
    g_state[3] = rotl(g_state[3], 45);

    /* Mix with current cycles for slight additional unpredictability */
    return result ^ arch::get_cycles();
}

uint32 get_random_u32()
{
    return static_cast<uint32>(get_random_u64() >> 32);
}

void get_random_bytes(void* buf, size_t len)
{
    uint8* p = static_cast<uint8*>(buf);
    while (len >= 8) {
        uint64 val = get_random_u64();
        for (int i = 0; i < 8; i++) {
            p[i] = (val >> (i * 8)) & 0xFF;
        }
        p += 8;
        len -= 8;
    }
    if (len > 0) {
        uint64 val = get_random_u64();
        for (size_t i = 0; i < len; i++) {
            p[i] = (val >> (i * 8)) & 0xFF;
        }
    }
}

void add_device_randomness(const void* buf, size_t len)
{
    /*
     * For now, just mix into the xoshiro state using a simple XOR.
     * In the future, this will feed the CSPRNG entropy pool.
     */
    const uint8* p = static_cast<const uint8*>(buf);
    uint64 mix = arch::get_cycles();
    for (size_t i = 0; i < len; i++) {
        mix = (mix << 5) ^ (mix >> 59) ^ p[i];
    }
    
    g_state[0] ^= mix;
    g_state[1] ^= arch::get_cycles();
}
