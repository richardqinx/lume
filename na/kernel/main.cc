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

#include <arch/cpu.h>
#include <lume/atomic.h>
#include <lume/boot_params.h>
#include <lume/console.h>
#include <lume/driver.h>
#include <lume/fdt.h>
#include <lume/irq.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/memblock.h>
#include <lume/pmm.h>
#include <lume/random.h>
#include <lume/sched.h>
#include <lume/trap.h>
#include <lume/types.h>
#include <arch/config.h>
#include <arch/extable.h>

// ============================================================
// Forward declarations for subsystem init functions.
// Each is implemented by its owning module. On failure they
// call kernel_panic() directly — no error return.
// ============================================================

// BSP global init (strict order)
void console_init();             // 1. UART ready; kprintf/panic can output
void fdt_init(uint64 fdt_paddr); // 2. Parse FDT, build device node table
void pmm_init();                 // 3. Buddy allocator ready
void slab_init();                // 4. kmem_cache ready; operator new usable
void vmm_init();   // 5. Fine-grained kernel page table; retire early_pgdir
void task_init();   // 7. PID allocator + global task list
void timer_init(); // 8. Configure timer interrupt (scheduler tick)
void sched_init(); // 9. Create BSP Idle Task, init ready queues
void syscall_init(); // 10. Register syscall jump table

// Boot self-test runner
void selftest_run_all();

// AP per-CPU init
void vmm_init_ap();   // Switch to BSP-built kernel page table
void timer_init_ap(); // Start this CPU's timer interrupt
void sched_init_ap(); // Init per-CPU ready queue, create Idle Task

// ============================================================
// Second-stage synchronization barrier (C++ layer)
// AP cores spin here until BSP finishes all global init.
// ============================================================
static lume::atomic<uint32> ap_boot_sync;

// ============================================================
// kernel_main — C++ entry point for all CPUs
// ============================================================
extern "C" [[noreturn]] void kernel_main(uint64 cpu_id, uint64 fdt_paddr) {

  if (cpu_id == 0) {
    // ========================================================
    // BSP: Absolute single-core period — no locks needed.
    // APs are spinning on ap_boot_sync.
    // ========================================================

    boot_params_init_fdt(fdt_paddr);
    const BootParams* bp = boot_params_get();
    uint64 fdt_pa = bp ? bp->fdt_ptr : fdt_paddr;

    // Early console setup: discover UART via FDT before ANY output.
    console_early_init(fdt_pa);
    klog_init();

    printk("\n");
    printk(KERN_INFO "LumeOS Kernel v0.1\n");
    printk(KERN_INFO "boot: BSP online, cpu_id=0\n");
    printk(KERN_INFO "boot: higher-half kernel active\n");

    BOOT_STAGE(0, "firmware handoff");
    BOOT_STAGE(1, "bootloader handoff");
    BOOT_STAGE(2, "arch early asm complete");
    if (bp) {
      if (bp->kimage_flags & BOOT_IMAGE_DECOMP_FAILED) {
        BOOT_STAGE(3, "decompress failed");
      } else if (bp->kimage_flags & BOOT_IMAGE_COMPRESSED) {
        BOOT_STAGE(3, "decompress ok");
      } else {
        BOOT_STAGE(3, "decompress skipped");
      }

      if (bp->kimage_flags & BOOT_IMAGE_RELOC_FAILED) {
        BOOT_STAGE(3, "relocate failed");
      } else if (bp->kimage_flags & BOOT_IMAGE_RELOCATED) {
        BOOT_STAGE(3, "relocate ok");
      } else {
        BOOT_STAGE(3, "relocate skipped");
      }

      printk(KERN_INFO "boot: kimage phys=0x%llx size=%llu reloc=%llu\n",
             bp->kimage_phys_base,
             static_cast<unsigned long long>(bp->kimage_size),
             static_cast<unsigned long long>(bp->kimage_reloc_size));
    } else {
      BOOT_STAGE(3, "decompress/relocate unknown");
    }
    BOOT_STAGE(4, "early c init");

    // --- Subsystem init DAG (strict top-down order) ---

    // 1. FDT parsing — make device tree available
    fdt_init(fdt_pa);
    printk(KERN_INFO "init: fdt_init done\n");

    // 2. KASLR — seed PRNG and randomise VA layout.
    //    MUST happen before vmm_init() builds the kernel page table.
    {
      uint64 kaslr_seed = 0;
      fdt_early_get_kaslr_seed(&kaslr_seed);
      random_early_init(kaslr_seed);
      arch::kaslr_init();
    }

    // Sort exception table before setting RO permissions in vmm_init()
    extable_init();

    // 3. Memblock allocator (Early boot PA allocator)
    memblock_init(fdt_pa);
    printk(KERN_INFO "init: memblock_init done\n");

    // 4. Virtual memory manager — builds page table with KASLR'd bases
    vmm_init();
    printk(KERN_INFO "init: vmm_init done\n");

    // 5. Physical memory manager (Buddy)
    pmm_init();
    printk(KERN_INFO "init: pmm_init done\n");

    // 6. Slab allocator — operator new usable after this
    slab_init();
    printk(KERN_INFO "init: slab_init done\n");

    // 7. FDT Phase 2 — build DeviceNode object tree (needs Slab)
    fdt_unflatten();
    printk(KERN_INFO "init: fdt_unflatten done\n");

    // 6. Trap handler — set trap vector
    trap_init();
    printk(KERN_INFO "init: trap_init done\n");

    // 6.5 Task management (PID allocator + global task list)
    task_init();

    // 7. Hardware Drivers Discovery (Interrupt Controllers, etc)
    driver_probe_all();
    printk(KERN_INFO "init: driver_probe_all done\n");

    // 8. Timer interrupt (scheduler tick source)
    timer_init();
    printk(KERN_INFO "init: timer_init done\n");

    // 9. Scheduler — create Idle Task 0, init ready queues
    sched_init();
    printk(KERN_INFO "init: sched_init done\n");

    // 10. Syscall jump table
    syscall_init();

    // 10. Boot self-tests — verify subsystem correctness
    selftest_run_all();
    // kernel_panic("Manual Panic Test", "triggered by developer"); // VERIFIED
    // OK

    BOOT_STAGE(5, "core kernel init");
    printk(KERN_INFO "boot: BSP init complete, releasing APs\n");

    // Release APs with RELEASE semantics:
    // guarantees all global data is visible to APs.
    ap_boot_sync.store(1, __ATOMIC_RELEASE);

    // BSP enables interrupts — first timer tick will preempt
    // into the scheduler loop.
    // arch::cpu::intr_on();

    printk(KERN_INFO "boot: BSP entering idle loop\n");

  } else {
    // ========================================================
    // AP: spin until BSP finishes global init
    // ========================================================
    while (ap_boot_sync.load(__ATOMIC_ACQUIRE) == 0)
      ;

    printk(KERN_INFO "boot: AP online, cpu_id=%llu\n", cpu_id);

    // --- Per-CPU init only (no global data mutation) ---
    // vmm_init_ap();
    // arch_irq_chip_init_ap();
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
