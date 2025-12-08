#pragma once
#include "common/types.h"

namespace VM
{
    typedef uint64_t* pagetable_t;
    typedef uint64_t pte_t;
    typedef uint64_t uint64;

    #define PTE_V (1L << 0)
    #define PTE_R (1L << 1)
    #define PTE_W (1L << 2)
    #define PTE_X (1L << 3)
    #define PTE_U (1L << 4)

    #define SATP_SV39 (8L << 60)
    #define MAKE_SATP(pagetable) (SATP_SV39 | (((uint64)pagetable) >> 12))

    void kvminit();
    void kvminithart();
}