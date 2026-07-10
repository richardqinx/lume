/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Task Management — create, exit, destroy, kthread
 *
 * Implements task lifecycle management: kernel thread creation,
 * task exit (zombie transition), and resource reclamation.
 *
 * Reference: docs/specs/task.md §4-§6
 */

#include <lume/task.h>
#include <lume/sched.h>
#include <lume/pmm.h>
#include <lume/addr.h>
#include <lume/new.h>
#include <lume/kprintf.h>
#include <lume/klog.h>
#include <lume/vmm.h>
#include <lume/errno.h>
#include <lume/pid.h>
#include <lume/wait.h>
#include <lume/clone.h>
#include <lume/signal_nr.h>
#include <arch/cpu.h>
#include <arch/context.h>
#include <lume/uaccess.h>
#include <lume/fs_struct.h>
#include <lume/fdtable.h>
#include <lume/signal.h>
#include <lume/signal_types.h>
#include <lume/pgrp.h>
#include <arch/pmap.h>
#include <kernel/sync/spinlock.h>

/* ======================================================================
 * Forward declarations
 * ====================================================================== */

extern "C" void kthread_entry_trampoline();
extern "C" void ret_from_fork();

/* ======================================================================
 * Global task list
 * ====================================================================== */

list_node g_all_tasks;
Spinlock g_task_list_lock;
int32 g_nr_tasks = 0;

/* Special tasks */
TaskControlBlock* g_kernel_task = nullptr;  /* PID 0 container */
TaskControlBlock* g_init_task = nullptr;    /* PID 1 (future) */

/* ======================================================================
 * task_init() — called once from kernel_main before sched_init
 * ====================================================================== */

void task_init()
{
    g_all_tasks.init();
    g_task_list_lock.init("task_list");
    g_pid_alloc.init();

    printk(KERN_INFO "init: task_init done (pid_alloc ready)\n");
}

/* ======================================================================
 * alloc_task — allocate TCB + kernel stack
 *
 * This is the SINGLE canonical TCB initializer. Both kthread_create
 * (task.cc) and sched_init (sched_core.cc) must use this function.
 * NEVER duplicate this logic — adding fields to TaskControlBlock
 * requires updating only this function.
 * ====================================================================== */

TaskControlBlock* alloc_task(const char* name, uint8 priority,
                             uint8 flags, uint8 cpu)
{
    auto* task = new TaskControlBlock;
    if (!task) return nullptr;

    task->context = {};

    /* Allocate 8KB kernel stack (order-1 = 2 pages) */
    Page* stack_page = pmm_alloc_pages(1);
    if (!stack_page) {
        delete task;
        return nullptr;
    }
    task->kstack_pa = page_to_pa(stack_page).raw;
    task->kstack_va = pa_to_va(phys_addr(task->kstack_pa)).raw;

    /* Write stack canary at bottom */
    *reinterpret_cast<uint64*>(task->kstack_va) = kStackCanary;

    /* Place TrapFrame at the top of the kernel stack (like Linux pt_regs).
     * ALL tasks — kernel threads and user processes — have a TrapFrame
     * here. kthread_create sets the initial SP below the TrapFrame so
     * the kthread function never touches this reserved area.
     * kernel_execve / do_execve can later fill it in for user-mode return. */
    uint64 tf_addr = task->kstack_va + kKernelStackSize
                     - sizeof(arch::TrapFrame);
    task->trapframe = reinterpret_cast<arch::TrapFrame*>(tf_addr);
    __builtin_memset(task->trapframe, 0, sizeof(arch::TrapFrame));

    /* Basic fields */
    task->name = name;
    task->priority = priority;
    task->time_slice = priority_to_timeslice(priority);
    task->state = TaskState::Runnable;
    task->cpu_id = cpu;
    task->flags = flags;
    task->exit_code = 0;
    task->exit_signal = 0;
    task->preempt_count = 0;
    task->clear_child_tid = 0;
    task->stopped_code = 0;
    task->notify_continued = false;
    task->parent = nullptr;
    task->mm = nullptr;
    task->fpstate = {};
    task->files = nullptr;
    task->fs = nullptr;
    task->pending.init();
    task->blocked.clear();
    task->sighand = nullptr;
    task->signal  = nullptr;

    /* Init all list nodes */
    task->run_link.init();
    task->all_link.init();
    task->children.init();
    task->sibling.init();
    task->lock.init("task");
    task->wait_chld.init("wait_chld");

    /* Default sched class */
    extern const SchedClass g_sched_class_o1;
    task->sched_class = &g_sched_class_o1;
    task->sched_entity = &task->run_link;

    return task;
}

