#include "common/types.h"

namespace Timer{
    uint64 get_time();
    void set_next_trigger();
    void init();

    void tick();
    uint64 get_ticks();
    Spinlock *get_lock();
    void *get_tick_chan();
}