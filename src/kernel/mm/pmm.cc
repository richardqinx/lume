#include "common/types.h"
#include "kernel/riscv.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"
// #include "kernel/spinlock.h"
#include "drivers/uart.h"
#include "lib/string.h"

extern "C" char kernel_end[];
extern uint64 g_dtb_addr;

namespace PMM
{
    // Global metadata array pointer
    struct Page *mem_map = nullptr;
    // Total number of physical memory pages
    uint64 total_pages = 0;
    // Free list array (free_area[k] stores the head of the free block list of order=k)
    struct Page *free_area[MAX_ORDER];
    // Protective lock
    Spinlock pmm_lock;

    struct Page *pa_to_page(uint64 pa)
    {
        if (pa < KERNBASE || pa >= PHYSTOP)
            return nullptr;
        uint64 pfn = (pa - KERNBASE) >> PGSHIFT;
        if (pfn >= total_pages)
            return nullptr;
        return &mem_map[pfn];
    }

    uint64 page_to_pa(struct Page *page)
    {
        uint64 pfn = page - mem_map;
        return KERNBASE + (pfn << PGSHIFT);
    }

    void list_add(struct Page *page, int order)
    {
        page->order = order;
        page->flags = 0; // Mark as available
        page->next = free_area[order];
        page->prev = nullptr;

        if (free_area[order])
        {
            free_area[order]->prev = page;
        }
        free_area[order] = page;
    }

    void list_del(struct Page* page, int order)
    {
        if (page->prev)
        {
            page->prev->next = page->next;
        }
        else
        {
            free_area[order] = page->next;
        }
        if (page->next)
        {
            page->next->prev = page->prev;
        }
        page->next = nullptr;
        page->prev = nullptr;
    }

    void init()
    {
        pmm_lock.init("pmm");

        uint64 kern_end_pa = PGROUNDUP((uint64)kernel_end);
        total_pages = (PHYSTOP - KERNBASE) / PGSIZE;

        Drivers::uart_puts(ANSI_GREEN "[PMM] Total RAM size: 128MB\n" ANSI_RESET);
        // Place the mem_map array
        // mem_map is located immediately after kernel_end
        mem_map = (struct Page*)kern_end_pa;

        uint64 mem_map_size = total_pages * sizeof(struct Page);
        uint64 free_mem_start = PGROUNDUP(kern_end_pa + mem_map_size);

        Drivers::uart_puts(ANSI_GREEN "[PMM] MemMap placed at: " );
        Drivers::print_hex((uint64)mem_map);
        Drivers::uart_puts("\n" ANSI_RESET);

        Drivers::uart_puts(ANSI_GREEN "[PMM] Free memory starts at: ");
        Drivers::print_hex(free_mem_start);
        Drivers::uart_puts("\n" ANSI_RESET);

        if (free_mem_start >= PHYSTOP)
        {
            Drivers::uart_puts(ANSI_RED "[PMM] Error - Kernel too large, no memory left!\n" ANSI_RESET);
            while (1)
                ;
        }

        // Initialize all page states
        for (uint64 i = 0; i < total_pages; i++)
        {
            mem_map[i].flags = PG_reserved;
            mem_map[i].order = 0;
            mem_map[i].refcnt = 0;
            mem_map[i].next = nullptr;
            mem_map[i].prev = nullptr;
        }

        for (int i = 0; i < MAX_ORDER; i++)
        {
            free_area[i] = nullptr;
        }

        // Release actual free memory to the allocator
        // Range: [free_mem_start, PHYSTOP)
        // Note: need to avoid the page where the DTB is located
        uint64 dtb_pa_start = PGROUNDDOWN(g_dtb_addr);
        uint64 dtb_pa_end = PGROUNDUP(g_dtb_addr + 0x10000);

        uint64 p = free_mem_start;
        while (p < PHYSTOP)
        {
            if (p >= dtb_pa_start && p < dtb_pa_end)
            {
                p += PGSIZE;
                continue;
            }

            // Mark the page as Used, then call free_pages to release it
            // This allows free_pages to handle the merging logic automatically
            struct Page *page = pa_to_page(p);
            if (page)
            {
                page->flags = PG_used;
                free_pages((void *)p, 0); // Release page by page, let Buddy merge automatically
            }
            p += PGSIZE;

            
        }
        
    }

