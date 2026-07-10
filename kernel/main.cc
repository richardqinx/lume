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
 * Boot DAG invariants (docs/specs/linux_abi_mm_plan.md §Boot Sequence):
 *   - trap_init() MUST precede any allocator (exception safety net)
 *   - sched_init() MUST precede timer_init() (software before hardware)
 *   - PID 1 (init) is spawned before entering idle loop
 *
 * Reference: docs/specs/global_init.md
 */

#include <arch/config.h>
#include <arch/cpu.h>
#include <arch/extable.h>
#include <arch/sbi.h>
#include <lume/addr.h>
#include <lume/atomic.h>
#include <lume/console.h>
#include <lume/driver.h>
#include <lume/fdt.h>
#include <lume/fdtable.h>
#include <lume/fs_struct.h>
#include <lume/fs_types.h>
#include <lume/irq.h>
#include <lume/kernel_map.h>
#include <lume/klog.h>
#include <lume/kprintf.h>
#include <lume/memblock.h>
#include <lume/mount.h>
#include <lume/page_cache.h>
#include <lume/pmm.h>
#include <lume/random.h>
#include <lume/sched.h>
#include <lume/smp.h>
#include <lume/task.h>
#include <lume/pid.h>
#include <lume/pgrp.h>
#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/trap.h>
#include <lume/types.h>

// Declared by entry.S: the hart ID that won BSP election
extern "C" uint32 bsp_hart_id;

// Linker symbol: kernel entry point (physical start address)
extern "C" char _start[];

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
void vmm_init();     // 5. Fine-grained kernel page table; retire early_pgdir
void task_init();    // 6. PID allocator + global task list
void pgrp_init();    // 6.5. Process group hash table
void sched_init();   // 7. Create BSP Idle Task, init ready queues
void timer_init();   // 8. Configure timer interrupt (scheduler tick)
void syscall_init(); // 9. Register syscall jump table
void super_init();   // 10. VFS superblock registry
void ramfs_init();   // 11. RamFS filesystem registration
void vfs_init();     // 12. Mount root filesystem
void cdev_init();    // 13. Character device registry
void console_cdev_init(); // 14. Register console/null/zero cdevs
void devfs_init();        // 15. Create /dev and populate nodes
void tty_init();          // 15.5. TTY subsystem (console TTY + UART RX IRQ)
void populate_rootfs();   // 15.6. Unpack embedded initramfs CPIO into ramfs

// Boot self-test runner
#ifdef CONFIG_SELFTEST
void selftest_run_all();
#endif

// AP per-CPU init
void vmm_init_ap();   // Switch to BSP-built kernel page table
void timer_init_ap(); // Start this CPU's timer interrupt
void sched_init_ap(); // Init per-CPU ready queue, create Idle Task

// kthread_create from task.cc
extern TaskControlBlock *kthread_create(const char *name, void (*entry)(void *),
                                        void *arg, uint8 priority);

