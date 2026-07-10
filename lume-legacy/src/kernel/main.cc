// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */
#include "common/types.h"
#include "kernel/riscv.h"
#include "drivers/uart.h"
#include "drivers/plic.h"
#include "drivers/virtio.h"
#include "kernel/pmm.h"
#include "kernel/mm.h"
#include "kernel/slab.h"
#include "kernel/proc.h"
#include "kernel/trap.h"
#include "kernel/timer.h"
#include "kernel/cpu.h"
#include "kernel/buf.h"
#include "fs/fs.h"
#include "fs/file.h"
#include "fs/fat32.h"
#include "lib/string.h"

#include "kernel/fdt.h" // fdt_parse

extern uint64 g_dtb_addr;

// Placement new support (referenced from cxx.cc)
void *operator new(unsigned long size, void *ptr);

volatile static int started = 0;

extern "C" void kernel_main(uint64 hartid, uint64 dtb)
{
    if (hartid == 0)
    {
        fdt_parse(dtb);

        Drivers::uart_init();
        Drivers::uart_puts("\n[Lume OS] Booting...\n");

        Drivers::uart_puts("[Boot] PMP configured.\n");

        PMM::init();              // Physical Memory Management
        VM::kvminit();            // Kernel Pagetable
        VM::kvminithart();        // Enable MMU
        Slab::init();
        Trap::init();             // Trap Management
        Trap::inithart();
        PLIC::init();
        PLIC::inithart();
        VirtIO::init();
        BufferCache::init();
        VFS::init();
        // Initialize global FAT32 object manually (global constructors not supported yet)
        new (&fat32_fs) FAT32FileSystem();
        VFS::register_fs(&fat32_fs);
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