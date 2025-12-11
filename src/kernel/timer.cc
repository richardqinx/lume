#include "common/types.h"
#include "kernel/timer.h"

#define CLINT_BASE 0x2000000L
#define CLINT_MTIMECMP(hartid) (CLINT_BASE + 0x4000 + 8 * (hartid))
#define CLINT_MTIME (CLINT_BASE + 0xBFF8)

#define INTERVAL 1000000

namespace Timer{
    uint64 get_time(){
        return *(volatile uint64*)CLINT_MTIME;
    }

    void set_next_trigger(){
        uint64 mtime = get_time();

        *(volatile uint64 *)CLINT_MTIMECMP(0) = mtime + INTERVAL;
    }

    void init(){
        set_next_trigger();
        uint64 sie;
        asm volatile("csrr %0, sie" : "=r"(sie));
        sie |= (1L << 5);
        asm volatile("csrw sie, %0" : : "r"(sie));
    }
}