/* Add task to global task list */
static void task_list_add(TaskControlBlock* task)
{
    LockGuard guard(g_task_list_lock);

    list_node* head = &g_all_tasks;
    task->all_link.prev = head->prev;
    task->all_link.next = head;
    head->prev->next = &task->all_link;
    head->prev = &task->all_link;

    g_nr_tasks++;
}

/* Remove task from global task list */
static void task_list_remove(TaskControlBlock* task)
{
    LockGuard guard(g_task_list_lock);

    task->all_link.prev->next = task->all_link.next;
    task->all_link.next->prev = task->all_link.prev;
    task->all_link.init();

    if (g_nr_tasks > 0)
        g_nr_tasks--;
}

/* ======================================================================
 * kthread_create — create a kernel thread
 * ====================================================================== */

TaskControlBlock* kthread_create(const char* name,
                                 void (*entry)(void*),
                                 void* arg,
                                 uint8 priority)
{
    TaskControlBlock* task = alloc_task(name, priority, TF_KTHREAD,
                                         static_cast<uint8>(arch::cpu::id()));
    if (!task) return nullptr;

    /* Allocate PID */
    task->pid = g_pid_alloc.alloc();
    if (task->pid < 0) {
        /* PID exhausted — clean up */
            pmm_free_pages(pa_to_page(phys_addr(task->kstack_pa)), 1);
        delete task;
        return nullptr;
    }
    task->tgid = task->pid;

    /* Kernel threads: exit_signal = -1 → auto-reap on exit.
     * Linux: kernel_thread() passes (flags & ~CSIGNAL) → exit_signal = 0,
     * but kthreads' parent (kthreadd) reaps them.  We have no kthreadd,
     * so we use -1 which makes exit_notify() call release_task() directly,
     * identical to Linux's CLONE_THREAD autoreap path. */
    task->exit_signal = -1;

    /* Set up context for kthread_entry_trampoline.
     * SP starts BELOW the TrapFrame reserved at the stack top.
     * This ensures the kthread function never clobbers the TrapFrame area. */
    uint64 stack_top = task->kstack_va + kKernelStackSize
                       - sizeof(arch::TrapFrame);
    task->context = {};
    task->context.ra = reinterpret_cast<uint64>(kthread_entry_trampoline);
    task->context.sp = stack_top;
    task->context.s[0] = reinterpret_cast<uint64>(entry);
    task->context.s[1] = reinterpret_cast<uint64>(arg);

    /* Parent is kernel_task (PID 0) or current caller */
    TaskControlBlock* parent = g_kernel_task ? g_kernel_task : current_task();
    task->parent = parent;
    if (parent) {
        LockGuard guard(parent->lock);
        list_node* head = &parent->children;
        task->sibling.prev = head->prev;
        task->sibling.next = head;
        head->prev->next = &task->sibling;
        head->prev = &task->sibling;
    }

    /* Add to global list and enqueue */
    task_list_add(task);
    sched_enqueue(task);

    return task;
}

/* ======================================================================
 * task_exit — transition current task to Zombie
 * ====================================================================== */

