/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * Scheduler Core
 *
 * The core walks sched_class chain to pick the next task. Each class
 * owns its own runqueue data and policy. This file owns the per-CPU
 * runqueue array and the scheduling state machine.
 */

#include <lume/sched.h>
#include <lume/sched_class.h>
#include <lume/task.h>
#include <lume/pmm.h>
#include <lume/vmm.h>
#include <lume/addr.h>
#include <lume/new.h>
#include <lume/kprintf.h>
#include <lume/klog.h>
#include <lume/smp.h>
#include <arch/cpu.h>
#include <arch/mmu.h>
#include <arch/trap.h>
#include <arch/context.h>
#include <kernel/sched_internal.h>

/* Assembly trampoline symbol (MD layer) */
extern "C" void kthread_entry_trampoline();

/* Per-CPU runqueue array */
static RunQueue g_rq[kMaxCpus];

/* sched_class chain head (highest priority first) */
static const SchedClass* g_sched_class_head = &g_sched_class_o1;

/* ========================================================================
 * Idle thread
 * ======================================================================== */

static void idle_thread_func(void* /*arg*/)
{
    while (true) {
        if (g_rq[arch::cpu::id()].need_resched()) {
            schedule();
        }
        arch::cpu::intr_on();
        arch::cpu::halt_until_interrupt();
    }
}


/* ========================================================================
 * Idle class (always returns idle task)
 * ======================================================================== */

static void idle_init_rq(RunQueue* /*rq*/) {}
static void idle_enqueue(RunQueue* /*rq*/, TaskControlBlock* /*task*/) {}
static void idle_dequeue(RunQueue* /*rq*/, TaskControlBlock* /*task*/) {}
static TaskControlBlock* idle_pick_next(RunQueue* rq) { return rq->idle(); }
static void idle_put_prev(RunQueue* /*rq*/, TaskControlBlock* /*task*/) {}
static void idle_task_tick(RunQueue* /*rq*/, TaskControlBlock* /*curr*/) {}
static void idle_yield(RunQueue* /*rq*/, TaskControlBlock* /*curr*/) {}

const SchedClass g_sched_class_idle = {
    .name = "idle",
    .next = nullptr,
    .init_rq = idle_init_rq,
    .enqueue_task = idle_enqueue,
    .dequeue_task = idle_dequeue,
    .pick_next_task = idle_pick_next,
    .put_prev_task = idle_put_prev,
    .task_tick = idle_task_tick,
    .yield_task = idle_yield,
};

/* ========================================================================
 * Internal helpers
 * ======================================================================== */

static RunQueue* rq_for_cpu(uint32 cpu_id)
{
    return &g_rq[cpu_id];
}

static RunQueue* this_rq()
{
    return rq_for_cpu(arch::cpu::id());
}

static TaskControlBlock* pick_next_task(RunQueue* rq)
{
    for (const SchedClass* c = g_sched_class_head; c; c = c->next) {
        TaskControlBlock* t = c->pick_next_task(rq);
        if (t) {
            return t;
        }
    }
    return rq->idle();
}

static const char* idle_name_for_cpu(uint32 cpu)
{
    static char names[kMaxCpus][16];
    if (cpu >= kMaxCpus) {
        kernel_panic("sched: cpu_id out of range");
    }

    if (names[cpu][0] == '\0') {
        ksnprintf(names[cpu], sizeof(names[cpu]), "idle/%u", cpu);
    }
    return names[cpu];
}

/* ========================================================================
 * Kernel thread entry — MI-layer function called by MD trampoline
 * ======================================================================== */

/* Forward declaration — C++ linkage (task.cc) */
void task_exit(int code);

extern "C" void kthread_entry(void (*entry)(void*), void* arg)
{
    RunQueue* rq = this_rq();
    rq->lock().release();

    arch::cpu::intr_on();

    entry(arg);

    /* Entry function returned — clean exit (release PID, stack, TCB) */
    task_exit(0);
    __builtin_unreachable();
}

/* ========================================================================
 * fork_child_entry — called from ret_from_fork assembly
 * ======================================================================== */
extern "C" void userret(arch::TrapFrame* tf);
extern "C" void trap_vector();

extern "C" void fork_child_entry(arch::TrapFrame* tf)
{
    RunQueue* rq = this_rq();
    rq->lock().release();

    /* Set stvec to trap_vector for user-mode traps, then return to user */
    arch::trap::set_vector(reinterpret_cast<uint64>(trap_vector));
    userret(tf);
    
    __builtin_unreachable();
}