    void *alloc_pages(int order)
    {
        if (order < 0 || order >= MAX_ORDER)
            return nullptr;
        
        pmm_lock.acquire();

        int current_order = order;
        while (current_order < MAX_ORDER)
        {
            if (free_area[current_order])
            {
                // Find free block
                struct Page *page = free_area[current_order];
                list_del(page, current_order);

                // If the block is too large, split it.
                while (current_order > order)
                {
                    current_order--;
                    // page is the left part (Buddy A)
                    // buddy is the right part (Buddy B)
                    // Pointer addition: Page* + n is equivalent to address offset n * sizeof(Page)
                    // Since mem_map is linearly mapped, mem_map[i + (1<<k)] exactly corresponds to physical address + (1<<k)*PGSIZE
                    struct Page *buddy = page + (1 << current_order);

                    // Add the buddy to a lower-level linked list
                    list_add(buddy, current_order);
                }

                // Mark as Occupied
                page->flags = PG_used;
                page->order = order; // Record the orders that have been assigned
                page->refcnt = 1;

                pmm_lock.release();
                return (void *)page_to_pa(page);
            }
            current_order++;
        }
        pmm_lock.release();
        Drivers::uart_puts("PMM: OOM alloc_pages\n");
        return nullptr;
    }

    void free_pages(void *pa, int order)
    {
        if (!pa)
            return;
        struct Page *page = pa_to_page((uint64)pa);
        if (!page)
            return;
        pmm_lock.acquire();

        if (!(page->flags & PG_used))
        {
            Drivers::uart_puts("PMM: Double free warning\n");
            pmm_lock.release();
            return;
        }

        // Mark as basic status
        page->flags = 0;
        page->refcnt = 0;

        // try merge
        uint64 page_idx = page - mem_map;

        while (order < MAX_ORDER - 1)
        {
            // calculate Buddy index: index ^ (1 << order)
            uint64 buddy_idx = page_idx ^ (1 << order);
            struct Page *buddy = &mem_map[buddy_idx];

            // Check if the Buddy can be merged:
            // 1. Must be within the memory range
            // 2. Must be free (flags == 0)
            // 3. Must be at the current order (to prevent merging already split small blocks)
            if (buddy_idx >= total_pages || (buddy->flags & PG_used) || (buddy->flags & PG_reserved) || buddy->order != order)
            {
                break;
            }

            // Can be merged!
            // Remove Buddy from the free list
            list_del(buddy, order);

            // Update the current block to the merged block
            // The starting address of the merged block is the smaller one between index and buddy_index
            if (buddy_idx < page_idx)
            {
                page = buddy;
                page_idx = buddy_idx;
            }

            order++;
        }

        // Insert into the final order linked list
        list_add(page, order);

        pmm_lock.release();
    }

    void *alloc_page()
    {
        void *p = alloc_pages(0);
        if (p)
        {
            memset(p, 0, PGSIZE);
        }
        return p;
    }

    void free_page(void *pa)
    {
        free_pages(pa, 0);
    }

    void print_free_lists()
    {
        // Debug print the number of free blocks at each level
        Drivers::uart_puts("PMM Stats: [ ");
        for (int i = 0; i < MAX_ORDER; i++)
        {
            int count = 0;
            struct Page *p = free_area[i];
            while (p)
            {
                count++;
                p = p->next;
            }
            if (count > 0)
            {
                Drivers::uart_puts("Order");
                // Drivers::uart_put_int(i);
                Drivers::uart_puts(":");
                // Drivers::uart_put_int(count);
                Drivers::uart_puts(" ");
            }
        }
        Drivers::uart_puts("]\n");
    }
} // namespace PMM
