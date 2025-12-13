#include "kernel/mm.h"
#include "kernel/pmm.h"
#include "drivers/uart.h"
#include "common/types.h"
#include "kernel/config.h"

extern "C" char text_start[];
extern "C" char text_end[];
extern "C" char rodata_start[];
extern "C" char rodata_end[];
extern "C" char data_start[];
extern "C" char kernel_end[];

namespace VM
{
    pagetable_t kernel_pagetable;

    #define PX(level, va) ((((uint64)va) >> (12 + 9 * (level))) & 0x1FF)
    #define PA2PTE(pa) ((((uint64)pa) >> 12) << 10)
    #define PTE2PA(pte) (((pte) >> 10) << 12)

    pte_t *walk(pagetable_t pagetable, uint64 va, int alloc)
    {
        for (int level = 2; level > 0; level--)
        {
            pte_t *pte = &pagetable[PX(level, va)];

            if (*pte & PTE_V)
            {
                pagetable = (pagetable_t)PTE2PA(*pte);
            }
            else
            {
                if (!alloc)
                    return 0;

                pagetable = (pagetable_t)PMM::alloc_page();
                if (!pagetable)
                    return 0;

                *pte = PA2PTE(pagetable) | PTE_V;
            }
        }
        return &pagetable[PX(0, va)];
    }

    int mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
    {
        uint64 a, last;
        pte_t *pte;

        a = (va / PGSIZE) * PGSIZE;
        last = ((va + size - 1) / PGSIZE) * PGSIZE;

        for(;;)
        {
            if((pte = walk(pagetable, a, 1)) == 0)
                return -1;

            if (*pte & PTE_V)
            {
                Drivers::uart_puts("Remap error\n");
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

    void kvminit()
    {
        kernel_pagetable = (pagetable_t)PMM::alloc_page();

        if (g_uart_base != 0)
        {
            mappages(kernel_pagetable, g_uart_base, PGSIZE, g_uart_base, PTE_R | PTE_W);
        }

        // if (g_clint_base != 0)
        // {
        //     mappages(kernel_pagetable, g_clint_base, 0x10000, g_clint_base, PTE_R | PTE_W);
        // }

        if (g_plic_base != 0)
        {
            mappages(kernel_pagetable, g_plic_base, 0x400000, g_plic_base, PTE_R | PTE_W);
        }

        mappages(kernel_pagetable, (uint64)text_start, (uint64)text_end - (uint64)text_start,
                 (uint64)text_start, PTE_R | PTE_X);

        mappages(kernel_pagetable, (uint64)data_start, PHYSTOP - (uint64)data_start,
                 (uint64)data_start, PTE_R | PTE_W);

        mappages(kernel_pagetable, (uint64)rodata_start, (uint64)rodata_end - (uint64)rodata_start,
                 (uint64)rodata_start, PTE_R);
        
    }
    void kvminithart()
    {
        asm volatile("sfence.vma zero, zero");

        uint64 satp_val = MAKE_SATP(kernel_pagetable);
        asm volatile("csrw satp, %0" : : "r"(satp_val));

        asm volatile("sfence.vma zero, zero");
    }
}