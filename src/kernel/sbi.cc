#include "common/types.h"

namespace SBI
{
    struct sbiret
    {
        long error;
        long value;
    };

    struct sbiret sbi_call(int ext, int fid, uint64 arg0, uint64 arg1, uint64 arg2)
    {
        struct sbiret ret;
        register uint64 a0 asm("a0") = arg0;
        register uint64 a1 asm("a1") = arg1;
        register uint64 a2 asm("a2") = arg2;
        register uint64 a6 asm("a6") = fid;
        register uint64 a7 asm("a7") = ext;

        asm volatile(
            "ecall"
            : "=r"(a0), "=r"(a1)
            : "r"(a0), "r"(a1), "r"(a2), "r"(a6), "r"(a7)
            : "memory");
        ret.error = a0;
        ret.value = a1;
        return ret;
    }

    void set_timer(uint64 stime_value)
    {
        sbi_call(0x54494D45, 0, stime_value, 0, 0);
    }
}