void task_exit(int code)
{
    TaskControlBlock* curr = current_task();
    if (!curr) kernel_panic("task_exit: no current task");

    /* Linux ABI: normal exit encodes status as (code & 0xFF) << 8 */
    curr->exit_code = (code & 0xFF) << 8;

    /* CLONE_CHILD_CLEARTID / set_tid_address: write 0 to user tidptr.
     * This is how pthread_join detects thread termination.
     * TODO: futex_wake(clear_child_tid, 1) after writing 0. */
    if (curr->clear_child_tid != 0 && curr->mm != nullptr) {
        int32 zero = 0;
        copy_to_user(curr->clear_child_tid, &zero, sizeof(zero));
        curr->clear_child_tid = 0;
    }

    /* Release user address space (refcount-safe).
     * MUST switch to kernel page table FIRST — otherwise we're running
     * on a freed page table after put() deallocates it. */
    if (curr->mm != nullptr) {
        extern uint64 g_kernel_pgtbl;
        pmap::activate(g_kernel_pgtbl);
        curr->mm->put();
        curr->mm = nullptr;
    }

    /* Reparent children to init (or kernel_task if no init yet) */
    TaskControlBlock* foster = g_init_task ? g_init_task : g_kernel_task;
    if (foster && !curr->children.is_empty()) {
        LockGuard guard(curr->lock);

        list_node* child_node = curr->children.next;
        while (child_node != &curr->children) {
            list_node* next_sib = child_node->next;
            auto* child = list_entry<TaskControlBlock,
                                     &TaskControlBlock::sibling>(child_node);
            child->parent = foster;

            /* Move sibling link to foster's children */
            child_node->prev->next = child_node->next;
            child_node->next->prev = child_node->prev;

            list_node* fhead = &foster->children;
            child_node->prev = fhead->prev;
            child_node->next = fhead;
            fhead->prev->next = child_node;
            fhead->prev = child_node;

            child_node = next_sib;
        }
        curr->children.init();
    }


    /* ---- exit_notify: Linux kernel/exit.c:exit_notify() ----
     * Determine whether this task should be auto-reaped or become zombie.
     *
     * Linux logic (simplified):
     *   - exit_signal == -1 (kthreads, sub-threads): autoreap = true
     *   - exit_signal >= 1 (user processes): notify parent, become zombie
     *
     * If autoreap, we call release_task() equivalent inline:
     * free PID, remove from task list, then deschedule to Dead. */
    bool autoreap = (curr->exit_signal <= 0);

    if (autoreap) {
        /* Auto-reap: release resources immediately (no zombie state).
         * Linux: exit_notify() → tsk->exit_state = EXIT_DEAD → release_task() */
        task_list_remove(curr);
        g_pid_alloc.free(curr->pid);

        /* Remove from parent's children list */
        curr->sibling.prev->next = curr->sibling.next;
        curr->sibling.next->prev = curr->sibling.prev;
        curr->sibling.init();

        /* Drop signal_struct ref: last task in the thread group also
         * detaches us from the pgrp hash. */
        if (curr->signal) {
            put_signal_struct(curr->signal);
            curr->signal = nullptr;
        }
        if (curr->sighand) {
            put_sighand(curr->sighand);
            curr->sighand = nullptr;
        }

        curr->state = TaskState::Dead;
        schedule();
        __builtin_unreachable();
    }

    /* User process path: become Zombie for parent wait() */
    curr->state = TaskState::Zombie;

    /* Wake parent->wait_chld queue */
    if (curr->parent) {
        curr->parent->wait_chld.wake_all();
    }

    /* Yield CPU — never returns */
    schedule();

    __builtin_unreachable();
}

void task_kill_current(int sig)
{
    TaskControlBlock* curr = current_task();
    if (!curr) kernel_panic("task_kill_current: no current task");

    /* Linux ABI: signal-killed encodes status as (signo & 0x7F) */
    curr->exit_code = sig & 0x7F;

    /* Release user address space (refcount-safe).
     * Switch to kernel page table first (same as task_exit). */
    if (curr->mm) {
        extern uint64 g_kernel_pgtbl;
        pmap::activate(g_kernel_pgtbl);
        curr->mm->put();
        curr->mm = nullptr;
    }

    /* Reparent children (same as task_exit) */
    TaskControlBlock* foster = g_init_task ? g_init_task : g_kernel_task;
    if (foster && !curr->children.is_empty()) {
        LockGuard guard(curr->lock);

        list_node* child_node = curr->children.next;
        while (child_node != &curr->children) {
            list_node* next_sib = child_node->next;
            auto* child = list_entry<TaskControlBlock,
                                     &TaskControlBlock::sibling>(child_node);
            child->parent = foster;

            child_node->prev->next = child_node->next;
            child_node->next->prev = child_node->prev;

            list_node* fhead = &foster->children;
            child_node->prev = fhead->prev;
            child_node->next = fhead;
            fhead->prev->next = child_node;
            fhead->prev = child_node;

            child_node = next_sib;
        }
        curr->children.init();
    }

    curr->state = TaskState::Zombie;

    if (curr->parent) {
        curr->parent->wait_chld.wake_all();
    }

    schedule();
    __builtin_unreachable();
}

/* ======================================================================
 * task_destroy — fully reclaim a Zombie task (called by waitpid)
 * ====================================================================== */

