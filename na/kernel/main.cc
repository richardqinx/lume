/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * LumeOS Kernel Main Entry — Global Initialization Sequence
 *
 * All CPUs enter kernel_main() after the assembly bootstrap (entry.S)
 * has enabled MMU, cleared BSS, and called early_cpp_init().
 *
 * BSP (cpu_id == 0) executes the full subsystem initialization DAG.
 * APs spin on ap_boot_sync, then perform per-CPU init only.
 *
 * Reference: docs/specs/global_init.md
 */

#include <lume/types.h>
#include <lume/atomic.h>
#include <lume/panic.h>
#include <lume/fdt.h>
#include <lume/pmm.h>
#include <lume/console.h>
#include <arch/cpu.h>

// ============================================================
// Forward declarations for subsystem init functions.
// Each is implemented by its owning module. On failure they
// call kernel_panic() directly — no error return.
// ============================================================

// BSP global init (strict order)
void console_init();                // 1. UART ready; kprintf/panic can output
void fdt_init(uint64 fdt_paddr);    // 2. Parse FDT, build device node table
void pmm_init();                    // 3. Buddy allocator ready
void slab_init();                   // 4. kmem_cache ready; operator new usable
void vmm_init();                    // 5. Fine-grained kernel page table; retire early_pgdir
void trap_init();                   // 6. Set trap vector, register IRQ dispatcher
void plic_init();                   // 7. Configure PLIC (threshold, priority, enable)
void timer_init();                  // 8. Configure timer interrupt (scheduler tick)
void sched_init();                  // 9. Create BSP Idle Task, init ready queues

// Boot self-test runner
void selftest_run_all();

// AP per-CPU init
void vmm_init_ap();                 // Switch to BSP-built kernel page table
void trap_init_ap();                // Set this CPU's trap vector
void plic_init_ap();                // Enable this CPU's PLIC context
void timer_init_ap();               // Start this CPU's timer interrupt
void sched_init_ap();               // Init per-CPU ready queue, create Idle Task

// ============================================================
// Second-stage synchronization barrier (C++ layer)
// AP cores spin here until BSP finishes all global init.
// ============================================================
static lume::atomic<uint32> ap_boot_sync;

// Early UART output functions, defined in lib/panic.cc
// They are safe to use before console_init().
extern "C" void early_putc(char c);
extern "C" void early_puts(const char* s);

// ============================================================
// kernel_main — C++ entry point for all CPUs
// ============================================================
extern "C" [[noreturn]] void kernel_main(uint64 cpu_id, uint64 fdt_paddr) {

    if (cpu_id == 0) {
        // ========================================================
        // BSP: Absolute single-core period — no locks needed.
        // APs are spinning on ap_boot_sync.
        // ========================================================

        // Early console setup: discover UART via FDT before ANY output.
        console_early_init(fdt_paddr);


        early_puts("\n\n");
        early_puts("====================================\n");
        early_puts("  LumeOS Kernel v0.1\n");
        early_puts("====================================\n");
        early_puts("[boot] BSP online, cpu_id=0\n");
        early_puts("[boot] Higher-half kernel active\n");

        // --- Subsystem init DAG (strict top-down order) ---


        // 2. FDT parsing
        fdt_init(fdt_paddr);
        early_puts("[init] fdt_init done\n");

        // 3. Physical memory manager (Buddy)
        pmm_init();
        early_puts("[init] pmm_init done\n");

        // 4. Slab allocator — operator new usable after this
        slab_init();
        early_puts("[init] slab_init done\n");

        // 4.5. FDT Phase 2 — build DeviceNode object tree (needs Slab)
        fdt_unflatten();
        early_puts("[init] fdt_unflatten done\n");

        // 5. Virtual memory manager — retire early_pgdir
        vmm_init();
        
        // 5.5 Drivers MMIO mapping Registration
        // MUST BE CALLED IMMEDIATELY AFTER vmm_init! Otherwise UART is lost.
        console_init();

        early_puts("[init] vmm_init & console mapped\n");

        // 6. Trap handler — set trap vector
        // trap_init();
        early_puts("[init] trap_init (stub)\n");

        // 7. PLIC interrupt controller
        plic_init();
        early_puts("[init] plic_init done (mapped)\n");

        // 8. Timer interrupt (scheduler tick source)
        // timer_init();
        early_puts("[init] timer_init (stub)\n");

        // 9. Scheduler — create Idle Task 0, init ready queues
        // sched_init();
        early_puts("[init] sched_init (stub)\n");

        // 10. Boot self-tests — verify subsystem correctness
        selftest_run_all();

        early_puts("[boot] BSP init complete, releasing APs\n");

        // Release APs with RELEASE semantics:
        // guarantees all global data is visible to APs.
        ap_boot_sync.store(1, __ATOMIC_RELEASE);

        // BSP enables interrupts — first timer tick will preempt
        // into the scheduler loop.
        // arch::cpu::intr_on();

        early_puts("[boot] BSP entering idle loop\n");

    } else {
        // ========================================================
        // AP: spin until BSP finishes global init
        // ========================================================
        while (ap_boot_sync.load(__ATOMIC_ACQUIRE) == 0)
            ;

        // --- Per-CPU init only (no global data mutation) ---
        // vmm_init_ap();
        // trap_init_ap();
        // plic_init_ap();
        // timer_init_ap();
        // sched_init_ap();

        // AP enables interrupts — becomes Idle Task on this CPU
        // arch::cpu::intr_on();
    }

    // All CPUs: idle loop (wfi until interrupt)
    while (true) {
        arch::cpu::halt_until_interrupt();
    }
}
