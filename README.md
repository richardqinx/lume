# Lume OS
**A Lightweight, Educational RISC-V Operating System**
> Luminescence in the Deep Night

Lume OS is a 64-bit monolithic operating system kernel written in C++ for the RISC-V architecture. Currently designed for educational purposes and kernel hacking, the project is now evolving towards a Tiny Linux-Compatible Kernel capable of running standard Linux userspace binaries (musl libc, BusyBox, etc.) by implementing the Linux Syscall ABI.

## 🛠 Build & Run

### Prerequisites
* Toolchain: `riscv64-linux-gnu-g++` / `gcc`

* Emulator: `qemu-system-riscv64`

* Build System: `make`

### Compiling
```Bash
# Compile kernel and user programs
make all
```

### Running in QEMU
```Bash
# Run the OS
make run

# Debug mode (attaches GDB)
make debug
```

## 🏗 System Architecture & Current Features
Based on the current source tree, Lume OS implements the following core subsystems:

### 1. Kernel Core & Hardware Abstraction
* Architecture: RISC-V 64-bit (Sv39 paging) targeting QEMU `virt` machine.

* Boot: Device Tree (FDT) parsing for hardware discovery.

* Concurrency: SMP (Symmetric Multi-Processing) support with per-CPU state management.

* Traps: Supervisor-mode interrupt and exception handling.

### 2. Memory Management
* Physical Memory: Buddy System allocator for page-level management.

* Kernel Heap: SLAB allocator (`kmalloc`/`kfree`) for efficient object management.

* Virtual Memory: Basic paging support. Current user process memory model is linear (heap grows contiguously via `sbrk`).

### 3. Process Management
* Scheduling: Round-Robin scheduler with per-CPU runqueues and work stealing mechanisms.

* Context Switching: Saves callee-saved registers; currently lacks FPU/Vector state saving.

* Lifecycle: Basic `fork`, `exec`, `exit`, and `wait` system calls.

### 4. File System & I/O
* VFS: A preliminary Virtual File System abstraction with `inode` polymorphism.

* Filesystem: FAT32 implementation with basic read/write/create/delete support.

* Buffer Cache: Block-level caching (Bio) coupled with the VirtIO driver.

* Drivers:

    * VirtIO: Block device driver (MMIO).

    * UART: 16550A-compatible serial console driver with line buffering.

    * PLIC: Platform-Level Interrupt Controller support.

### 5. User Space
* Libc: A minimal custom C library (`ulib`) providing stdio (`printf`/`scanf`), stdlib (`malloc`/`free`), and string operations.

* Shell: A functional shell (`sh`) supporting pipes (`|`), redirection (`<`, `>`), and background execution (`&`).

* Utils: Standard Unix-like tools: `ls`, `cat`, `echo`, `mkdir`, `rm`, `touch`, `cp`, `mv`.

## 📉 Gap Analysis: Lume OS vs. Linux
To achieve the goal of binary compatibility with the Linux ecosystem, Lume OS is currently undergoing a major refactoring. The following table highlights the critical differences:

|Subsystem|Lume OS (Current)|Linux / Modern Goal|Gap & Impact|
|:------:|:---------:|:--------:|:---------:|
|Syscall ABI|Custom IDs & `-1` return codes|Standard RISC-V headers & `-errno`|Binaries compiled for Linux cannot run on Lume.|
|Memory Model|Linear `p->sz` (Heap only)|VMA (Virtual Memory Areas)|Cannot support `mmap`, memory gaps, or dynamic libraries (`.so`).|
|Binary Format|Static ELF only|Dynamic ELF (`PT_INTERP`)|Cannot run `ld.so` or shared libraries; high memory waste.|
|Threading|Single-threaded Processes|1:1 Threads (`clone` + NPTL)|Cannot support `pthreads` or modern concurrent apps.|
|Filesystem|Tightly coupled FAT32|VFS + Mount Points + Pseudo FS|Missing `/dev`, `/proc`, `/sys`; standard tools (`top`, `ps`) fail.|
|Signals|Basic `kill` flag|Full Signal Handling|No `Ctrl-C` handling, `SIGSEGV` recovery, or async notifications.|
|I/O Model|Synchronous/Blocking|Async/Non-blocking (`poll`/`epoll`)|Cannot support high-performance servers (e.g., Nginx).|

## 🗺️ Roadmap to Linux Compatibility
We are executing a 4-phase plan to transform Lume OS into a Tiny Linux Clone.

### Phase 1: Core Architecture Refactoring (The Foundation)
* [ ] VMA Implementation: Replace `sz` with `vm_area_struct` (RB-Tree/List) to support mmap and demand paging.

* [ ] VFS 2.0: Decouple FAT32. Implement `struct mount`, `dentry` cache, and `RamFS`.

* [ ] DevFS & ProcFS: Implement `/dev` and `/proc` mounting support.

* [ ] Syscall Alignment: Renumber syscalls to match Linux RISC-V 64 ABI and standardize errno.

### Phase 2: Runtime Environment
* [ ] ELF Interpreter: Support `PT_INTERP` to load dynamic linkers (`ld-musl-riscv64.so.1`).

* [ ] Auxiliary Vector: Construct `AT_RANDOM`, `AT_PHDR`, etc., on the user stack.

* [ ] New Syscalls: `brk`, `writev`, `readv`, `ioctl` (TTY), `getdents64`.

### Phase 3: Advanced Process Features
* [ ] Threading: Implement `sys_clone` with `CLONE_VM` / `CLONE_THREAD`.

* [ ] Synchronization: Implement `sys_futex` for userspace locking.

* [ ] Signals: Implement `sigaction`, signal frame construction, and `sigreturn` trampoline.

### Phase 4: Ecosystem & Networking
* [ ] Network Stack: Port lwIP and implement `virtio-net` driver.

* [ ] Socket API: Implement `socket`, `bind`, `connect`, `poll`.

* [ ] Userland: Port Musl Libc and BusyBox.

## 📄 License

Lume OS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

Lume OS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

See the [LICENSE](LICENSE) file for details.