#include "kernel/pmm.h"
#include "drivers/uart.h"

extern "C" char kernel_end[];

namespace PMM
{
    struct Run
    {
        struct Run *next;
    };

    struct
    {
        struct Run *freelist;
    } kmem;

    inline uint64_t PGROUNDUP(uint64_t a)
    {
        return (a + PGSIZE - 1) & ~(PGSIZE - 1);
    }

    void init()
    {
        uint64_t start = PGROUNDUP((uint64_t)kernel_end);

        Drivers::uart_puts("PMM: Initializing from");

        for (uint64_t p = start; p + PGSIZE <= PHYSTOP; p += PGSIZE)
        {
            free_page((void *)p);
        }
    }

    void free_page(void* pa)
    {
        struct Run *r;
        if (((uint64_t)pa % PGSIZE) != 0 || (uint64_t)pa < (uint64_t)kernel_end || (uint64_t)pa >= PHYSTOP)
        {
            Drivers::uart_puts("PMM: Error - Invalid free address\n");
            return;
        }
        r = (struct Run*)pa;

        r->next = kmem.freelist;
        kmem.freelist = r;
        
    }

    void* alloc_page()
    {
        struct Run* r;

        r = kmem.freelist;
        if (r)
        {
            kmem.freelist = r->next;

            uint64_t *p = (uint64_t *)r;
            for (int i = 0; i < PGSIZE / 8; i++)
            {
                p[i] = 0;
            }
        }
        else
        {
            Drivers::uart_puts("PMM: Out of memory!\n");
        }
        return (void *)r;
    }
}