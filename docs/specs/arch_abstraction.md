# 架构抽象层 (Architecture Abstraction)

## 1. 目标 (Objective)

为 LumeOS 的平台无关层（MI）提供统一的底层硬件原语接口。本模块负责将 RISC-V 架构特有的控制状态寄存器 (CSR) 操作、汇编级上下文切换 (Context Switch)、陷阱帧 (TrapFrame) 布局、以及 TLB 刷新机制进行封装。**本项目所有内联汇编 (Inline Assembly) 严格限定于本模块内部，上层模块禁止直接操作硬件寄存器。**

## 2. 前置依赖 (Dependencies)

- **全局类型契约：** 依赖 `include/lume/types.h` 提供的 `uint64` 等标准类型。

- **编译器支持：** 依赖 GCC/Clang 的内联汇编能力 (`__asm__ volatile`)，必须确保不被过度优化（使用 `memory` clobber 建立编译器屏障）。

- **启动序列契约：** `arch::cpu::id()` 依赖 `tp` 寄存器在 `entry.S` 中被正确初始化为当前 CPU 编号（参见 `linker_and_entry.md`）。在 `tp` 初始化之前，禁止调用本模块任何依赖 CPU ID 的函数。


## 3. 核心数据结构 (Data Structures)

### 3.1 上下文切换结构 (`struct Context`)

用于调度器在不同内核流（如不同 Task 或 KThread）之间进行主动切换（Switch）。它只保存 Callee-Saved（被调用者保存）寄存器。

```cpp
// 定义于 arch/riscv/include/arch/context.h
namespace arch {
    struct Context {
        uint64 ra;         // Return Address (返回地址)
        uint64 sp;         // Stack Pointer (栈指针)
        uint64 s[12];      // s0 ~ s11 (Callee-saved 寄存器)
    };
}
```

### 3.2 陷阱帧结构 (`struct TrapFrame`)

用于在发生中断、异常或系统调用时，由硬件与汇编入口 `trap_vector` 协同保存当前 CPU 的执行快照。此结构同时跨越用户态和内核态，必须精确布局。

```cpp
// 定义于 arch/riscv/include/arch/trapframe.h
// 对齐由分配方保证（页对齐或栈对齐），struct 本身不施加 alignas
namespace arch {
    struct TrapFrame {
        /* 内核元数据区 (偏移 0 - 39) */
        uint64 kernel_satp;     // 0:  内核页表地址 (挂载至 satp)
        uint64 kernel_sp;       // 8:  顶层内核栈地址
        uint64 kernel_trap;     // 16: 内核 C++ trap_handler 的绝对地址
        uint64 kernel_cpu_id;   // 24: 当前 CPU 编号 (trap 入口加载至 tp)
        uint64 epc;             // 32: 中断/异常时的指令地址 (sepc)

        /* CSR 备份区 (偏移 40 - 47) */
        uint64 sstatus;         // 40: 中断前的特权状态 (含 SPP, SPIE 位)

        /* 通用寄存器备份区 (偏移 48 - 295) */
        uint64 ra;              // 48
        uint64 sp;              // 56  (用户态的栈指针)
        uint64 gp;              // 64
        uint64 tp;              // 72
        uint64 t[7];            // 80:  t0-t6 (Caller-saved 临时寄存器)
        uint64 s[12];           // 136: s0-s11 (Callee-saved 寄存器)
        uint64 a[8];            // 232: a0-a7 (函数参数/系统调用参数与返回值)
    };
    static_assert(sizeof(TrapFrame) == 296);
}
```

**相比原版的关键修正：**
- **新增 `sstatus` 字段：** 这是陷阱帧中最容易遗漏但最致命的字段。`sstatus` 包含 `SPP`（之前的特权级）和 `SPIE`（之前的中断使能状态）。若不保存/恢复 `sstatus`，`sret` 返回用户态时将无法正确恢复特权级和中断状态。
- **将 `kernel_cpu_id` 移入元数据区：** 它不是通用寄存器的备份，而是内核注入的元数据（trap 入口用来设置 `tp`），不应放在"通用寄存器备份区"中。
- **简化寄存器数组：** 将 `t0_t2[3]` + `t3_t6[4]` 合并为 `t[7]`，将 `s0_s1[2]` + `s2_s11[10]` 合并为 `s[12]`。编译器按偏移访问不受影响，且减少了心智负担。


## 4. 公共 API (Public APIs)

所有接口统一在 `arch` 及其子命名空间下，通过静态内联函数或汇编实现，实现**零运行时代价**。这些操作不会引发常规意义的"错误"（如不会返回 `-ENOMEM`），因此不采用错误码范式。

### 4.1 CPU 控制与状态感知 (`namespace arch::cpu`)

```cpp
namespace arch::cpu {
    // 获取当前 CPU 编号 (从 tp 寄存器中读取)
    // 前置条件：tp 必须已在 entry.S 中初始化
    uint64 id();

    // 开启中断 (设置 sstatus.SIE = 1)
    void intr_on();

    // 关闭中断 (设置 sstatus.SIE = 0)
    void intr_off();

    // 获取当前中断状态 (返回 true 表示中断已开启)
    bool intr_enabled();

    // 使 CPU 进入低功耗睡眠，直到下一个中断到来 (wfi 指令)
    void halt_until_interrupt();

    // 读取硬件单调时钟计数 (rdtime 指令)
    // 返回自系统启动以来的 tick 数（频率由 FDT timebase-frequency 决定）
    uint64 read_time();
}
```

### 4.2 内存管理硬件原语 (`namespace arch::mmu`)