/* ========================================================================
 * alloc_task — canonical TCB allocator (defined in task.cc)
 *
 * Single point of initialization for TaskControlBlock. Ensures all
 * fields are properly zeroed when the struct gains new members.
 * ======================================================================== */

extern TaskControlBlock* alloc_task(const char* name, uint8 priority,
                                    uint8 flags, uint8 cpu);

/* ========================================================================
 * Public API: current_task()
 * ======================================================================== */

TaskControlBlock* current_task()
{
    return this_rq()->current();
}

/* ========================================================================
 * Public API: sched_enqueue / sched_dequeue
 * ======================================================================== */

void sched_enqueue(TaskControlBlock* task)
{
    RunQueue* rq = rq_for_cpu(task->cpu_id);
    LockGuard guard(rq->lock());

    if (!task->sched_class) {
        task->sched_class = &g_sched_class_o1;
    }
    if (!task->sched_entity) {
        task->sched_entity = &task->run_link;
    }

    task->sched_class->enqueue_task(rq, task);
    
    if (rq->current() == rq->idle() || task->priority < rq->current()->priority) {
        rq->set_need_resched(true);
    }
}

void sched_dequeue(TaskControlBlock* task)
{
    RunQueue* rq = rq_for_cpu(task->cpu_id);
    LockGuard guard(rq->lock());

    if (!task->sched_class) {
        task->sched_class = &g_sched_class_o1;
    }
    task->sched_class->dequeue_task(rq, task);
}

/* ========================================================================
 * schedule() — main scheduling entry point
 * ======================================================================== */

void schedule()
{
    RunQueue* rq = this_rq();
    rq->lock().acquire();

    TaskControlBlock* prev = rq->current();

    if (prev && prev->state == TaskState::Running) {
        prev->state = TaskState::Runnable;
        prev->sched_class->enqueue_task(rq, prev);
    } else if (prev) {
        prev->sched_class->put_prev_task(rq, prev);
    }

    TaskControlBlock* next = pick_next_task(rq);

    if (prev == next) {
        /* We picked the same task. It must be Running again. */
        next->state = TaskState::Running;
        next->sched_class->dequeue_task(rq, next);
        rq->clear_need_resched();
        rq->lock().release();
        return;
    }

    if (next != rq->idle()) {
        next->sched_class->dequeue_task(rq, next);
    }

    next->state = TaskState::Running;
    rq->set_current(next);
    rq->clear_need_resched();

    /* Switch address space (satp) if the new task has a different mm.
     * Kernel threads (mm == nullptr) borrow the previous task's mm,
     * so no satp switch is needed — this matches Linux's lazy TLB behavior. */
    {
        VmSpace* prev_mm = prev ? prev->mm : nullptr;
        VmSpace* next_mm = next->mm;
        uint32 cpu = static_cast<uint32>(arch::cpu::id());

        if (next_mm && next_mm != prev_mm) {
            /* Switching TO a user process with a different address space.
             * Linux: switch_mm_irqs_off() in arch/riscv/mm/context.c
             * sets satp and flushes TLB. */
            arch::mmu::set_page_table(next_mm->root_pa);
            arch::mmu::flush_tlb_all();
            next_mm->cpu_mask.fetch_or(1ULL << cpu, __ATOMIC_RELAXED);

            /* Critical: update TrapFrame's kernel_satp so that trap_vector.S
             * restores the correct page table on next trap entry.
             * Without this, a process migrated to a new CPU would have its
             * trap entry use a stale satp from when trapframe_init_user()
             * was called, pointing to whatever page table was active then
             * on the ORIGINAL CPU. */
            if (next->trapframe) {
                next->trapframe->kernel_satp = arch::mmu::read_satp();
            }
        }

        if (prev_mm && prev_mm != next_mm) {
            /* Leaving prev's address space — clear our bit */
            prev_mm->cpu_mask.fetch_and(~(1ULL << cpu), __ATOMIC_RELAXED);
        }
    }

    /* FPU lazy save/restore.
     * Save prev's FP registers only if they were modified (FS=Dirty).
     * Restore next's FP state for user tasks; disable FPU for kthreads. */
    if (arch::fpu_state_dirty(arch::fpu_get_fs())) {
        fpu_save(&prev->fpstate);
    }
    if (next->mm != nullptr) {
        arch::fpu_set_fs(arch::kSstatusFS_Clean);
        fpu_restore(&next->fpstate);
    } else {
        arch::fpu_set_fs(arch::kSstatusFS_Off);
    }

    arch::context_switch(&prev->context, &next->context);

    rq->lock().release();
}

/* ========================================================================
 * sched_tick() — called from timer interrupt (MI trap layer)
 * ======================================================================== */

