#include "kernel/mm.h"
#include "kernel/pmm.h"
#include "kernel/riscv.h"
#include "common/types.h"
#include "lib/string.h"
#include "drivers/uart.h"

// COW Flag (PTE bit 8)
#define PTE_COW (1L << 8)

extern "C"
{
    extern char kernel_end[];
    extern char trampoline[];
}

namespace VM
{

    uint64 *kernel_pagetable;

    static void page_ref_inc(uint64 pa)
    {
        struct Page *p = PMM::pa_to_page(pa);
        if (p)
        {
            __atomic_add_fetch(&p->refcnt, 1, __ATOMIC_RELAXED);
        }
    }

    static bool page_ref_dec(uint64 pa)
    {
        struct Page *p = PMM::pa_to_page(pa);
        if (p)
        {
            if (__atomic_sub_fetch(&p->refcnt, 1, __ATOMIC_RELEASE) == 0)
            {
                return true;
            }
        }
        return false;
    }

    static uint64 *walk(uint64 *pagetable, uint64 va, int alloc)
    {
        if (va >= MAXVA)
            return nullptr;

        for (int level = 2; level > 0; level--)
        {
            uint64 *pte = &pagetable[PX(level, va)];
            if (*pte & PTE_V)
            {
                pagetable = (uint64 *)PTE2PA(*pte);
            }
            else
            {
                if (!alloc || (pagetable = (uint64 *)PMM::alloc_page()) == nullptr)
                    return nullptr;

                memset(pagetable, 0, PGSIZE);
                *pte = PA2PTE(pagetable) | PTE_V;
            }
        }
        return &pagetable[PX(0, va)];
    }

    int mappages(uint64 *pagetable, uint64 va, uint64 size, uint64 pa, int perm)
    {
        uint64 a, last;
        uint64 *pte;

        if (size == 0)
            return -1;

        a = PGROUNDDOWN(va);
        last = PGROUNDDOWN(va + size - 1);

        for (;;)
        {
            if ((pte = walk(pagetable, a, 1)) == nullptr)
                return -1;

            if (*pte & PTE_V)
            {
                return -1;
            }

            *pte = PA2PTE(pa) | perm | PTE_V;

            if (a == last)
                break;
            a += PGSIZE;
            pa += PGSIZE;
        }
        return 0;
    }

    uint64 *uvmcreate()
    {
        uint64 *pagetable = (uint64 *)PMM::alloc_page();
        if (pagetable)
        {
            memset(pagetable, 0, PGSIZE);

            if (mappages(pagetable, TRAMPOLINE, PGSIZE, (uint64)trampoline, PTE_R | PTE_X) < 0)
            {
                PMM::free_page(pagetable);
                return nullptr;
            }
        }
        return pagetable;
    }