// ============================================================
// PID 1 — init thread
// ============================================================
static void init_thread_func(void *) {
  printk(KERN_INFO "[init] PID 1 started\n");

  /* Run post-SMP tests — APs are online by now */
#ifdef CONFIG_SELFTEST
  extern void selftest_smp();
  kprintf("\n========================================\n");
  kprintf("  Post-SMP Test Suite\n");
  kprintf("========================================\n");
  selftest_smp();
  kprintf("========================================\n");
  kprintf("  Post-SMP tests PASSED\n");
  kprintf("========================================\n\n");
#endif

  /*
   * Set up init's own VFS context (like Linux kernel_init).
   * kthread_create does NOT inherit files/fs, so init creates its own.
   */
  TaskControlBlock *self = current_task();

  if (!self->files) {
    self->files = alloc_files_struct();
    if (!self->files) {
      printk(KERN_ERR "[init] failed to allocate files_struct\n");
      goto out;
    }
  }
  if (!self->fs) {
    self->fs = alloc_fs_struct();
    if (!self->fs) {
      printk(KERN_ERR "[init] failed to allocate fs_struct\n");
      goto out;
    }
    /* Point to the global root filesystem */
    self->fs->root.de = g_root_dentry;
    self->fs->root.mnt = g_root_mnt;
    self->fs->pwd = self->fs->root;
  }

  /* Open /dev/console → fd 0 (stdin), dup to fd 1, 2 */
  {
    extern int64 sys_openat(uint64, uint64, uint64, uint64, uint64, uint64);
    extern int64 sys_dup(uint64, uint64, uint64, uint64, uint64, uint64);

    int64 fd0 =
        sys_openat(static_cast<uint64>(-100), /* AT_FDCWD */
                   reinterpret_cast<uint64>("/dev/console"), O_RDWR, 0, 0, 0);
    if (fd0 < 0) {
      printk(KERN_ERR "[init] open /dev/console failed: %d\n",
             static_cast<int>(fd0));
    } else {
      sys_dup(static_cast<uint64>(fd0), 0, 0, 0, 0, 0); /* fd 1 */
      sys_dup(static_cast<uint64>(fd0), 0, 0, 0, 0, 0); /* fd 2 */
      printk(KERN_INFO "[init] fd 0/1/2 -> /dev/console\n");
    }
  }

  /*
   * Try to exec /sbin/init (like Linux kernel_init).
   * If not found, fall through to idle.
   */
  {
    extern int kernel_execve(const char *, const char *const *,
                             const char *const *);

    const char *init_paths[] = {"/sbin/init", "/etc/init", "/bin/init",
                                "/bin/sh", nullptr};
    const char *argv[] = {"/sbin/init", nullptr};
    const char *envp[] = {"HOME=/", "PATH=/sbin:/bin", nullptr};

    for (int i = 0; init_paths[i]; i++) {
      argv[0] = init_paths[i];
      int ret = kernel_execve(init_paths[i], argv, envp);
      if (ret == 0) {
        /* Success — do_execve modified our trapframe.
         * When this kthread returns through the trap return path,
         * it will jump to user space. */
        return;
      }
      printk(KERN_INFO "[init] exec %s failed: %d\n", init_paths[i], ret);
    }

    printk(KERN_ERR "[init] No init found! Kernel panic.\n");
  }

out:
  extern void task_exit(int code);
  task_exit(0);
}

// ============================================================
// Second-stage synchronization barrier (C++ layer)
// AP cores spin here until BSP finishes all global init.
// ============================================================
static lume::atomic<uint32> ap_boot_sync;

