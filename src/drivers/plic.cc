#include "common/types.h"
#include "kernel/riscv.h"
#include "drivers/plic.h"
#include "drivers/uart.h"

// Base Constants
constexpr uint64 PLIC_BASE = 0x0c000000L;
constexpr uint64 PLIC_PRIORITY = PLIC_BASE + 0x0;
constexpr uint64 PLIC_PENDING = PLIC_BASE + 0x1000;

// Helper Macros to calculate addresses
#define PLIC_SENABLE_ADDR(hart) (PLIC_BASE + 0x2080 + (hart) * 0x100)
#define PLIC_STHRESHOLD_ADDR(hart) (PLIC_BASE + 0x201000 + (hart) * 0x2000)
#define PLIC_SCLAIM_ADDR(hart) (PLIC_BASE + 0x201004 + (hart) * 0x2000)

// Helper for Volatile Access
static inline volatile uint32 *REG32(uint64 addr)
{
    return reinterpret_cast<volatile uint32 *>(addr);
}

namespace PLIC
{
    void init()
    {
        // Set Priority for UART (IRQ 10) and VirtIO (IRQ 1)
        // Must use volatile write
        *REG32(PLIC_PRIORITY + 10 * 4) = 1;
        for (int i = 1; i <= 8; i++)
        {
            *REG32(PLIC_PRIORITY + i * 4) = 1;
        }
    }

    void inithart()
    {
        int hart = static_cast<int>(r_tp());

        // Enable UART(10) and VirtIO(1) for this Hart (S-Mode)
        *REG32(PLIC_SENABLE_ADDR(hart)) = (1 << 10) | 0x1FE;

        // Set Priority Threshold to 0 (Allow all)
        *REG32(PLIC_STHRESHOLD_ADDR(hart)) = 0;

        Drivers::uart_puts("[PLIC] Hart Init Done.\n");
    }

    int claim()
    {
        int hart = static_cast<int>(r_tp());
        return *REG32(PLIC_SCLAIM_ADDR(hart));
    }

    void complete(int irq)
    {
        int hart = static_cast<int>(r_tp());
        *REG32(PLIC_SCLAIM_ADDR(hart)) = static_cast<uint32>(irq);
    }
}