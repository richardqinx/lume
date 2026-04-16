# Lume OS
**A Lightweight, Educational RISC-V Operating System**
> Luminescence in the Deep Night

Lume OS is a 64-bit monolithic operating system kernel written in C++ for the RISC-V architecture. Currently designed for educational purposes and kernel hacking, the project is now evolving towards a Tiny Linux-Compatible Kernel capable of running standard Linux userspace binaries (musl libc, BusyBox, etc.) by implementing the Linux Syscall ABI.

## Note
After studying for a period of time, I have roughly understood the design of some modern operating systems such as Windows, Linux, and BSD. I decided to refactor this operating system to make its architecture clear, scalable, and portable. My goal is to make this system compatible with the Linux ABI, so that musl libc and busybox can be easily ported, thereby introducing the ability to depend on more Linux software. Although this goal is very distant, I still decided to try. I have chosen to use C++ as the development language, even though many people think C++ is not a language for developing kernels, I believe that the object-oriented features of C++ can make system code easier to read and understand. Compared to reading various complex macros, reading some object-oriented code might be easier for people unfamiliar with the kernel. Therefore, I decided to sacrifice some performance along with extra handling for the C++ runtime in order to achieve this; after all, you have to give up something to gain something. 

The source code of the new system is placed in the `na` (New Architecture) directory, welcome to read it. After learning about the development history of Windows NT, I realized the importance of documentation. The NT team spent a lot of time writing documentation before writing the first line of code, and by the time they wrote code, the system was basically finalized. As a student who is not particularly outstanding, I cannot complete the design of the system before starting to write code, but I can decide on its design before starting each part, and then adjust it according to reality. The documents are in `docs/specs/` directory.

It can basically be concluded that writing an operating system in this era is a thankless task. A personally implemented operating system may never run on machines beyond my own tests, so what is the point of doing this? Perhaps it is just to add color to a monotonous life. However, if you really have ideas, you are welcome to contact me.

The project still uses the GPL v2 License. Since I plan to use GPL v2-only software such as busybox, I cannot make the entire project GPL v3, but for the parts of the source code that I independently complete, you can use GPL v2 or later versions. We must insist on free software; please support the free software movement. This is not about price, it is about freedom.

The following content and the original source code are all deprecated, and it is not recommended that you spend time reading that bad stuff. Your time is valuable and should be spent on more meaningful things.

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