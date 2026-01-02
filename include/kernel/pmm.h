#pragma once
#include "common/types.h"
#include "kernel/spinlock.h"

// Physical Memory Layout Definition
#define KERNBASE 0x80000000
// Set the memory size to 128MB
#define PHYSIZE (128 * 1024 * 1024)
#define PHYSTOP (KERNBASE + PHYSIZE)

// Buddy System Max Order
// Order 10 => 2^10 pages = 1024 * 4KB = 4MB contiguous block
// Order 11 => 2^11 pages = 8MB
#define MAX_ORDER 11

// Page flag
#define PG_used 0x01     // This page is occupied
#define PG_reserved 0x02 // This page is reserved (kernel code/data, DTB, MemMap)

// Physical Page Metadata Structure
struct Page
{
    uint8 flags;       // Page Status (PG_used, PG_reserved)
    uint8 order;       // If it is the first page of a free block, record the order of the current block
    uint16 refcnt;     // Reference Counting
    struct Page *next; // Free list pointer (points to the next free block of the same size)
    struct Page *prev; // Doubly linked list (easy to remove)
};

namespace PMM
{
    // Initialize physical memory management
    void init();

    // Core Allocation Interface (Buddy System)
    // order: 0 ~ MAX_ORDER-1
    void *alloc_pages(int order);
    void free_pages(void *pa, int order);

    // Compatible with old interface (allocate single page with order=0 and automatically reset to zero)
    void *alloc_page();
    void free_page(void *pa);

    // Helper function
    struct Page *pa_to_page(uint64 pa);
    uint64 page_to_pa(struct Page *page);

    // Debug information
    void print_free_lists();
}