void sched_tick()
{
    RunQueue* rq = this_rq();
    {
        LockGuard guard(rq->lock());
        TaskControlBlock* curr = rq->current();
        if (!curr) return;
        curr->sched_class->task_tick(rq, curr);
    }

    /* Periodic load balancing — runs without holding rq lock */
    sched_balance();
}

/* ========================================================================
 * sched_check_preempt() — called from trap return path
 *
 * Only preempts if:
 *   1. need_resched flag is set (a higher-priority task is ready)
 *   2. preempt_count == 0 (no spinlocks held, safe to context switch)
 * ======================================================================== */

void sched_check_preempt()
{
    RunQueue* rq = this_rq();
    if (!rq->need_resched()) return;

    TaskControlBlock* curr = current_task();
    if (curr && curr->preempt_count > 0) {
        /* Cannot preempt — caller is in a critical section.
         * The preemption will fire when the last lock is released. */
        return;
    }
    schedule();
}

/* ========================================================================
 * sched_yield() — voluntary yield
 * ======================================================================== */

void sched_yield()
{
    RunQueue* rq = this_rq();
    {
        LockGuard guard(rq->lock());
        TaskControlBlock* curr = rq->current();
        if (curr && curr != rq->idle()) {
            curr->sched_class->yield_task(rq, curr);
            rq->set_need_resched(true);
        }
    }
    schedule();
}

/* ========================================================================
 * sched_init() — BSP initialization
 * ======================================================================== */

void sched_init()
{
    for (int i = 0; i < kMaxCpus; i++) {
        RunQueue* rq = &g_rq[i];
        rq->init(static_cast<uint32>(i));

        g_sched_class_o1.init_rq(rq);
        g_sched_class_idle.init_rq(rq);
    }

    g_sched_class_head = &g_sched_class_o1;

    uint64 bsp_cpu = arch::cpu::id();
    uint8 bsp_cpu8 = static_cast<uint8>(bsp_cpu);

    TaskControlBlock* idle0 = alloc_task(idle_name_for_cpu(static_cast<uint32>(bsp_cpu)),
                                         kIdlePriority,
                                         TF_KTHREAD | TF_IDLE, bsp_cpu8);
    if (!idle0) kernel_panic("sched_init: failed to create idle/bsp");

    idle0->pid = 0;
    idle0->tgid = 0;
    idle0->sched_class = &g_sched_class_idle;
    idle0->sched_entity = nullptr;

    uint64 stack_top = idle0->kstack_va + kKernelStackSize
                       - sizeof(arch::TrapFrame);
    idle0->context = {};
    idle0->context.ra = reinterpret_cast<uint64>(kthread_entry_trampoline);
    idle0->context.sp = stack_top;
    idle0->context.s[0] = reinterpret_cast<uint64>(idle_thread_func);
    idle0->context.s[1] = 0;

    g_rq[bsp_cpu].set_idle(idle0);

    TaskControlBlock* bsp_task = alloc_task("kernel_main", 0, TF_KTHREAD, bsp_cpu8);
    if (!bsp_task) kernel_panic("sched_init: failed to create bsp_task");

    bsp_task->pid = -1;
    bsp_task->tgid = -1;
    bsp_task->state = TaskState::Running;

    g_rq[bsp_cpu].set_current(bsp_task);
}

/* ========================================================================
 * sched_init_ap() — AP per-CPU initialization
 * ======================================================================== */

void sched_init_ap()
{
    uint64 cpu = arch::cpu::id();

    const char* name = idle_name_for_cpu(static_cast<uint32>(cpu));

    TaskControlBlock* idle = alloc_task(name, kIdlePriority,
                                        TF_KTHREAD | TF_IDLE,
                                        static_cast<uint8>(cpu));
    if (!idle) kernel_panic("sched_init_ap: failed to create idle");

    idle->pid = 0;
    idle->tgid = 0;
    idle->sched_class = &g_sched_class_idle;
    idle->sched_entity = nullptr;

    uint64 stack_top = idle->kstack_va + kKernelStackSize
                       - sizeof(arch::TrapFrame);
    idle->context = {};
    idle->context.ra = reinterpret_cast<uint64>(kthread_entry_trampoline);
    idle->context.sp = stack_top;
    idle->context.s[0] = reinterpret_cast<uint64>(idle_thread_func);
    idle->context.s[1] = 0;

    g_rq[cpu].set_idle(idle);

    TaskControlBlock* ap_task = alloc_task("ap_boot", 0, TF_KTHREAD,
                                          static_cast<uint8>(cpu));
    if (!ap_task) kernel_panic("sched_init_ap: failed to create ap_task");

    ap_task->pid = -1;
    ap_task->tgid = -1;
    ap_task->state = TaskState::Running;

    g_rq[cpu].set_current(ap_task);
}

