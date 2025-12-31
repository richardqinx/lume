#include "common/types.h"
#include "kernel/riscv.h"
#include "drivers/plic.h"

// QEMU Virt PLIC address constants
constexpr uint64 PLIC_BASE = 0x0c000000L;
constexpr uint64 PLIC_PRIORITY = PLIC_BASE + 0x0;
constexpr uint64 PLIC_PENDING = PLIC_BASE + 0x1000;

// S-Mode interrupt enable register: each Hart occupies 0x100 bytes
// Context 1 is Hart 0 S-Mode, Context 3 is Hart 1 S-Mode...
inline uint64 PLIC_SENABLE(int hart)
{
    return PLIC_BASE + 0x2080 + static_cast<uint64>(hart) * 0x100;
}

// S-Mode priority threshold and claim register: 0x2000 bytes per Hart
inline uint64 PLIC_STHRESHOLD(int hart)
{
    return PLIC_BASE + 0x201000 + static_cast<uint64>(hart) * 0x2000;
}

inline uint64 PLIC_SCLAIM(int hart)
{
    return PLIC_BASE + 0x201004 + static_cast<uint64>(hart) * 0x2000;
}

namespace PILC
{
    void init()
    {
        *reinterpret_cast<uint32 *>(PLIC_PRIORITY + 10 * 4) = 1; // UART
        *reinterpret_cast<uint32 *>(PLIC_PRIORITY + 1 * 4) = 1; // VirtIO 0
    }

    void inithart()
    {
        int hart = static_cast<int>(r_tp()); // 获取当前 hartid

        // Enable UART and VirtIO interrupts for the current Hart's S-Mode
        // Set bit 10 and bit 1 in the register bitmap
        *reinterpret_cast<uint32 *>(PLIC_SENABLE(hart)) = (1 << 10) | (1 << 1);

        // Set the current Hart's S-Mode priority threshold to 0
        // Only interrupts with a priority higher than this threshold will be delivered
        *reinterpret_cast<uint32 *>(PLIC_STHRESHOLD(hart)) = 0;
    }

    int claim()
    {
        int hart = static_cast<int>(r_tp());
        return *reinterpret_cast<uint32 *>(PLIC_SCLAIM(hart));
    }

    void complete(int irq)
    {
        int hart = static_cast<int>(r_tp());
        *reinterpret_cast<uint32 *>(PLIC_SCLAIM(hart)) = static_cast<uint32>(irq);
    }
} // namespace PILC
