/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <arch/random.h>
#include <lume/klog.h>

namespace arch {

bool get_hw_random(uint64& value)
{
    /*
     * Real implementation would check for Zkr extension and execute:
     *   csrr x, seed
     * 
     * Since QEMU virt doesn't guarantee Zkr, we return false to
     * force the MI layer to use the timer fallback.
     */
    return false;
}

} // namespace arch
