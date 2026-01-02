#pragma once
#include "common/types.h"

namespace Slab
{
    void init();

    void *kmalloc(uint64 size);
    void kfree(void *ptr);
}