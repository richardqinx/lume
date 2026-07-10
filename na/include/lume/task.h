/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * Task Control Block & Task State
 *
 * Central representation of every execution context in LumeOS,
 * whether kernel thread or (future) user process.
 *
 * Reference: docs/specs/task.md §3.1, docs/specs/scheduler.md §3.1
 */

#include <lume/types.h>
#include <lume/config.h>
#include <lume/list.h>
#include <arch/context.h>
#include <arch/trapframe.h>
#include <arch/fpstate.h>
#include <lume/waitqueue.h>
#include <lume/signal_types.h>

/* Forward declarations */
struct VmSpace;
struct SchedClass;

/* ========================================================================
 * Task State Machine
 * ======================================================================== */

enum class TaskState : uint8 {
    Runnable = 0,   // In a Per-CPU ready queue
    Running  = 1,   // Currently executing on a CPU
    Sleeping = 2,   // Blocked on a WaitQueue
    Zombie   = 3,   // Exited, waiting for parent wait()
    Dead     = 4,   // Fully reclaimed, TCB can be freed
    Stopped  = 5,   // Job control: SIGSTOP/SIGTSTP/SIGTTIN/SIGTTOU
};

/* ========================================================================
 * Task Flags
 * ======================================================================== */

inline constexpr uint8 TF_KTHREAD = 0x01;  // Kernel thread (never enters user mode)
inline constexpr uint8 TF_IDLE    = 0x02;  // Idle thread
inline constexpr uint8 TF_INIT   = 0x04;   // init process (PID 1)

/* ========================================================================
 * Kernel Stack
 * ======================================================================== */

inline constexpr uint64 kKernelStackSize  = CONFIG_KERNEL_STACK_SIZE;
inline constexpr int    kKernelStackOrder = (kKernelStackSize <= 4096)  ? 0
                                          : (kKernelStackSize <= 8192)  ? 1
                                          : (kKernelStackSize <= 16384) ? 2
                                          : (kKernelStackSize <= 32768) ? 3 : 4;
inline constexpr uint64 kStackCanary = 0xDEAD'BEEF'CAFE'BABEULL;

/* ========================================================================
 * Task Control Block
 * ======================================================================== */

struct TaskControlBlock {
    /* ===== Scheduler hot fields (cache-line optimized) ===== */
    TaskState state;            // Current state
    uint8 priority;             // Static priority [0, 31]
    uint8 cpu_id;               // Pinned CPU (Phase 2: no migration)
    uint8 flags;                // TF_KTHREAD | TF_IDLE | TF_INIT

    int32 time_slice;           // Remaining time slice (ticks)
    int32 pid;                  // Unique task ID (Linux: tid)
    int32 tgid;                 // Thread group ID (Linux: pid)
    int32 preempt_count;        // >0: preemption disabled (holding locks etc.)

    list_node run_link;         // RunQueue list node
    list_node all_link;         // Global task list node

    /* ===== Context ===== */
    arch::Context context;      // Callee-saved registers (scheduler switch)
    arch::TrapFrame* trapframe; // Trap frame (user-mode entry/exit)
    arch::FpState fpstate;      // FPU register state (f0-f31 + fcsr)

    /* ===== Kernel Stack ===== */
    uint64 kstack_pa;           // Physical address
    uint64 kstack_va;           // Virtual address (stack bottom)

    /* ===== Address Space ===== */
    VmSpace* mm;                // nullptr = kernel thread

    /* ===== Per-task lock =====
     * Protects: parent, children, sibling, exit_code, state transitions.
     * Lock ordering: task->lock -> g_task_list_lock (never reverse). */
    Spinlock lock;

    /* ===== Task Hierarchy ===== */
    TaskControlBlock* parent;
    list_node children;         // Children list head
    list_node sibling;          // Sibling list node
    WaitQueue wait_chld;        // Parent waits on this for children to exit

    /* ===== Exit ===== */
    int32 exit_code;
    int32 exit_signal;          // Linux: signal sent to parent on exit.
                                //   SIGCHLD  = notify parent, become zombie
                                //   -1       = auto-reap (kthreads)
    uint64 clear_child_tid;     // CLONE_CHILD_CLEARTID: write 0 here on exit

    /* ===== Job control reporting =====
     * stopped_code: 0 means "no pending stop notification"; non-zero is the
     *   Linux wstatus value to hand back from wait4(WUNTRACED). Cleared
     *   after the parent consumes it via wait4 (or task termination).
     * notify_continued: set when SIGCONT resumes us; consumed by
     *   wait4(WCONTINUED). */
    int32 stopped_code;
    bool  notify_continued;

    /* ===== Scheduler class metadata ===== */
    const SchedClass* sched_class;
    void* sched_entity;

    /* ===== VFS ===== */
    struct files_struct* files;     // Per-task fd table (shared via CLONE_FILES)
    struct fs_struct*    fs;        // cwd/root (shared via CLONE_FS)

    /* ===== Signals ===== */
    struct sigpending    pending;       // Per-task pending signal queue
    sigset_t             blocked;       // Blocked signal mask
    struct sighand_struct* sighand;     // Signal handler table (shared via CLONE_SIGHAND)
    struct signal_struct*  signal;      // Thread-group identity: pgid/sid/ctty (shared via CLONE_THREAD)

    /* ===== Debug ===== */
    const char* name;
};

/* ========================================================================
 * current_task() — fast access to the running task on this CPU
 *
 * Must be called with interrupts disabled or while holding a spinlock.
 * ======================================================================== */
TaskControlBlock* current_task();

/* Terminate the current task with a signal. */
void task_kill_current(int sig);
