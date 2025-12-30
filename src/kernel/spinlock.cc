#include "kernel/spinlock.h"
#include "kernel/riscv.h"
#include "kernel/proc.h"
#include "drivers/uart.h"

extern struct cpu cpus[];

// Get the pointer of the current CPU
// Depends on r_tp() in riscv.h to read the tp register
struct cpu *mycpu()
{
    int id = r_tp();
    return &cpus[id];
}

// Get the current process
// Must be called with interrupts disabled, or read atomically in a safe manner
struct Proc *myproc()
{
    push_off();
    struct cpu *c = mycpu();
    struct Proc *p = c->proc;
    pop_off();
    return p;
}

// Interrupt Depth Management
void push_off(void);
void pop_off(void);

// Spinlock Implementation

void Spinlock::init(const char *lock_name)
{
    name = lock_name;
    locked = 0;
    cpu = nullptr;
}

void Spinlock::acquire()
{
    push_off(); // Disable interrupts: prevent deadlocks (interrupt handler requests a lock that is already held)

    if (holding())
    {
        Drivers::uart_puts("panic: recursive acquire ");
        Drivers::uart_puts(name);
        Drivers::uart_puts("\n");
        while (1)
            ;
    }

    // Atomic Exchange
    // __ATOMIC_ACQUIRE: Ensures that reads and writes after the acquire are not reordered before the acquire
    while (__atomic_exchange_n(&locked, 1, __ATOMIC_ACQUIRE))
    {
        // Busy-wait (Spinning)
        // Optimization: Read-only, no writes, reducing cache coherence traffic
        while (__atomic_load_n(&locked, __ATOMIC_RELAXED) == 1)
        {
            asm volatile("nop"); // RISC-V indicates that the CPU is in a spin state
        }
    }

    // Record holder
    cpu = mycpu();
}

void Spinlock::release()
{
    if (!holding())
    {
        Drivers::uart_puts("panic: release not holding\n");
        while (1)
            ;
    }

    cpu = nullptr;

    // Atomic Store
    // __ATOMIC_RELEASE: Ensures all reads and writes before the Release are completed
    __atomic_store_n(&locked, 0, __ATOMIC_RELEASE);

    pop_off(); // 2. 恢复中断状态
}

// Check if the current CPU holds the lock
bool Spinlock::holding()
{
    // Interrupt checks must be disabled, otherwise a process switch may occur causing CPU fluctuations.
    int r;
    push_off();
    r = (locked && cpu == mycpu());
    pop_off();
    return r;
}


// Mutex Implementation (Sleep Locks)

void Mutex::init(const char *lock_name)
{
    name = lock_name;
    locked = 0;
    pid = 0;
    lk.init("mutex_internal"); // 初始化内部自旋锁
}

void Mutex::acquire()
{
    lk.acquire(); // Acquire the internal lock to protect the locked field

    while (locked)
    {
        // Lock is held, preparing to sleep
        // Atomicity contract of sleep():
        // 1. Mark the current process as SLEEPING
        // 2. Release lk (so others can operate on locked)
        // 3. Switch CPU (context switch)
        // 4. After being woken up, reacquire the lk lock and return
        ProcManager::sleep(this, &lk);
    }

    locked = 1;
    pid = myproc()->pid;

    lk.release();
}

void Mutex::release()
{
    lk.acquire();

    locked = 0;
    pid = 0;

    // Wake up all processes sleeping on this lock (chan = this)
    ProcManager::wakeup(this);

    lk.release();
}

bool Mutex::holding()
{
    lk.acquire(); // Must use a lock when reading to prevent race conditions.
    bool r = locked && (pid == myproc()->pid);
    lk.release();
    return r;
}

// Interrupt Depth Management

void push_off(void)
{
    int old = intr_get();
    intr_off();

    struct cpu *c = mycpu();

    if (c->noff == 0)
        c->intena = old; // 记录最外层的中断状态

    c->noff += 1;
}

void pop_off(void)
{
    struct cpu *c = mycpu();

    if (intr_get())
    {
        Drivers::uart_puts("panic: pop_off - interruptible\n");
        while (1)
            ;
    }
    if (c->noff < 1)
    {
        Drivers::uart_puts("panic: pop_off count\n");
        while (1)
            ;
    }

    c->noff -= 1;

    // An interrupt is only truly enabled when the nesting level returns to zero and the outermost layer allows interrupts.
    if (c->noff == 0 && c->intena)
        intr_on();
}