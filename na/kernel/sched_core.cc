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
#include <lume/addr.h>
#include <lume/new.h>
#include <lume/kprintf.h>
#include <lume/klog.h>
#include <arch/cpu.h>
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

extern "C" void kthread_entry(void (*entry)(void*), void* arg)
{
    RunQueue* rq = this_rq();
    rq->lock().release();

    arch::cpu::intr_on();

    entry(arg);

    kprintf("[sched] kthread exited\n");
    while (true) {
        arch::cpu::halt_until_interrupt();
    }
}

/* ========================================================================
 * fork_child_entry — called from ret_from_fork assembly
 * ======================================================================== */
extern "C" void userret(arch::TrapFrame* tf);

extern "C" void fork_child_entry(arch::TrapFrame* tf)
{
    RunQueue* rq = this_rq();
    rq->lock().release();

    /* Do NOT enable interrupts here! userret expects them disabled. */

    /* Jump to user space */
    userret(tf);
    
    __builtin_unreachable();
}

/* ========================================================================
 * Helper: create a TCB with a kernel stack
 * ======================================================================== */

static TaskControlBlock* create_tcb(const char* name, uint8 priority,
                                    uint8 flags, uint8 cpu)
{
    auto* task = new TaskControlBlock;
    if (!task) return nullptr;

    task->context = {};

    Page* stack_page = pmm_alloc_pages(1);
    if (!stack_page) {
        delete task;
        return nullptr;
    }
    task->kstack_pa = page_to_pa(stack_page).raw;
    task->kstack_va = pa_to_va(phys_addr(task->kstack_pa)).raw;

    *reinterpret_cast<uint64*>(task->kstack_va) = kStackCanary;

    task->name = name;
    task->priority = priority;
    task->time_slice = priority_to_timeslice(priority);
    task->state = TaskState::Runnable;
    task->cpu_id = cpu;
    task->flags = flags;
    task->exit_code = 0;
    task->parent = nullptr;
    task->mm = nullptr;
    task->trapframe = nullptr;

    task->run_link.init();
    task->all_link.init();
    task->children.init();
    task->sibling.init();
    task->wait_chld.init("wait_chld");

    task->sched_class = &g_sched_class_o1;
    task->sched_entity = &task->run_link;

    return task;
}

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

    arch::context_switch(&prev->context, &next->context);

    rq->lock().release();
}

/* ========================================================================
 * sched_tick() — called from timer interrupt (MI trap layer)
 * ======================================================================== */

void sched_tick()
{
    RunQueue* rq = this_rq();
    LockGuard guard(rq->lock());

    TaskControlBlock* curr = rq->current();
    if (!curr) return;

    curr->sched_class->task_tick(rq, curr);
}

/* ========================================================================
 * sched_check_preempt() — called before returning to user mode
 * ======================================================================== */

void sched_check_preempt()
{
    RunQueue* rq = this_rq();
    if (rq->need_resched()) {
        schedule();
    }
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

    TaskControlBlock* idle0 = create_tcb(idle_name_for_cpu(0), kIdlePriority,
                                         TF_KTHREAD | TF_IDLE, 0);
    if (!idle0) kernel_panic("sched_init: failed to create idle/0");

    idle0->pid = 0;
    idle0->tgid = 0;
    idle0->sched_class = &g_sched_class_idle;
    idle0->sched_entity = nullptr;

    uint64 stack_top = idle0->kstack_va + kKernelStackSize;
    idle0->context = {};
    idle0->context.ra = reinterpret_cast<uint64>(kthread_entry_trampoline);
    idle0->context.sp = stack_top;
    idle0->context.s[0] = reinterpret_cast<uint64>(idle_thread_func);
    idle0->context.s[1] = 0;

    g_rq[0].set_idle(idle0);

    TaskControlBlock* bsp_task = create_tcb("kernel_main", 0, TF_KTHREAD, 0);
    if (!bsp_task) kernel_panic("sched_init: failed to create bsp_task");

    bsp_task->pid = -1;
    bsp_task->tgid = -1;
    bsp_task->state = TaskState::Running;

    g_rq[0].set_current(bsp_task);
}

/* ========================================================================
 * sched_init_ap() — AP per-CPU initialization
 * ======================================================================== */

void sched_init_ap()
{
    uint64 cpu = arch::cpu::id();

    const char* name = idle_name_for_cpu(static_cast<uint32>(cpu));

    TaskControlBlock* idle = create_tcb(name, kIdlePriority,
                                        TF_KTHREAD | TF_IDLE,
                                        static_cast<uint8>(cpu));
    if (!idle) kernel_panic("sched_init_ap: failed to create idle");

    idle->pid = 0;
    idle->tgid = 0;
    idle->sched_class = &g_sched_class_idle;
    idle->sched_entity = nullptr;

    uint64 stack_top = idle->kstack_va + kKernelStackSize;
    idle->context = {};
    idle->context.ra = reinterpret_cast<uint64>(kthread_entry_trampoline);
    idle->context.sp = stack_top;
    idle->context.s[0] = reinterpret_cast<uint64>(idle_thread_func);
    idle->context.s[1] = 0;

    g_rq[cpu].set_idle(idle);

    TaskControlBlock* ap_task = create_tcb("ap_boot", 0, TF_KTHREAD,
                                          static_cast<uint8>(cpu));
    if (!ap_task) kernel_panic("sched_init_ap: failed to create ap_task");

    ap_task->pid = -1;
    ap_task->tgid = -1;
    ap_task->state = TaskState::Running;

    g_rq[cpu].set_current(ap_task);
}
