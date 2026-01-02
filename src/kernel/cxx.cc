#include "common/types.h"
#include "kernel/pmm.h"
#include "drivers/uart.h"

/*
 * C++ Kernel Runtime Support
 *
 * * Strategy: Map directly to PMM::alloc_page().
 * Pros: Simple, works immediately for VFS.
 * Cons: Allocates 4KB for every object (wasteful for small objects),
 * but acceptable for current stage.
 */

void *operator new(unsigned long size)
{
    // Safety check: PMM allocates 4096 bytes max per call
    if (size > 4096)
    {
        Drivers::uart_puts("panic: new allocation too big (max 4096)\n");
        while (1)
            ;
    }

    void *p = PMM::alloc_page();
    if (!p)
    {
        Drivers::uart_puts("panic: new out of memory\n");
        while (1)
            ;
    }
    // PMM::alloc_page returns zeroed memory usually,
    // but standard 'new' doesn't guarantee it.
    // The constructor will handle initialization.
    return p;
}

void *operator new[](unsigned long size)
{
    return operator new(size);
}

void operator delete(void *p)
{
    if (p)
        PMM::free_page(p);
}

void operator delete[](void *p)
{
    if (p)
        PMM::free_page(p);
}

// C++14 Sized Deallocation (Required by modern compilers)
// The compiler optimizes 'delete' calls to pass the size of the object
void operator delete(void *p, unsigned long size)
{
    (void)size; // We ignore size because PMM always frees a full page
    if (p)
        PMM::free_page(p);
}

void operator delete[](void *p, unsigned long size)
{
    (void)size;
    if (p)
        PMM::free_page(p);
}