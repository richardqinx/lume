#include "kernel/spinlock.h"
#include "kernel/riscv.h"
#include "kernel/proc.h"
#include "drivers/uart.h"
#include "common/types.h"

#define NCPU 8

namespace Spinlock
{
    int g_noff[NCPU];

    int g_intena[NCPU];

    int cpuid()
    {
        return r_tp();
    }

    void init(struct spinlock *lk, char* name)
    {
        lk->name = name;
        lk->locked = 0;
        lk->cpu_id = -1;
    }

    void push_off()
    {
        int old = intr_get();
        intr_off();

        int id = cpuid();
        if (g_noff[id] == 0)
        {
            g_intena[id] = old;
        }
        g_noff[id] += 1;
    }

    void pop_off()
    {
        int id = cpuid();
        if (intr_get())
            Drivers::uart_puts("pop_off - interruptible\n");

        if (g_noff[id] < 1)
            Drivers::uart_puts("pop_off - count error\n");

        g_noff[id] -= 1;

        if (g_noff[id] == 0 && g_intena[id])
        {
            intr_on();
        }
    }

    int holding(struct spinlock *lk)
    {
        int r;
        push_off();
        r = (lk->locked && lk->cpu_id == cpuid());
        pop_off();
        return r;
    }

    void acquire(struct spinlock *lk)
    {
        push_off();

        if(holding(lk))
        {
            Drivers::uart_puts("acquire: panic - recursive lock ");
            Drivers::uart_puts(lk->name);
            Drivers::uart_puts("\n");
            while (1)
                ;
        }

        while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
        {
            // 自旋等待
        }

        __sync_synchronize();

        lk->cpu_id = cpuid();
    }

    void release(struct spinlock *lk)
    {
        if (!holding(lk))
        {
            Drivers::uart_puts("release: panic - not holding\n");
            while (1)
                ;
        }

        lk->cpu_id = -1;

        __sync_synchronize();

        __sync_lock_release(&lk->locked);

        pop_off();
    }

} // namespace Spinlock
