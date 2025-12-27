#pragma once
#include "common/types.h"

namespace VM
{
    typedef uint64_t *pagetable_t;
    typedef uint64_t pte_t;

    pte_t *walk(pagetable_t pagetable, uint64 va, int alloc);
    int mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm);
    void kvmmap(uint64 va, uint64 pa, uint64 sz, int perm);
    void kvminit();
    void kvminithart();
    pagetable_t uvmcreate();
    void uvminit(pagetable_t pagetable, uchar *src, uint sz);
    void uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free);
    void uvmfree(pagetable_t pagetable, uint64 sz);
    int uvmcopy(pagetable_t oldpt, pagetable_t newpt, uint64 sz);
    uint64 uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz);
    uint64 uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz);
    int copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len);
}