#include "kernel/slab.h"
#include "kernel/pmm.h"
#include "kernel/spinlock.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "lib/string.h"

#define PG_slab 0x04

// Supported object size (must be a multiple of 8 and <= 2048)
const uint64 kmalloc_sizes[] = {
    16, 32, 64, 128, 256, 512, 1024, 2048};
const int NUM_CACHES = 8;

struct SlabHeader
{
    struct SlabHeader *next; // Next slab in the linked list
    uint16 free_idx;         // Index of the head of the free list (0xFFFF means none)
    uint16 used_count;       // Number of allocated objects
    // Followed immediately by object data...
    // The free list of objects is embedded in the first 2 bytes of the object itself (stores the index of the next object)
    uint32 padding;
};

struct KmemCache
{
    Spinlock lock;
    uint64 obj_size;
    uint64 obj_count_per_slab;
    struct SlabHeader *slab_list; // Slab list with free objects
    const char *name;
};

struct KmemCache caches[NUM_CACHES];

// Virtual address -> struct Page*
static struct Page *virt_to_page(void *ptr)
{
    uint64 pa = (uint64)ptr;
    return PMM::pa_to_page(pa);
}

// Slab Implementation

namespace Slab
{

    void init()
    {
        for (int i = 0; i < NUM_CACHES; i++)
        {
            caches[i].lock.init("slab_lock");
            caches[i].obj_size = kmalloc_sizes[i];
            caches[i].name = "kmalloc";

            // Calculate how many objects can fit on a page
            // Excluding the overhead of the SlabHeader
            uint64 available = PGSIZE - sizeof(struct SlabHeader);
            caches[i].obj_count_per_slab = available / caches[i].obj_size;
            caches[i].slab_list = nullptr;
        }
        Drivers::uart_puts("[Slab] Initialized kmalloc caches.\n");
    }

    // Allocate a new slab page for the cache
    // Must hold cache->lock
    static struct SlabHeader *grow_cache(struct KmemCache *c)
    {
        void *p = PMM::alloc_page();
        if (!p)
            return nullptr;

        // Mark this page as a Slab page
        struct Page *page = virt_to_page(p);
        if (page)
        {
            page->flags |= PG_slab;
            int cache_idx = c - caches;
            page->order = (uint8)cache_idx;
        }

        struct SlabHeader *slab = (struct SlabHeader *)p;
        slab->next = nullptr;
        slab->used_count = 0;
        slab->free_idx = 0;
        slab->padding = 0;

        // Initialize the free list of objects
        // The starting position of each object stores the index of the next object
        // Starting position of the object data area
        char *base = (char *)(slab + 1);

        for (uint i = 0; i < c->obj_count_per_slab - 1; i++)
        {
            // The content of the i-th object is i+1
            uint16 *ptr = (uint16 *)(base + i * c->obj_size);
            *ptr = i + 1;
        }
        // The last object points to 0xFFFF
        uint16 *ptr = (uint16 *)(base + (c->obj_count_per_slab - 1) * c->obj_size);
        *ptr = 0xFFFF;

        return slab;
    }

    void *kmalloc(uint64 size)
    {
        if (size == 0)
            return nullptr;

        // Large objects go directly through PMM
        if (size > 2048)
        {
            // calculate order
            int order = 0;
            uint64 req = size;
            uint64 pages = (size + PGSIZE - 1) / PGSIZE;
            (void)req;

            // calculate order: 2^order >= pages
            while ((1UL << order) < pages)
            {
                order++;
            }
            if (order > MAX_ORDER)
                return nullptr;

            void *p = PMM::alloc_pages(order);
            // Here, page->flags defaults to PG_used, not PG_slab
            // kfree needs to be able to recognize it
            return p;
        }

        int idx = 0;
        while (idx < NUM_CACHES && kmalloc_sizes[idx] < size)
        {
            idx++;
        }

        struct KmemCache *c = &caches[idx];
        c->lock.acquire();

        if (!c->slab_list)
        {
            c->slab_list = grow_cache(c);
            if (!c->slab_list)
            {
                c->lock.release();
                return nullptr;
            }
        }

        struct SlabHeader *slab = c->slab_list;

        int obj_idx = slab->free_idx;
        char *base = (char *)(slab + 1);
        void *ptr = base + obj_idx * c->obj_size;

        uint16 *link = (uint16 *)ptr;
        slab->free_idx = *link;
        slab->used_count++;

        if (slab->free_idx == 0xFFFF)
        {
            if (slab->next)
            {
                c->slab_list = slab->next;
                slab->next = nullptr;
            }
            else
            {
                c->slab_list = nullptr;
            }
        }

        c->lock.release();

        memset(ptr, 0, size);
        return ptr;
    }

    void kfree(void *ptr)
    {
        if (!ptr)
            return;

        struct Page *page = virt_to_page(ptr);
        if (!page)
            return;

        if (!page || !(page->flags & PG_slab))
        {
            PMM::free_pages(ptr, page->order);
            return;
        }

        int cache_idx = page->order;
        if (cache_idx >= NUM_CACHES)
        {
            Drivers::uart_puts("Slab: Corrupted page metadata\n");
            return;
        }

        struct KmemCache *c = &caches[cache_idx];
        c->lock.acquire();

        struct SlabHeader *slab = (struct SlabHeader *)PGROUNDDOWN((uint64)ptr);

        if ((uint64)ptr < (uint64)(slab + 1) || (uint64)ptr >= (uint64)slab + PGSIZE)
        {
            Drivers::uart_puts("Slab: kfree invalid pointer\n");
            c->lock.release();
            return;
        }

        char *base = (char *)(slab + 1);
        int obj_idx = ((uint64)ptr - (uint64)base) / c->obj_size;

        uint16 *link = (uint16 *)ptr;
        *link = slab->free_idx;
        slab->free_idx = (uint16)obj_idx;

        slab->used_count--;

        if (slab->used_count == 0)
        {
            struct SlabHeader **pp = &c->slab_list;
            // bool found = false;
            while (*pp)
            {
                if (*pp == slab)
                {
                    *pp = slab->next;
                    // found = true;
                    break;
                }
                pp = &(*pp)->next;
            }

            page->flags &= ~PG_slab;
            PMM::free_page(slab);
        }
        else
        {

            if (slab->used_count == c->obj_count_per_slab - 1)
            {
                slab->next = c->slab_list;
                c->slab_list = slab;
            }
        }

        c->lock.release();
    }
}