    void uvminit(uint64 *pagetable, uchar *src, uint64 sz)
    {
        char *mem;

        if (sz >= PGSIZE)
        {
            Drivers::uart_puts("uvminit: initcode too big!\n");
            return;
        }

        mem = (char *)PMM::alloc_page();
        memset(mem, 0, PGSIZE);

        mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W | PTE_R | PTE_X | PTE_U);
        memmove(mem, src, sz);
    }

    uint64 uvmalloc(uint64 *pagetable, uint64 oldsz, uint64 newsz, int xperm)
    {
        char *mem;
        uint64 a;

        if (newsz < oldsz)
            return oldsz;

        oldsz = PGROUNDUP(oldsz);
        for (a = oldsz; a < newsz; a += PGSIZE)
        {
            mem = (char *)PMM::alloc_page();
            if (mem == nullptr)
            {
                uvmdealloc(pagetable, a, oldsz);
                return 0;
            }
            memset(mem, 0, PGSIZE);
            if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R | PTE_U | xperm) != 0)
            {
                PMM::free_page(mem);
                uvmdealloc(pagetable, a, oldsz);
                return 0;
            }
        }
        return newsz;
    }

    uint64 uvmdealloc(uint64 *pagetable, uint64 oldsz, uint64 newsz)
    {
        if (newsz >= oldsz)
            return oldsz;

        if (PGROUNDUP(newsz) < PGROUNDUP(oldsz))
        {
            int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
            uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
        }

        return newsz;
    }

    void uvmunmap(uint64 *pagetable, uint64 va, uint64 npages, int do_free)
    {
        uint64 a;
        uint64 *pte;

        if ((va % PGSIZE) != 0)
            return;

        for (a = va; a < va + npages * PGSIZE; a += PGSIZE)
        {
            if ((pte = walk(pagetable, a, 0)) == nullptr)
                continue;

            if ((*pte & PTE_V) == 0)
                continue;

            if ((PTE_FLAGS(*pte) & (PTE_R | PTE_W | PTE_X)) == 0)
            {
                continue;
            }

            if (do_free)
            {
                uint64 pa = PTE2PA(*pte);
                if (page_ref_dec(pa))
                {
                    PMM::free_page((void *)pa);
                }
            }
            *pte = 0;
        }
    }

    static void freewalk(uint64 *pagetable)
    {
        for (int i = 0; i < 512; i++)
        {
            uint64 pte = pagetable[i];
            if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0)
            {
                uint64 *child = (uint64 *)PTE2PA(pte);
                freewalk(child);
                pagetable[i] = 0;
            }
        }
        PMM::free_page(pagetable);
    }

    void uvmfree(uint64 *pagetable, uint64 sz)
    {
        if (sz > 0)
            uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
        freewalk(pagetable);
    }

    int uvmcopy(uint64 *oldpt, uint64 *newpt, uint64 sz)
    {
        uint64 *pte;
        uint64 pa, i;
        uint flags;

        for (i = 0; i < sz; i += PGSIZE)
        {
            if ((pte = walk(oldpt, i, 0)) == nullptr)
                continue;
            if ((*pte & PTE_V) == 0)
                continue;

            pa = PTE2PA(*pte);
            flags = PTE_FLAGS(*pte);

            if (flags & PTE_W)
            {
                flags &= ~PTE_W;
                flags |= PTE_COW;
                *pte = PA2PTE(pa) | flags;
            }

            if (mappages(newpt, i, PGSIZE, pa, flags) != 0)
            {
                return -1;
            }

            page_ref_inc(pa);
        }

        sfence_vma();
        return 0;
    }

    int copyout(uint64 *pagetable, uint64 dstva, char *src, uint64 len)
    {
        uint64 n, va0, pa0;
        uint64 *pte;

        while (len > 0)
        {
            va0 = PGROUNDDOWN(dstva);
            pte = walk(pagetable, va0, 0);
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
                return -1;

            pa0 = PTE2PA(*pte);
            n = PGSIZE - (dstva - va0);
            if (n > len)
                n = len;

            memmove((void *)(pa0 + (dstva - va0)), src, n);

            len -= n;
            src += n;
            dstva = va0 + PGSIZE;
        }
        return 0;
    }

    int copyin(uint64 *pagetable, char *dst, uint64 srcva, uint64 len)
    {
        uint64 n, va0, pa0;
        uint64 *pte;

        while (len > 0)
        {
            va0 = PGROUNDDOWN(srcva);
            pte = walk(pagetable, va0, 0);
            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
                return -1;

            pa0 = PTE2PA(*pte);
            n = PGSIZE - (srcva - va0);
            if (n > len)
                n = len;

            memmove(dst, (void *)(pa0 + (srcva - va0)), n);

            len -= n;
            dst += n;
            srcva = va0 + PGSIZE;
        }
        return 0;
    }

    int copyinstr(uint64 *pagetable, char *dst, uint64 srcva, uint64 max)
    {
        uint64 n, va0, pa0;
        uint64 *pte;
        int got_null = 0;
        uint64 len = 0;

        while (len < max)
        {
            va0 = PGROUNDDOWN(srcva);
            pte = walk(pagetable, va0, 0);

            if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
                return -1;

            pa0 = PTE2PA(*pte);

            n = PGSIZE - (srcva - va0);
            if (n > max - len)
                n = max - len;

            char *p = (char *)(pa0 + (srcva - va0));
            while (n > 0)
            {
                if (*p == '\0')
                {
                    *dst = '\0';
                    got_null = 1;
                    break;
                }
                *dst = *p;
                n--;
                srcva++;
                dst++;
                p++;
                len++;
            }
            if (got_null)
                break;
        }

        if (got_null)
            return 0;

        return -1;
    }

    int handle_cow_fault(uint64 *pagetable, uint64 va)
    {
        if (va >= MAXVA)
            return -1;

        uint64 *pte = walk(pagetable, va, 0);
        if (pte == nullptr || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
            return -1;

        if ((*pte & PTE_COW) == 0)
            return -1;

        uint64 pa = PTE2PA(*pte);
        uint64 flags = PTE_FLAGS(*pte);

        char *mem = (char *)PMM::alloc_page();
        if (mem == nullptr)
            return -1;

        memmove(mem, (char *)pa, PGSIZE);

        uint64 new_flags = (flags | PTE_W) & ~PTE_COW;
        *pte = PA2PTE((uint64)mem) | new_flags | PTE_V;

        if (page_ref_dec(pa))
        {
            PMM::free_page((void *)pa);
        }

        sfence_vma();
        return 0;
    }

    static void kvmmap(uint64 va, uint64 pa, uint64 sz, int perm)
    {
        if (mappages(kernel_pagetable, va, sz, pa, perm) != 0)
        {
            Drivers::uart_puts("kvmmap: failed\n");
            while (1)
                ;
        }
    }

    void kvminit()
    {
        kernel_pagetable = uvmcreate();

        kvmmap(0x10000000, 0x10000000, 0x10000, PTE_R | PTE_W);
        kvmmap(0x0c000000, 0x0c000000, 0x400000, PTE_R | PTE_W);
        kvmmap(0x02000000, 0x02000000, 0x10000, PTE_R | PTE_W); // CLINT
        kvmmap(KERNBASE, KERNBASE, PHYSTOP - KERNBASE, PTE_R | PTE_W | PTE_X);
    }

    void kvminithart()
    {
        w_satp(MAKE_SATP(kernel_pagetable));
        sfence_vma();
        Drivers::uart_puts("[Boot] MMU ENABLED! Using virtual addresses.\n");
    }
}