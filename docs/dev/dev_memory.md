# Dev log 
## **1. Process Management:** 
The core architecture has been upgraded from a simple single queue to a Per-CPU scheduler, supporting multi-core concurrency. 

* Process lifecycle: A complete process state machine has been implemented, including UNUSED, RUNNABLE, RUNNING, SLEEPING, and ZOMBIE states. 

* Core operations: 
    * fork(): process cloning, supporting COW (copy-on-write) isolation of memory space between parent and child processes. 
    * exit(): process termination and resource cleanup. 
    * wait(): parent process waits for child process to exit. 
    * sleep()/wakeup(): channel-based sleep and wakeup mechanism. 

* Scheduling algorithm: 
    * O(1) priority scheduling has been implemented (supporting 4 priority queues). 

    * Per-CPU RunQueue: each CPU has its own independent run queue. 

    * Supports Work Stealing: idle CPUs can fetch tasks from other CPUs’ queues. 

## **2. Memory Management:** 
A complete virtual and physical memory management system has been implemented. 

* Physical Memory (PMM): Implements the Buddy System, supporting memory allocation and deallocation in $2^n$ pages. 

* Virtual Memory (VM): Based on RISC-V Sv39 paging mode. Provides secure data copying from user space to kernel space (copyin). 

* COW (Copy-On-Write): During fork, only page table entries are copied and pages are set to read-only; writes trigger page faults for physical copy, greatly improving process creation efficiency. 

* Kernel heap: Implements a Slab Allocator, providing efficient allocation of small objects (such as struct Proc). 

## **3. Synchronization:**

* Spinlock: Used to protect very short critical sections (e.g., scheduler lock, PMM lock), supports disabling interrupts to prevent deadlocks. 

* Mutex (sleeping lock): Used for long critical sections (e.g., file I/O), allowing sleep while holding the lock. 

* Lock Handoff: Implements a complex lock handoff mechanism in the scheduler to ensure atomicity of context switches. 