// ============================================================
// kernel_main — C++ entry point for all CPUs
// ============================================================
extern "C" [[noreturn]] void kernel_main(uint64 cpu_id, uint64 fdt_paddr) {

  if (cpu_id == bsp_hart_id) {
    // ========================================================
    // BSP: Absolute single-core period — no locks needed.
    // APs are spinning on ap_boot_sync.
    // ========================================================

    uint64 fdt_pa = fdt_paddr;

    // ---- Phase 1: Console + Exception Safety Net ----

    // 1. Early console setup: discover UART via FDT before ANY output.
    console_early_init(fdt_pa);
    klog_init();

    printk("\n");
    printk(KERN_INFO "LumeOS Kernel v0.1\n");
    printk(KERN_INFO "boot: BSP online, cpu_id=%llu\n", cpu_id);
    printk(KERN_INFO "boot: higher-half kernel active\n");

    /* kernel_map filled by arch/riscv/mm/init.cc::setup_vm before MMU
     * enable; relocate_kernel has already applied .rela.dyn. */
    printk(KERN_INFO "boot: kimage phys=0x%llx virt=0x%llx size=%llu\n",
           static_cast<unsigned long long>(kernel_map.phys_addr),
           static_cast<unsigned long long>(kernel_map.virt_addr),
           static_cast<unsigned long long>(kernel_map.size));

    // --- Subsystem init DAG (strict top-down order) ---

    // 2. Trap handler — install exception vector FIRST.
    //    Any fault from here on gets a proper panic backtrace
    //    instead of a silent hang. (Linux: trap_init is in start_kernel
    //    right after setup_arch.)
    trap_init();
    printk(KERN_INFO "init: trap_init done\n");

    // 3. FDT parsing — make device tree available
    fdt_init(fdt_pa);
    printk(KERN_INFO "init: fdt_init done\n");

    // 4. KASLR — seed PRNG and randomise VA layout.
    //    MUST happen before vmm_init() builds the kernel page table.
    {
      uint64 kaslr_seed = 0;
      fdt_early_get_kaslr_seed(&kaslr_seed);
      random_early_init(kaslr_seed);
      arch::kaslr_init();
    }

    // Sort exception table before setting RO permissions in vmm_init()
    extable_init();

    // ---- Phase 2: Memory Subsystem (strict cascade) ----

    // 5. Memblock allocator (Early boot PA allocator)
    memblock_init(fdt_pa);
    printk(KERN_INFO "init: memblock_init done\n");

    // 6. Virtual memory manager — builds page table with KASLR'd bases
    vmm_init();
    printk(KERN_INFO "init: vmm_init done\n");

    // 7. Physical memory manager (Buddy)
    pmm_init();
    printk(KERN_INFO "init: pmm_init done\n");

    // 8. Slab allocator — operator new usable after this
    slab_init();
    printk(KERN_INFO "init: slab_init done\n");

    // 9. Page cache (minimal hash table, stable interface for file-backed mmap)
    page_cache_init();

    // 10. FDT Phase 2 — build DeviceNode object tree (needs Slab)
    fdt_unflatten();
    printk(KERN_INFO "init: fdt_unflatten done\n");

    // ---- Phase 3: Task & Scheduler (software state before hardware) ----

    // 11. Task management (PID allocator + global task list)
    task_init();
    printk(KERN_INFO "init: task_init done\n");

    pgrp_init();

    sched_init();
    printk(KERN_INFO "init: sched_init done\n");

    // ---- Phase 3.5: VFS (needs slab + sched) ----
    super_init();
    ramfs_init();
    vfs_init();
    printk(KERN_INFO "init: vfs_init done (ramfs root mounted)\n");

    // ---- Phase 3.55: Unpack initramfs into root ----
    populate_rootfs();

    // ---- Phase 3.6: Device nodes ----
    cdev_init();
    console_cdev_init();
    devfs_init();
    printk(KERN_INFO "init: devfs done\n");

    // ---- Phase 4: Hardware Drivers & Interrupts ----

    // 13. Hardware Drivers Discovery (Interrupt Controllers, etc)
    driver_probe_all();
    printk(KERN_INFO "init: driver_probe_all done\n");

    // 13.5. TTY subsystem — needs PLIC (driver_probe_all) for UART RX IRQ
    tty_init();
    printk(KERN_INFO "init: tty_init done\n");

    // 14. Timer interrupt (scheduler tick source)
    //     Safe now: scheduler is fully initialized.
    timer_init();
    printk(KERN_INFO "init: timer_init done\n");

    // 15. Syscall jump table
    syscall_init();
    printk(KERN_INFO "init: syscall_init done\n");

    // 16. SMP / IPI infrastructure
    smp_init();
    arch::cpu::software_intr_on(); // Enable S-mode software interrupts for IPI
    arch::cpu::external_intr_on(); // Enable S-mode external interrupts for PLIC (UART)

    // ---- Phase 5: Self-test & Launch ----

    // 17. Boot self-tests — verify subsystem correctness.
    //     Tests that create kthreads must wait() for them (freeing PIDs).
#ifdef CONFIG_SELFTEST
    selftest_run_all();
#endif

    // 18. Spawn PID 1 (init) — the first persistent task.
    //     Like Linux's rest_init() → user_mode_thread(kernel_init).
    //     All test PIDs have been freed, so PID 1 is available.
    TaskControlBlock *init_task =
        kthread_create("init", init_thread_func, nullptr, 0);
    if (init_task) {
      init_task->flags |= TF_INIT;

      /* Init is session and process-group leader: sid = pgid = pid.
       * Allocate signal_struct AND sighand_struct eagerly so every
       * descendant (created via task_clone) inherits a real identity
       * and a real lock object — signal sending must take siglock and
       * cannot tolerate a null sighand. */
      init_task->signal = alloc_signal_struct(init_task->pid, init_task);
      if (!init_task->signal) {
        printk(KERN_ERR "boot: FAILED to allocate init signal_struct\n");
      }
      init_task->sighand = alloc_sighand();
      if (!init_task->sighand) {
        printk(KERN_ERR "boot: FAILED to allocate init sighand\n");
      }

      /* Publish g_init_task so reparenting paths can find the foster
       * parent when other tasks exit before init takes over user space. */
      extern TaskControlBlock* g_init_task;
      g_init_task = init_task;

      printk(KERN_INFO "boot: init thread created (pid=%d sid=%d pgid=%d)\n",
             init_task->pid,
             init_task->signal ? init_task->signal->sid  : -1,
             init_task->signal ? init_task->signal->pgid : -1);
    } else {
      printk(KERN_ERR "boot: FAILED to create init thread!\n");
    }


    BOOT_STAGE(5, "core kernel init");
    printk(KERN_INFO "boot: BSP init complete, releasing APs\n");

    // Release APs with RELEASE semantics:
    // guarantees all global data is visible to APs.
    ap_boot_sync.store(1, __ATOMIC_RELEASE);

    // Start AP harts via SBI HSM extension.
    // OpenSBI v1.0+ parks non-boot harts in STOPPED state.
    // They must be explicitly started with sbi_hart_start().
    //
    // kernel_map.phys_addr was filled by setup_vm in arch/riscv/mm/init.cc
    // before MMU enable — it's the runtime PA at which the kernel was
    // loaded.  APs start at the same PA as the BSP.
    {
      uint64 start_pa = kernel_map.phys_addr;
      if (start_pa == 0) {
        /* Defensive fallback if setup_vm hasn't filled the field. */
        start_pa =
            boot_va_to_pa(virt_addr(reinterpret_cast<uint64>(_start))).raw;
      }
      uint32 num_harts = 4; // TODO: read from FDT /cpus
      for (uint32 h = 0; h < num_harts; h++) {
        if (h == static_cast<uint32>(cpu_id))
          continue; // skip BSP
        auto ret = arch::sbi::sbi_hart_start(h, start_pa, fdt_paddr);
        if (ret.error == arch::sbi::SBI_SUCCESS) {
          printk(KERN_INFO "smp: started hart %u at PA 0x%llx\n", h, start_pa);
        } else {
          printk(KERN_ERR "smp: failed to start hart %u (err=%ld)\n", h,
                 ret.error);
        }
      }
    }

    // BSP enables interrupts — first timer tick will preempt
    // into the scheduler loop, which will pick up PID 1.
    arch::cpu::intr_on();

    printk(KERN_INFO "boot: BSP entering idle loop\n");

  } else {
    // ========================================================
    // AP: spin until BSP finishes global init
    // ========================================================
    // DEBUG (commented out — uncomment for SMP debugging):
    // arch::sbi::sbi_ecall(1, 0, '1');  // AP entered kernel_main

    while (ap_boot_sync.load(__ATOMIC_ACQUIRE) == 0)
      ;

    // arch::sbi::sbi_ecall(1, 0, '2');  // AP passed ap_boot_sync

    // --- Per-CPU init (must happen before any printk!) ---
    // early_pgdir doesn't map UART MMIO, so we MUST switch to
    // BSP's kernel page table before any console output.
    vmm_init_ap(); // Switch to BSP-built kernel page table

    // arch::sbi::sbi_ecall(1, 0, '3');  // vmm_init_ap done

    trap_init_ap(); // Install stvec on this CPU

    // arch::sbi::sbi_ecall(1, 0, '4');  // trap_init_ap done

    printk(KERN_INFO "boot: AP online, cpu_id=%llu\n", cpu_id);

    sched_init_ap(); // Init per-CPU RunQueue, create Idle Task

    // arch::sbi::sbi_ecall(1, 0, '5');  // sched_init_ap done

    timer_init_ap();               // Start this CPU's timer interrupt
    arch::cpu::software_intr_on(); // Enable S-mode software interrupts for IPI
    arch::cpu::external_intr_on(); // Enable S-mode external interrupts for PLIC (UART)

    // AP is now a fully functional scheduler CPU.
    // Enable interrupts — first timer tick preempts into idle loop.
    arch::cpu::intr_on();

    printk(KERN_INFO "boot: AP cpu_id=%llu fully initialized\n", cpu_id);
  }

  // All CPUs reach here.
  // The "current task" is the boot stub (bsp_task or ap_task, pid=-1).
  // We must hand off to the scheduler's idle task by calling schedule().
  // Without this, the BSP runs as bsp_task (O1 class, timeslice=20 ticks)
  // instead of the idle task (which yields immediately when any task is
  // runnable).  That delays PID 1 by up to 200ms and can stall entirely
  // if no timer tick fires before the first WFI.
  {
    TaskControlBlock *self = current_task();
    if (self) {
      self->state = TaskState::Dead; // Boot stub is done; don't re-enqueue
    }
    schedule(); // Switch to idle task (or init if it's already runnable)
  }

  // Should not reach here — schedule() switches away permanently.
  // But just in case, spin with WFI as a safety net.
  while (true) {
    arch::cpu::halt_until_interrupt();
  }
}
