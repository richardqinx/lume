#include "common/types.h"
#include "kernel/config.h"

namespace SBI
{
    void set_timer(uint64 stime_value);
}

#define INTERVAL 1000000

namespace Timer
{
    uint64 get_time()
    {
        uint64 time;
        asm volatile("rdtime %0" : "=r"(time));
        return time;
    }

    void set_next_trigger()
    {
        SBI::set_timer(get_time() + INTERVAL);
    }

    void init()
    {
        set_next_trigger();

        uint64 sie;
        asm volatile("csrr %0, sie" : "=r"(sie));
        sie |= (1L << 5);
        asm volatile("csrw sie, %0" : : "r"(sie));
    }
}