void task_destroy(TaskControlBlock* task)
{
    /* Remove from global list */
    task_list_remove(task);

    /* Remove from parent's children */
    task->sibling.prev->next = task->sibling.next;
    task->sibling.next->prev = task->sibling.prev;
    task->sibling.init();

    /* Free PID */
    g_pid_alloc.free(task->pid);

    /* Drop signal_struct + sighand refs.  For zombies these are delayed
     * until reap (here) so a waitpid() walker can still inspect
     * pgid/sid; Linux defers __exit_signal/__cleanup_sighand to
     * release_task() for the same reason. */
    if (task->signal) {
        put_signal_struct(task->signal);
        task->signal = nullptr;
    }
    if (task->sighand) {
        put_sighand(task->sighand);
        task->sighand = nullptr;
    }

    /* Free kernel stack */
    if (task->kstack_pa != 0) {
           pmm_free_pages(pa_to_page(phys_addr(task->kstack_pa)), 1);
    }

    /* Free TCB */
    delete task;
}

/* ======================================================================
 * do_wait4 — wait for a child to exit (Linux-compatible)
 *
 * @wait_pid: >0  = specific child PID
 *            -1  = any child
 *            0   = any child in same process group (TODO)
 *            <-1 = any child in specific process group (TODO)
 * @options:  WNOHANG = return immediately if no zombie
 * @exit_code: output parameter (already in Linux wstatus format)
 *
 * Returns: PID of exited child, -ECHILD, or -EAGAIN (WNOHANG).
 * ====================================================================== */

int32 do_wait4(int32 wait_pid, int options, int32* exit_code)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return -EINVAL;

    while (true) {
        TaskControlBlock* zombie = nullptr;
        TaskControlBlock* report = nullptr;   /* Stopped/Continued report */
        int32 report_status = 0;
        bool has_children = false;

        /*
         * Two-phase wait: put ourselves on the wait queue BEFORE
         * checking the condition. This closes the race window where
         * a child exits between our check and schedule().
         *
         * If a child exits and calls wake_all() while we're checking,
         * our state will be flipped back to Runnable, and schedule()
         * will simply return immediately.
         */
        curr->wait_chld.prepare_to_wait(curr, TaskState::Sleeping);

        /* Scan children */
        curr->lock.acquire();

        if (curr->children.is_empty()) {
            curr->lock.release();
            curr->wait_chld.finish_wait(curr);
            return -ECHILD;
        }
        has_children = true;

        list_node* node = curr->children.next;
        while (node != &curr->children) {
            auto* child = list_entry<TaskControlBlock, &TaskControlBlock::sibling>(node);
            bool matches = (wait_pid == -1) || (wait_pid == child->pid);
            if (!matches) {
                node = node->next;
                continue;
            }

            /* Zombie reaping has priority — it frees resources. */
            if (child->state == TaskState::Zombie) {
                zombie = child;
                break;
            }

            /* WUNTRACED: report Stopped child once per stop event. */
            if ((options & WUNTRACED) && child->stopped_code != 0) {
                report = child;
                report_status = child->stopped_code;
                break;
            }

            /* WCONTINUED: report a one-shot SIGCONT resume. */
            if ((options & WCONTINUED) && child->notify_continued) {
                report = child;
                report_status = W_CONTINUED();
                break;
            }

            node = node->next;
        }
        curr->lock.release();

        if (zombie) {
            curr->wait_chld.finish_wait(curr);
            int32 pid = zombie->pid;
            if (exit_code) *exit_code = zombie->exit_code;
            task_destroy(zombie);
            return pid;
        }

        if (report) {
            /* Status-only report: clear the one-shot flag, leave the
             * child alive.  WNOWAIT (peek) would skip the clear, but
             * we don't yet honour it. */
            curr->wait_chld.finish_wait(curr);
            int32 pid = report->pid;
            if (exit_code) *exit_code = report_status;
            if (W_CONTINUED() == report_status) {
                report->notify_continued = false;
            } else {
                report->stopped_code = 0;
            }
            return pid;
        }

        /* No event to report */
        if (!has_children) {
            curr->wait_chld.finish_wait(curr);
            return -ECHILD;
        }
        if (options & WNOHANG) {
            curr->wait_chld.finish_wait(curr);
            return 0;
        }

        /* Condition still false — deschedule.
         * We are already on the wait queue and marked Sleeping. */
        schedule();

        /* Woken up — finish_wait removes us from queue, restores Runnable */
        curr->wait_chld.finish_wait(curr);

        /* Loop back to re-check the condition */
    }
}

