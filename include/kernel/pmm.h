#pragma once
#include "common/types.h"

#define PHYSTOP (0x80000000 + 128 * 1024 * 1024)
#define PGSIZE 4096

namespace PMM{
    void init();

    void* alloc_page();

    void free_page(void* pa);
}