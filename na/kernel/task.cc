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
#include <arch/cpu.h>
#include <arch/context.h>
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
 * Internal: allocate TCB + kernel stack
 * ====================================================================== */

static TaskControlBlock* alloc_task(const char* name, uint8 priority,
                                    uint8 flags)
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

    /* Basic fields */
    task->name = name;
    task->priority = priority;
    task->time_slice = priority_to_timeslice(priority);
    task->state = TaskState::Runnable;
    task->cpu_id = static_cast<uint8>(arch::cpu::id());
    task->flags = flags;
    task->exit_code = 0;
    task->parent = nullptr;
    task->mm = nullptr;
    task->trapframe = nullptr;

    /* Init all list nodes */
    task->run_link.init();
    task->all_link.init();
    task->children.init();
    task->sibling.init();
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
    TaskControlBlock* task = alloc_task(name, priority, TF_KTHREAD);
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

    /* Set up context for kthread_entry_trampoline */
    uint64 stack_top = task->kstack_va + kKernelStackSize;
    task->context = {};
    task->context.ra = reinterpret_cast<uint64>(kthread_entry_trampoline);
    task->context.sp = stack_top;
    task->context.s[0] = reinterpret_cast<uint64>(entry);
    task->context.s[1] = reinterpret_cast<uint64>(arg);

    /* Parent is kernel_task (PID 0) */
    task->parent = g_kernel_task;
    if (g_kernel_task) {
        LockGuard guard(g_task_list_lock);
        list_node* head = &g_kernel_task->children;
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

    curr->exit_code = code;

    /* Release user address space if we're the last reference */
    if (curr->mm) {
        curr->mm->destroy();
        curr->mm = nullptr;
    }

    /* Reparent children to init (or kernel_task if no init yet) */
    TaskControlBlock* foster = g_init_task ? g_init_task : g_kernel_task;
    if (foster && !curr->children.is_empty()) {
        LockGuard guard(g_task_list_lock);

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

    /* Transition to Zombie — TCB + kstack preserved for parent wait() */
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
    int code = (sig & 0x7F) | kExitCodeSignalFlag;
    task_exit(code);
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

    /* Free kernel stack */
    if (task->kstack_pa != 0) {
           pmm_free_pages(pa_to_page(phys_addr(task->kstack_pa)), 1);
    }

    /* Free TCB */
    delete task;
}

/* ======================================================================
 * task_wait — sleep until a child exits, then reclaim it
 * Returns PID of exited child, or -ECHILD if no children exist.
 * ====================================================================== */

int32 task_wait(int32* exit_code)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return -EINVAL;

    while (true) {
        TaskControlBlock* zombie = nullptr;

        /* Look for a Zombie child */
        g_task_list_lock.acquire();
        if (curr->children.is_empty()) {
            g_task_list_lock.release();
            return -ECHILD;
        }

        list_node* node = curr->children.next;
        while (node != &curr->children) {
            auto* child = list_entry<TaskControlBlock, &TaskControlBlock::sibling>(node);
            if (child->state == TaskState::Zombie) {
                zombie = child;
                break;
            }
            node = node->next;
        }
        g_task_list_lock.release();

        if (zombie) {
            int32 pid = zombie->pid;
            if (exit_code) {
                /* In a real kernel, we copy_to_user */
                *exit_code = zombie->exit_code;
            }
            task_destroy(zombie);
            return pid;
        }

        /* Sleep if no child has exited yet */
        curr->wait_chld.sleep(&g_task_list_lock);
    }
}

/* ======================================================================
 * task_fork — clone current task
 * ====================================================================== */

int32 task_fork(arch::TrapFrame* tf)
{
    TaskControlBlock* curr = current_task();
    if (!curr) return -EINVAL;

    TaskControlBlock* child = alloc_task("forked", curr->priority, 0);
    if (!child) return -ENOMEM;

    /* Allocate PID */
    child->pid = g_pid_alloc.alloc();
    if (child->pid < 0) {
           pmm_free_pages(pa_to_page(phys_addr(child->kstack_pa)), 1);
        delete child;
        return -ENOMEM;
    }
    child->tgid = child->pid;

    /* Copy VmSpace */
    if (curr->mm) {
        child->mm = vmm_clone(curr->mm);
        if (!child->mm) {
            g_pid_alloc.free(child->pid);
            pmm_free_pages(pa_to_page(phys_addr(child->kstack_pa)), 1);
            delete child;
            return -ENOMEM;
        }
    }

    /* Copy TrapFrame to the child's kernel stack */
    uint64 tf_addr = child->kstack_va + kKernelStackSize - sizeof(arch::TrapFrame);
    child->trapframe = reinterpret_cast<arch::TrapFrame*>(tf_addr);
    *child->trapframe = *tf;

    /* Child returns 0 from fork */
    child->trapframe->a[0] = 0;

    /* Set up context for ret_from_fork */
    uint64 stack_top = tf_addr; // Context goes below TrapFrame conceptually, but we just set SP
    child->context = {};
    child->context.ra = reinterpret_cast<uint64>(ret_from_fork);
    child->context.sp = stack_top;
    child->context.s[0] = tf_addr; /* Passed to a0 in ret_from_fork */

    /* Add to task tree */
    child->parent = curr;
    {
        LockGuard guard(g_task_list_lock);
        list_node* head = &curr->children;
        child->sibling.prev = head->prev;
        child->sibling.next = head;
        head->prev->next = &child->sibling;
        head->prev = &child->sibling;
    }

    /* Add to global list and enqueue */
    task_list_add(child);
    sched_enqueue(child);

    return child->pid;
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
