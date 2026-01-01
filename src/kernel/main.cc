#include "common/types.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "drivers/plic.h"
#include "drivers/virtio.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"
#include "kernel/proc.h"
#include "kernel/trap.h"
#include "kernel/timer.h"
#include "kernel/cpu.h"
#include "kernel/buf.h"
#include "fs/fs.h"
#include "fs/file.h"
#include "fs/fat32.h"
#include "lib/string.h"

extern void fdt_init(uint64 dtb);
extern uint64 g_dtb_addr;

volatile static int started = 0;

extern "C" void kernel_main(uint64 hartid, uint64 dtb)
{
    if (hartid == 0)
    {
        fdt_init(dtb);

        Drivers::uart_init();
        Drivers::uart_puts("\n[Lume OS] Booting...\n");

        Drivers::uart_puts("[Boot] PMP configured.\n");

        PMM::init();              // Physical Memory Management
        VM::kvminit();            // Kernel Pagetable
        VM::kvminithart();        // Enable MMU
        Trap::init();             // Trap Management
        Trap::inithart();
        PLIC::init();
        PLIC::inithart();
        VirtIO::init();
        BufferCache::init();
        VFS::init();
        FileTable::init();
        Timer::init();
        ProcManager::init();      // Process Management
        ProcManager::user_init(); // Initialize first user process

        __atomic_store_n(&started, 1, __ATOMIC_RELEASE);

        Drivers::uart_puts("[Boot] System initialized. Entering scheduler...\n");
    }
    else
    {
        while (__atomic_load_n(&started, __ATOMIC_ACQUIRE) == 0)
            ;

        VM::kvminithart();
        Trap::inithart();
        PLIC::inithart();
        Timer::init();
        Drivers::uart_puts("[Boot] Hart started.\n");
    }

    ProcManager::scheduler(); // Enable Scheduler
}