```cpp
namespace arch::mmu {
    // 读取缺页异常发生时的虚拟地址 (从 stval 寄存器读取)
    uint64 get_fault_address();

    // 切换顶级页表
    // 参数：physical_pgdir_addr 为页表的物理地址（非 PPN），
    //       函数内部负责右移 12 位并组装 SV39 模式字段写入 satp
    void set_page_table(uint64 physical_pgdir_addr);

    // 读取当前页表物理地址 (从 satp 提取 PPN 并左移还原为物理地址)
    uint64 get_page_table();

    // 刷新整个 TLB (sfence.vma zero, zero)
    void flush_tlb_all();

    // 刷新特定虚拟地址的 TLB 条目 (sfence.vma vaddr, zero)
    void flush_tlb_page(uint64 vaddr);
}
```

### 4.3 陷阱向量控制 (`namespace arch::trap`)

```cpp
namespace arch::trap {
    // 设置 S-mode 陷阱向量基址 (写入 stvec 寄存器)
    // 参数：handler_addr 为汇编 trap_vector 入口的虚拟地址
    // 模式：Direct（所有异常/中断统一入口）
    void set_vector(uint64 handler_addr);

    // 读取当前陷阱原因 (scause 寄存器)
    uint64 get_cause();

    // 读取陷阱附加信息 (stval 寄存器)
    uint64 get_value();
}
```

### 4.4 上下文切换原语

```cpp
namespace arch {
    // 汇编实现的上下文切换函数。定义于 arch/riscv/swtch.S
    // 语义：将当前 CPU 寄存器保存到 old_ctx，并将 next_ctx 的内容恢复到 CPU
    // 本函数由 C++ 调用，汇编实现，绝对不会失败。
    extern "C" void context_switch(Context* old_ctx, Context* next_ctx);
}
```

## 5. 并发与锁契约 (Concurrency & Locks)

本模块属于内核的绝对最底层，位于 `Spinlock` 模块的下方，因此**不感知、不持有、也不获取任何高级锁。**

- **调用方契约（中断开关）：** 上层模块（如 `Spinlock`）需直接依赖 `arch::cpu::intr_off()` 与 `intr_on()` 来防止单核死锁。

- **内存屏障契约（Memory Barriers）：** `flush_tlb_all` 与 `flush_tlb_page` 的底层 `sfence.vma` 指令本身即为硬件级内存屏障。内联汇编实现中仍须添加编译器屏障（`"memory"` clobber），防止编译器跨越 TLB 刷新点重排内存访问。

- **跨核（SMP）同步警告：** 当前 `flush_tlb_page` 仅执行**本地** `sfence.vma`。在实现基于 IPI (核间中断) 的 TLB Shootdown 前，VMM 须确保同一时间只有一个 CPU 在修改共享的页表映射。未来将在本命名空间中增加 `flush_tlb_page_remote()` 接口。


## 6. 错误路径 (Error Paths)

底层指令级操作无传统错误返回。

- `flush_tlb_page` 对任何地址执行 `sfence.vma` 都不会触发异常（仅使对应 TLB 表项失效）。

- `context_switch` 若传入无效指针（如 nullptr），加载/存储操作将触发 Store/Load Page Fault，由 Phase 2 的 `trap.md` 规定的异常分发层兜底并触发 `Panic`。

- `set_page_table` 传入非法物理地址将导致后续的所有内存访问引发 Page Fault。此类错误属于编程逻辑错误，无法在本层恢复。


## 7. 状态机 / 时序图 (State Machine / Sequence)

### 7.1 上下文切换时序 (`context_switch`)

调度器在选择出新的 `Task` 后，调用此接口的时序如下：

```
[当前 Task A] (执行 sched() 决定放弃 CPU)
   │
   ▼
[调用 arch::context_switch(&TaskA->context, &TaskB->context)]
   │
   ├─> 1. 保存 ra, sp, s0-s11 到 TaskA->context 内存区块中
   ├─> 2. 从 TaskB->context 内存区块中加载 ra, sp, s0-s11 到物理寄存器
   └─> 3. ret (返回到被加载的 ra 地址)
   │
   ▼
[恢复至 Task B] (PC 从 Task B 上次挂起的 sched() 处继续执行)
```

### 7.2 陷阱帧保存/恢复时序 (trap_vector)

```
[用户态正在运行]
   │
   ├─ 中断/异常/ecall 触发
   ▼
[trap_vector (汇编入口, arch/riscv/trap/trap_vector.S)]
   │
   ├─> 1. 交换 sscratch <-> tp (sscratch 预存 TrapFrame 地址)
   ├─> 2. 将 31 个通用寄存器写入 TrapFrame
   ├─> 3. csrr sstatus → TrapFrame.sstatus (保存特权状态)
   ├─> 4. csrr sepc → TrapFrame.epc (保存中断 PC)
   ├─> 5. 加载 kernel_sp, kernel_satp, kernel_cpu_id 到 sp, satp, tp
   ├─> 6. sfence.vma (切换到内核页表后刷新 TLB)
   └─> 7. jalr TrapFrame.kernel_trap (跳转至 C++ trap_handler)
   │
   ▼
[MI 层 trap_handler()] → 分发至 syscall / page fault / IRQ 处理
   │
   ▼
[usertrapret: 恢复用户态]
   │
   ├─> 1. 写回 TrapFrame.epc → sepc
   ├─> 2. 写回 TrapFrame.sstatus → sstatus
   ├─> 3. 切换回用户页表 (satp)
   ├─> 4. 从 TrapFrame 恢复 31 个通用寄存器
   ├─> 5. 交换 sscratch <-> tp (恢复 TrapFrame 地址到 sscratch)
   └─> 6. sret (返回用户态)
```