/* Legacy wrapper for internal callers */
int32 task_wait(int32* exit_code)
{
    return do_wait4(-1, 0, exit_code);
}

/* ======================================================================
 * task_clone — clone current task with Linux-compatible flags
 *
 * @tf:          trap frame to copy to child
 * @clone_flags: CLONE_VM | CLONE_THREAD | CSIGNAL etc.
 * @child_stack: if non-zero, set as child's user SP (for pthread)
 * @parent_tidptr: write child tid here in parent (CLONE_PARENT_SETTID)
 * @child_tidptr:  write child tid here in child  (CLONE_CHILD_SETTID)
 * @tls:         TLS pointer (CLONE_SETTLS → tp register)
 *
 * Returns: child PID in parent, 0 in child, or negative errno.
 * ====================================================================== */

int32 task_clone(arch::TrapFrame* tf, uint64 clone_flags,
                 uint64 child_stack, uint64 parent_tidptr,
                 uint64 child_tidptr, uint64 tls)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return -EINVAL;

    TaskControlBlock* child = alloc_task("cloned", curr->priority, 0,
                                          static_cast<uint8>(arch::cpu::id()));
    if (!child) return -ENOMEM;

    /* Allocate PID */
    child->pid = g_pid_alloc.alloc();
    if (child->pid < 0) {
           pmm_free_pages(pa_to_page(phys_addr(child->kstack_pa)), 1);
        delete child;
        return -ENOMEM;
    }

    /* exit_signal + tgid: from clone_flags.
     * Linux: fork.c line 2418/2424 */
    if (clone_flags & CLONE_THREAD) {
        child->tgid = curr->tgid;
        child->exit_signal = -1;     /* Linux: sub-threads auto-reap */
    } else {
        child->tgid = child->pid;
        child->exit_signal = static_cast<int32>(clone_flags & 0xFF);  /* CSIGNAL */
        if (child->exit_signal == 0) {
            child->exit_signal = SIGCHLD;  /* default for fork() */
        }
    }

    /* Address space: CLONE_VM shares, otherwise deep copy */
    if (clone_flags & CLONE_VM) {
        if (curr->mm) {
            curr->mm->incref();
            child->mm = curr->mm;
        }
    } else {
        if (curr->mm) {
            child->mm = vmm_clone(curr->mm);
            if (!child->mm) {
                g_pid_alloc.free(child->pid);
                pmm_free_pages(pa_to_page(phys_addr(child->kstack_pa)), 1);
                delete child;
                return -ENOMEM;
            }
        }
    }

    /* Copy TrapFrame to the child's kernel stack */
    uint64 tf_addr = child->kstack_va + kKernelStackSize - sizeof(arch::TrapFrame);
    child->trapframe = reinterpret_cast<arch::TrapFrame*>(tf_addr);
    *child->trapframe = *tf;

    /* Set Kernel SP */
    child->trapframe->kernel_sp = reinterpret_cast<uint64>(child->trapframe);
    child->trapframe->kernel_cpu_id = child->cpu_id;

    /* Child returns 0 from fork/clone */
    child->trapframe->a[0] = 0;

    /* If caller specified a child stack, use it (pthread_create) */
    if (child_stack != 0) {
        child->trapframe->sp = child_stack;
    }

    /* CLONE_SETTLS: set thread pointer register */
    if (clone_flags & CLONE_SETTLS) {
        child->trapframe->tp = tls;
    }

    /* Set up context for ret_from_fork */
    uint64 stack_top = tf_addr;
    child->context = {};
    child->context.ra = reinterpret_cast<uint64>(ret_from_fork);
    child->context.sp = stack_top;
    child->context.s[0] = tf_addr;

    /* ---- Copy fs_struct (Linux: copy_fs in fork.c) ----
     * CLONE_FS: share the same fs_struct (increment refcount).
     * Otherwise: allocate a new fs_struct copying root/pwd. */
    if (curr->fs != nullptr) {
        if (clone_flags & CLONE_FS) {
            curr->fs->count.fetch_add(1, __ATOMIC_RELAXED);
            child->fs = curr->fs;
        } else {
            child->fs = copy_fs_struct(curr->fs);
        }
    }

    /* ---- Copy files_struct (Linux: copy_files in fork.c) ----
     * CLONE_FILES: share the same fd table.
     * Otherwise: duplicate the fd table. */
    if (curr->files != nullptr) {
        if (clone_flags & CLONE_FILES) {
            curr->files->count.fetch_add(1, __ATOMIC_RELAXED);
            child->files = curr->files;
        } else {
            child->files = dup_fd(curr->files);
        }
    }

    /* ---- Copy sighand (Linux kernel/fork.c:copy_sighand) ----
     * CLONE_SIGHAND: share signal handlers (incref parent's).
     * Otherwise: deep copy of the action table; child gets its own
     * sighand_struct (and its own siglock).  Both branches MUST yield
     * a non-null sighand — every user task needs one so signal paths
     * can take the siglock without lazy-allocation races. */
    if (clone_flags & CLONE_SIGHAND) {
        if (!curr->sighand) {
            /* CLONE_SIGHAND requires the parent to have a sighand. */
            return -EINVAL;
        }
        get_sighand(curr->sighand);
        child->sighand = curr->sighand;
    } else {
        child->sighand = copy_sighand(curr->sighand);
        if (!child->sighand) {
            /* OOM — same best-effort policy as fs/files/signal above.
             * A separate cleanup-on-OOM pass is on the to-do list. */
        }
    }

    /* ---- Copy signal_struct (Linux: copy_signal in fork.c) ----
     * CLONE_THREAD shares the parent's signal_struct (incref).
     * Otherwise allocate a new one that inherits pgid/sid/tty from the
     * parent so the child stays in the same process group and session —
     * this is what makes fork() participate in the existing job-control
     * identity without explicit setpgid() calls. */
    if (curr->signal != nullptr) {
        if (clone_flags & CLONE_THREAD) {
            get_signal_struct(curr->signal);
            child->signal = curr->signal;
        } else {
            child->signal = fork_signal_struct(curr->signal, child);
        }
    }

    /* Add to task tree */
    child->parent = curr;
    {
        LockGuard guard(curr->lock);
        list_node* head = &curr->children;
        child->sibling.prev = head->prev;
        child->sibling.next = head;
        head->prev->next = &child->sibling;
        head->prev = &child->sibling;
    }

    /* Add to global list and enqueue */
    task_list_add(child);
    sched_enqueue(child);

    /* CLONE_PARENT_SETTID: write child tid to parent's user address */
    if ((clone_flags & CLONE_PARENT_SETTID) && parent_tidptr != 0) {
        copy_to_user(parent_tidptr, &child->pid, sizeof(child->pid));
    }

    /* CLONE_CHILD_SETTID: write child tid into child's user address.
     * Note: this runs in parent context, but the address is in the
     * child's mm. For CLONE_VM (threads), parent and child share mm
     * so this works directly. For fork, the page was just CoW-copied. */
    if ((clone_flags & CLONE_CHILD_SETTID) && child_tidptr != 0) {
        if (clone_flags & CLONE_VM) {
            /* Same address space — write directly */
            copy_to_user(child_tidptr, &child->pid, sizeof(child->pid));
        }
        /* For non-CLONE_VM fork, the child's mm is separate.
         * The write would need to go into the child's pagetable.
         * Linux handles this in the child's first schedule via
         * a special flag. For now, threads (CLONE_VM) are the
         * primary consumer. */
    }

    /* CLONE_CHILD_CLEARTID: kernel writes 0 to child_tidptr on exit */
    if (clone_flags & CLONE_CHILD_CLEARTID) {
        child->clear_child_tid = child_tidptr;
    }

    return child->pid;
}

/* Legacy wrapper — plain fork() semantics */
int32 task_fork(arch::TrapFrame* tf)
{
    return task_clone(tf, SIGCHLD, 0, 0, 0, 0);
}


/* ======================================================================
 * task_check_stack_canary
 * ====================================================================== */

void task_check_stack_canary(TaskControlBlock* task)
{
    if (!task || task->kstack_va == 0) return;

    auto* canary = reinterpret_cast<uint64*>(task->kstack_va);
    if (*canary != kStackCanary) {
        kernel_panic("kernel stack overflow detected");
    }
}
