#pragma once
#include "common/types.h"

namespace VM
{
    extern uint64 *kernel_pagetable;

    void kvminit();
    void kvminithart();

    uint64 *uvmcreate();
    void uvminit(uint64 *pagetable, uchar *src, uint64 sz);
    uint64 uvmalloc(uint64 *pagetable, uint64 oldsz, uint64 newsz, int xperm);
    uint64 uvmdealloc(uint64 *pagetable, uint64 oldsz, uint64 newsz);
    void uvmfree(uint64 *pagetable, uint64 sz);
    int uvmcopy(uint64 *oldpt, uint64 *newpt, uint64 sz);
    void uvmunmap(uint64 *pagetable, uint64 va, uint64 npages, int do_free);

    int copyout(uint64 *pagetable, uint64 dstva, char *src, uint64 len);
    int copyin(uint64 *pagetable, char *dst, uint64 srcva, uint64 len);
    int copyinstr(uint64 *pagetable, char *dst, uint64 srcva, uint64 max);

    int handle_cow_fault(uint64 *pagetable, uint64 va);
    int mappages(uint64 *pagetable, uint64 va, uint64 size, uint64 pa, int perm);
}