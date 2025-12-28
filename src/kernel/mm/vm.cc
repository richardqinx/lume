#include "kernel/mm.h"
#include "kernel/pmm.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "common/types.h"
#include "kernel/config.h"
#include "lib/string.h"


extern char text_start[];
extern char text_end[];
extern char rodata_start[];
extern char rodata_end[];
extern char data_start[];
extern char data_end[];
extern char bss_start[];
extern char bss_end[];
extern char kernel_end[];

extern char uservec[];
extern char userret[];
extern char trampoline[];

VM::pagetable_t kernel_pagetable;

namespace VM
{
    // pagetable_t kernel_pagetable;

    pte_t *walk(pagetable_t pagetable, uint64 va, int alloc)
    {
        if (va >= MAXVA)
            return 0;
        
        for (int level = 2; level > 0; level--)
        {
            pte_t *pte = &pagetable[PX(level, va)];

            if (*pte & PTE_V)
            {
                pagetable = (pagetable_t)PTE2PA(*pte);
            }
            else
            {
                if (!alloc || (pagetable = (pagetable_t)PMM::alloc_page()) == 0)
                    return 0;
                memset(pagetable, 0, PGSIZE);
                // pagetable = (pagetable_t)PMM::alloc_page();
                *pte = PA2PTE(pagetable) | PTE_V;
            }
        }
        return &pagetable[PX(0, va)];
    }

    int mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
    {
        uint64 a, last;
        pte_t *pte;

        a = PGROUNDDOWN(va);
        last = PGROUNDDOWN(va + size - 1);

        for(;;)
        {
            if((pte = walk(pagetable, a, 1)) == 0)
                return -1;

            if (*pte & PTE_V)
            {
                Drivers::uart_puts("Remap panic: ");
                Drivers::print_hex(a);
                Drivers::uart_puts("\n");
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

    void kvmmap(uint64 va, uint64 pa, uint64 sz, int perm)
    {
        if (mappages(kernel_pagetable, va, sz, pa, perm) != 0)
        {
            Drivers::uart_puts("kvmmap: failed to map\n");
        }
    }

    void kvminit()
    {
        kernel_pagetable = (pagetable_t)PMM::alloc_page();
        memset(kernel_pagetable, 0, PGSIZE);

        kvmmap(g_uart_base, g_uart_base, PGSIZE, PTE_R | PTE_W);

        kvmmap(g_plic_base, g_plic_base, 0x400000, PTE_R | PTE_W);

        // kvmmap(g_clint_base, g_clint_base, 0x10000, PTE_R | PTE_W);

        kvmmap((uint64)text_start, (uint64)text_start,
               (uint64)text_end - (uint64)text_start, PTE_R | PTE_X);

        kvmmap((uint64)rodata_start, (uint64)rodata_start,
               (uint64)rodata_end - (uint64)rodata_start, PTE_R);

        kvmmap((uint64)data_start, (uint64)data_start,
               (uint64)kernel_end - (uint64)data_start, PTE_R | PTE_W);

        kvmmap((uint64)kernel_end, (uint64)kernel_end,
               (uint64)PHYSTOP - (uint64)kernel_end, PTE_R | PTE_W);

        kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    }
    void kvminithart()
    {
        w_satp(MAKE_SATP(kernel_pagetable));
        sfence_vma();
    }


    pagetable_t uvmcreate()
    {
        pagetable_t pagetable = (pagetable_t)PMM::alloc_page();
        if (pagetable == 0)
            return 0;
        memset(pagetable, 0, PGSIZE);

        if (mappages(pagetable, TRAMPOLINE, PGSIZE, (uint64)trampoline, PTE_R | PTE_X) < 0)
        {
            return 0;
        }

        return pagetable;
    }

    void uvminit(pagetable_t pagetable, uchar *src, uint sz)
    {
        char *mem;

        if (sz >= PGSIZE)
        {
            Drivers::uart_puts("uvminit: initcode too big\n");
            return;
        }

        mem = (char*)PMM::alloc_page();
        memset(mem, 0, PGSIZE);

        mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);

        memmove(mem, src, sz);

        uint64 trap_pa = (uint64)uservec;
        uint64 trap_page_start = PGROUNDDOWN(trap_pa);

        mappages(pagetable, trap_page_start, PGSIZE, trap_page_start, PTE_R | PTE_X);

        mappages(pagetable, trap_page_start + PGSIZE, PGSIZE, trap_page_start + PGSIZE, PTE_R | PTE_X);
    }

    void uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
    {
        uint64 a;
        pte_t *pte;

        if ((va % PGSIZE) != 0)
        {
            Drivers::uart_puts("uvmunmap: not aligned\n");
            return;
        }

        for(a = va; a < va + npages * PGSIZE; a += PGSIZE)
        {
            if ((pte = walk(pagetable, a, 0)) == 0)
                continue;

            if((*pte & PTE_V) == 0)
                continue;

            if (PTE_FLAGS(*pte) == PTE_V)
            {
                Drivers::uart_puts("uvmunmap: not a leaf\n");
            }

            if (do_free)
            {
                uint64 pa = PTE2PA(*pte);
                PMM::free_page((void *)pa);
            }
            *pte = 0;
        }
    }

    void uvmfree(pagetable_t pagetable, uint64 sz)
    {
        if(sz > 0)
            uvmunmap(pagetable, 0, PGROUNDDOWN(sz)/PGSIZE, 1);

        PMM::free_page((void *)pagetable);
    }

    int uvmcopy(pagetable_t oldpt, pagetable_t newpt, uint64 sz)
    {
        pte_t *pte;
        uint64 pa, i;
        uint flags;
        char *mem;

        for(i = 0; i < sz; i += PGSIZE)
        {
            if((pte = walk(oldpt, i, 0)) == 0)
                continue;
            if ((*pte & PTE_V) == 0)
                continue;
            
            pa = PTE2PA(*pte);
            flags = PTE_FLAGS(*pte);

            if ((mem = (char *)PMM::alloc_page()) == 0)
                goto err;

            memmove(mem, (char *)pa, PGSIZE);

            if (mappages(newpt, i, PGSIZE, (uint64)mem, flags) != 0)
            {
                PMM::free_page(mem);
                goto err;
            }
        }
        return 0;
    err:
        uvmunmap(newpt, 0, i / PGSIZE, 1);
        return -1;
    }

    uint64 uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
    {
        char *mem;
        uint64 a;

        if (newsz < oldsz)
            return oldsz;

        oldsz = PGROUNDUP(oldsz);
        for (a = oldsz; a < newsz; a += PGSIZE)
        {
            mem = (char *)PMM::alloc_page();
            if (mem == 0)
            {
                uvmdealloc(pagetable, a, oldsz);
                return 0;
            }
            memset(mem, 0, PGSIZE);
            if (mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W | PTE_X | PTE_R | PTE_U) != 0)
            {
                PMM::free_page(mem);
                uvmdealloc(pagetable, a, oldsz);
                return 0;
            }
        }
        return newsz;
    }

    uint64 uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
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

    int copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
    {
        uint64 n, va0, pa0;
        pte_t *pte;

        while (len > 0)
        {
            va0 = PGROUNDDOWN(srcva);
            pte = walk(pagetable, va0, 0);
            if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0)
            {
                return -1;
            }
            pa0 = PTE2PA(*pte);
            n = PGSIZE - (srcva - va0);
            if(n > len)
                n = len;
            
            memmove(dst, (void*)(pa0 + (srcva - va0)), n);

            len -= n;
            dst += n;
            srcva = va0 + PGSIZE;
        }
        return 0;
        
    }
}