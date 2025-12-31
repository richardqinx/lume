#pragma once
#include "common/types.h"

namespace PILC
{
    // Global initialization (executed only once by hart 0)
    void init();

    // Per-core initialization (executed when each CPU starts)
    void inithart();

    // Claim interrupt: Get the currently occurring interrupt number (IRQ)
    int claim();

    // End of interrupt: notify the PLIC that this IRQ has been handled
    void complete(int irq);
} // namespace PILC