/* ========================================================================
 * sched_nr_running() — runnable task count for a CPU
 * ======================================================================== */

uint32 sched_nr_running(uint32 cpu_id)
{
    if (cpu_id >= kMaxCpus) return 0;
    return g_rq[cpu_id].o1().nr_running();
}

/* ========================================================================
 * sched_migrate_task() — move a task between CPUs
 *
 * Locks are acquired in cpu_id order to prevent ABBA deadlock.
 * The task must be Runnable (in a runqueue) and not currently running.
 * ======================================================================== */

int sched_migrate_task(TaskControlBlock* task, uint8 target_cpu)
{
    if (!task || target_cpu >= kMaxCpus) return -22;  /* -EINVAL */

    uint8 src_cpu = task->cpu_id;
    if (src_cpu == target_cpu) return 0;  /* already there */

    /* Cannot migrate idle or currently-running tasks */
    if (task->flags & TF_IDLE) return -22;

    RunQueue* src_rq = rq_for_cpu(src_cpu);
    RunQueue* dst_rq = rq_for_cpu(target_cpu);

    /* Ordered lock acquisition: always lock lower cpu_id first */
    if (src_cpu < target_cpu) {
        src_rq->lock().acquire();
        dst_rq->lock().acquire();
    } else {
        dst_rq->lock().acquire();
        src_rq->lock().acquire();
    }

    int ret = -22;

    /* Double-check: task must not be current on either CPU */
    if (task != src_rq->current() && task->state == TaskState::Runnable) {
        /* Dequeue from source */
        task->sched_class->dequeue_task(src_rq, task);

        /* Update cpu_id and enqueue on destination */
        task->cpu_id = target_cpu;
        task->sched_class->enqueue_task(dst_rq, task);

        /* Signal target CPU to reschedule */
        dst_rq->set_need_resched(true);
        ret = 0;
    }

    /* Release in reverse order */
    if (src_cpu < target_cpu) {
        dst_rq->lock().release();
        src_rq->lock().release();
    } else {
        src_rq->lock().release();
        dst_rq->lock().release();
    }

    /* If migration succeeded, send reschedule IPI to target */
    if (ret == 0) {
        smp_send_reschedule(target_cpu);
    }

    return ret;
}

/* ========================================================================
 * sched_balance() — periodic load balancer (pull model)
 *
 * Called from sched_tick() context. Looks at all other CPUs and if any
 * has 2+ more runnable tasks than the local CPU, pulls one task.
 * This is a simplified Linux-style load_balance().
 * ======================================================================== */

void sched_balance()
{
    uint32 this_cpu = static_cast<uint32>(arch::cpu::id());
    uint32 local_load = g_rq[this_cpu].o1().nr_running();

    /* Only balance if we're idle or lightly loaded */
    if (local_load > 1) return;

    uint32 busiest_cpu = this_cpu;
    uint32 busiest_load = local_load;

    /* Find the busiest CPU */
    for (uint32 cpu = 0; cpu < kMaxCpus; cpu++) {
        if (cpu == this_cpu) continue;
        uint32 load = g_rq[cpu].o1().nr_running();
        if (load > busiest_load) {
            busiest_load = load;
            busiest_cpu = cpu;
        }
    }

    /* Only pull if imbalance is >= 2 */
    if (busiest_cpu == this_cpu || busiest_load < local_load + 2) return;

    /* Try to pull one task from the busiest CPU */
    RunQueue* busy_rq = rq_for_cpu(busiest_cpu);

    /* Lock ordering: lower cpu_id first */
    RunQueue* first = (this_cpu < busiest_cpu)
                      ? &g_rq[this_cpu] : busy_rq;
    RunQueue* second = (this_cpu < busiest_cpu)
                       ? busy_rq : &g_rq[this_cpu];

    first->lock().acquire();
    second->lock().acquire();

    /* Re-check after acquiring locks */
    TaskControlBlock* victim = busy_rq->o1().pick_next();
    if (victim && victim != busy_rq->current()
        && !(victim->flags & TF_IDLE)) {
        victim->sched_class->dequeue_task(busy_rq, victim);
        victim->cpu_id = static_cast<uint8>(this_cpu);
        victim->sched_class->enqueue_task(&g_rq[this_cpu], victim);
        g_rq[this_cpu].set_need_resched(true);
    }

    second->lock().release();
    first->lock().release();
}
