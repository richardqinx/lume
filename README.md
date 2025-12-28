# Lume Operating System

**Lume** is an experimental operating system kernel built from scratch for the **RISC-V 64** architecture. This project aims to explore the core implementation details of a modern Unix-like operating system.

## 🚀 Current Status

The project is currently deep in **Phase 2: Memory & Process Management**.

The kernel has successfully transitioned from the bootloader to supervisor mode, enabled Sv39 virtual memory paging, and supports the execution of the first user-space process (`initcode`). It features basic process lifecycle management (creation, execution, termination, and reclamation).

### ✅ Key Features Implemented

* **Architecture Support**
    * **Target**: RISC-V 64-bit (Sv39).
    * **Modes**: Supervisor Mode (S-Mode) and User Mode (U-Mode).
    * **Boot Flow**: OpenSBI -> Kernel Entry -> Main.

* **Memory Management**
    * **PMM (Physical Memory Management)**: Page frame allocator based on a free-list structure.
    * **VM (Virtual Memory)**: Full Sv39 multi-level page table mapping.
    * **Address Space**:
        * **Kernel**: Higher-half mapping (Direct Mapping) + Trampoline.
        * **User**: Independent page tables per process, containing code, data, stack, and trap pages.
    * **Isolation**: `Trampoline` page mechanism for safe Kernel/User transitions.

* **Process & Scheduling**
    * **Process Model**: `struct Proc` (PCB) managing independent kernel stacks and trap frames.
    * **Scheduling**: Preemptive Round-Robin scheduler driven by hardware timer interrupts.
    * **Context Switching**: Assembly-level `swtch` logic to save/restore callee-saved registers.
    * **Synchronization**: Spinlocks for protecting critical kernel data structures.

* **System Calls**
    A syscall dispatch framework (`ecall`) is established, currently supporting:
    * `SYS_fork`: Create a child process (deep copy of memory and page tables).
    * `SYS_exit`: Terminate the current process.
    * `SYS_wait`: Wait for a child process to exit and reap resources.
    * `SYS_write`: Write output to the console (currently direct via UART).
    * `SYS_getpid`: Retrieve the current process ID.
    * `SYS_putc`: Character output for debugging.

* **Drivers**
    * **UART**: Basic initialization and polled I/O for kernel logging.

## 📂 Project Structure

```text
Lume/
├── src/
│   ├── boot/           # Bootloader code (entry.S)
│   ├── kernel/         # Core kernel subsystems
│   │   ├── mm/         # Memory Management (pmm.cc, vm.cc)
│   │   ├── proc/       # Process Management (proc.cc, swtch.S)
│   │   ├── trap/       # Interrupt & Exception handling (trap.S, trampoline.S)
│   │   ├── syscall.cc  # System call dispatcher
│   │   ├── main.cc     # Kernel entry point
│   │   └── ...
│   ├── user/           # User-space programs (init.cc, usys.S)
│   ├── drivers/        # Hardware drivers (uart.cc)
│   └── lib/            # Kernel utility libraries (string.cc)
├── include/            # Header files
├── Makefile            # Build configuration
└── link.ld             # Kernel linker script
```

## 🛠️ Build & Run
This project relies on the GCC RISC-V toolchain and QEMU emulator.

### Prerequisites
Compiler: riscv64-linux-gnu-gcc / g++

Emulator: qemu-system-riscv64

Build Tool: make

### Commands
1. **Compile Kernel & User Programs:**

```Bash
make all
```
2. **Run in QEMU (No Graphic Mode):**

```Bash
make run
```
Expected Output: You will see kernel boot logs, page table initialization, and output from the first user process (`initcode`).

3. **Debug Mode (GDB):**

```Bash
make debug
```
This starts QEMU in a paused state, waiting for a GDB connection on port 1234.

4. **Clean Build Artifacts:**

```Bash
make clean
```

## 🗺️ Roadmap
* [x] Phase 1: Foundation

    [x] UART Driver & Formatted Output.

    [x] Physical Memory Allocator (PMM).

    [x] Basic Interrupt Handling Framework.

* [x] Phase 2: Memory & Process (In Progress)

    [x] Virtual Memory (Sv39) & Kernel Page Tables.

    [x] User Address Space Construction.

    [x] Preemptive Scheduler.

    [x] Basic System Calls (fork, exit, wait, write).

    [ ] exec System Call (ELF Loader).

    [ ] sbrk for Dynamic Heap Growth.

* [ ] Phase 3: File System & I/O (Planned)

    [ ] VirtIO Block Device Driver.

    [ ] Virtual File System (VFS).

    [ ] File I/O System Calls (open, read, close).
* [ ] Phase 4: Waiting for you...

## 📄 License
This project is open-source under the MIT License. See the LICENSE file for details.
------------
Copyright (c) 2025 Richard Qin