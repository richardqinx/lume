# Lume
> Luminescence in the Deep Night

Lume is a multitasking operating system kernel built for the RISC-V 64 architecture.Developed from the ground up, it was created to explore the art of modern operating system.

## Architecture Overview

The initialization sequence of Lume follows modern OS design principles:

* 1.Boot: entry.asm sets up the initial stack and prepares the C++ environment.

* 2.Discovery: The FDT parser probes the DTB for hardware layout information.

* 3.Memory: Establishes physical and virtual memory mappings.

* 4.Asynchrony: Installs the Trap Handler and enables the SBI timer interrupt.

* 5.Concurrency: Initializes the Process Manager and enters the scheduler loop to run tasks.

## Roadmap

### Phase 1: Foundation (Current Status)

- [x] Bootloader & Entry: Successful hand-off from OpenSBI to Kernel.

- [x] FDT Parsing: Dynamic hardware discovery via Device Tree.

- [x] Physical Memory Management: Basic page-frame allocator.

- [x] Basic Traps: Handling supervisor-mode exceptions and interrupts.

### Phase 2: Memory & Process Management
- [x] Virtual Memory: Full SV39 page table implementation with kernel/user space separation.

- [ ] Slab Allocator: Efficient kernel-level object allocation (kmalloc).

- [ ] Process Lifecycle: Implementation of fork(), exec(), and exit().

- [x] Preemptive Scheduling: Priority-based or Round-robin scheduler.

### Phase 3: I/O & File System
- [ ] VirtIO Drivers: Support for VirtIO-Block and VirtIO-Net devices.

- [ ] Virtual File System (VFS): Abstract layer for multiple file system support.

- [ ] Initial Ramdisk (initrd): Loading a basic user-space environment during boot.

- [ ] Fat32/Ext2 Support: Persistent storage capabilities.

Phase 4: User Space & Stability
- [ ] System Call Interface: Standardized API for user-space applications.

- [ ] User-mode Shell: A basic CLI to interact with the kernel.

- [ ] Multicore (SMP): Booting secondary harts and implementing spinlocks/mutexes.

- [ ] C Standard Library (nolibc): Providing a runtime for user-level C programs.

## Quick Start
### Requirements
* riscv64-linux-gnu-gcc toolchain
* QEMU (riscv64)
### Build and Run
~~~bash
make clean
make all
make run
~~~
When you see the following output, Lumen has successfully illuminated your hardware:
~~~bash
[Lume OS Kernel] Booted in S-Mode.
2025 Richard Qin


[Boot] Kernel started.
PMM: Initializing from[Boot] PMM initialized.
[Boot] Kernel page table created.
[Boot] MMU ENABLED! We are now using virtual addresses.
[Trap] Initialized stvec to: 0x0000000080200090
[Boot] Trap Handler Installed.
[Boot] Timer Interrupt Enabled.
[Boot] ProcManager Initialized.
[Proc] Created thread: Task A
[Proc] Created thread: Task B
[Kernel] Scheduler Starting...
[Proc] Scheduler started.
...
~~~

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

##
Richard Qin Dec 2025