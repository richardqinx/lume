# 全局初始化序列 (Global Initialization)

## 1. 目标 (Objective)

统筹 LumeOS 从汇编跃迁至 C++ 后的全局初始化流程。定义子系统间的严格启动顺序、全局对象的生命周期管理范式、以及 BSP/AP 的两阶段同步协议。

## 2. 前置依赖 (Dependencies)

- **汇编环境契约：** 依赖 `linker_and_entry.md` 保证的执行环境：BSS 段已被清零、高半区虚拟内存（`early_pgdir`）已映射、`tp` 寄存器已保存当前 CPU ID、`gp` 寄存器已就绪。注意：`early_cpp_init()` 已在 `entry.S` 中由 BSP 调用完毕（在 `kernel_main` 之前），不在本模块的管辖范围内。

- **全局基础契约：** 依赖 `00_conventions.md` 中禁用了 C++ 异常与 RTTI 的环境。

- **并发同步契约：** 依赖 `spinlock.md` 提供的 `Spinlock`（但在 BSP 独占期不使用）。


## 3. 核心数据结构与生命周期范式 (Data Structures & Lifecycle)

在内核早期，物理内存管理 (PMM) 和字节级分配器 (Slab) 尚未就绪，传统的 `new` 和隐式的全局构造函数极易引发缺页崩溃或顺序未定义行为。

### 3.1 显式生命周期模型 (Placement New 范式)

对于所有复杂的内核全局单例（如 `PhysicalMemoryManager`, `Scheduler`），**严禁**直接定义为全局变量依赖 `.init_array` 隐式构造。必须采用以下静态缓冲区分配 + 显式 Placement New 的范式：

```cpp
// 示例：kernel/mm/pmm_global.cc

// Placement new 声明（freestanding 环境无 <new> 头文件，自行提供）
// 定义于 include/lume/new.h
inline void* operator new(size_t, void* ptr) noexcept { return ptr; }
inline void operator delete(void*, void*) noexcept {}

// 1. 在 .bss 段静态分配对齐的内存区块，不触发任何构造函数
alignas(PhysicalMemoryManager) uint8 g_pmm_buf[sizeof(PhysicalMemoryManager)];

// 2. 暴露全局指针供外部访问
PhysicalMemoryManager* g_pmm = nullptr;

// 3. 在 kernel_main 的严格时序中被显式调用
void pmm_init(uint64 fdt_paddr) {
    // 使用 Placement New 在预分配的内存上执行构造函数
    g_pmm = new (g_pmm_buf) PhysicalMemoryManager(fdt_paddr);
}
```

**关于 `<new>` 头文件：** 在 `-ffreestanding -nostdlib` 编译环境下，`<new>` 可能不可用或行为不一致。LumeOS 在 `include/lume/new.h` 中自行提供 placement new 声明，不依赖任何标准库头文件。

### 3.2 简单数据结构的按需初始化

对于没有复杂依赖的 Plain Old Data (POD) 或简单锁对象：

- `Spinlock` 等对象直接作为 BSS 段全局变量，由 `entry.S` 清零。随后在所属子系统的 `init()` 方法中调用 `lock.init("name")` 赋予身份。

### 3.3 `.init_array` 的使用边界

`early_cpp_init()` 在 `entry.S` 中遍历 `.init_array`。只有满足以下**全部**条件的全局构造函数才允许出现在此表中：

- 构造函数不依赖任何子系统（PMM、Slab、VMM、Scheduler 均未初始化）。
- 构造函数不分配动态内存。
- 构造函数不获取任何锁。

实际上，应该尽量让 `.init_array` 为空。绝大多数全局对象应走 §3.1 的 Placement New 路径。


## 4. 公共 API (Public APIs)

### 4.1 内核 C++ 唯一入口

```cpp
// 定义于 kernel/main.cc
// 被 entry.S 中的 real_start 在开启 MMU、调用 early_cpp_init 后跳转
// 所有 CPU 从此入口进入 C++ 世界
// a0 = cpu_id, a1 = fdt_paddr
extern "C" void kernel_main(uint64 cpu_id, uint64 fdt_paddr) __attribute__((noreturn));
```

### 4.2 子系统初始化签名规范

所有子系统的初始化入口必须遵循统一签名，并在 `kernel/main.cc` 内部按图谱依次调用。每个 `xxx_init()` 函数成功时无返回值，失败时直接 `kernel_panic()`：

```cpp
void console_init();              // 1. UART 就绪，此后 kprintf/kernel_panic 可输出
void fdt_init(uint64 fdt_paddr);  // 2. 解析 FDT，构建设备节点表
void pmm_init();                  // 3. 从 FDT 获取内存布局，建立 Buddy 分配器
void slab_init();                 // 4. 建立 kmem_cache，此后 operator new 可用
void vmm_init();                  // 5. 建立精细化内核页表，废弃 early_pgdir
void trap_init();                 // 6. 设置 stvec，注册 IRQ 分发器
void plic_init();                 // 7. 配置 PLIC 中断控制器（阈值、优先级、使能位）
void timer_init();                // 8. 配置定时器中断（调度器时钟源）
void sched_init();                // 9. 构造 BSP 的 Idle Task 和初始就绪队列
```

### 4.3 AP 初始化签名

AP 在 BSP 完成全局初始化后执行，仅限 Per-CPU 私有数据：

```cpp
void vmm_init_ap();               // 切换 satp 至 BSP 建好的内核页表
void trap_init_ap();              // 设置本 CPU 的 stvec
void plic_init_ap();              // 配置本 CPU 在 PLIC 上的 Context 使能
void timer_init_ap();             // 启动本 CPU 的定时器中断
void sched_init_ap();             // 初始化本 CPU 的 O(1) 就绪队列、创建 Idle Task
```

## 5. 并发与锁契约 (Concurrency & Locks)

这是整个内核生命周期中**唯一一段不受自旋锁约束的特殊时期**，必须严格遵循以下阶段隔离：

### 5.1 两阶段同步协议

LumeOS 启动过程中存在**两个独立的同步屏障**，不要混淆：

| 同步点 | 位置 | 变量 | 含义 |
|--------|------|------|------|
| 第一道 | `entry.S` (汇编层) | `boot_sync_flag` | AP 等待 BSP 建立 `early_pgdir`，完成后所有 CPU 齐步进入虚拟地址空间 |
| 第二道 | `kernel_main` (C++ 层) | `ap_boot_sync` | AP 等待 BSP 完成全部子系统初始化，完成后 AP 开始 Per-CPU 初始化 |

### 5.2 绝对单核期 (BSP 独占)

- 在 `kernel_main` 启动初期，AP 卡在第二道屏障 `ap_boot_sync` 处自旋。

- BSP 拥有对全局数据结构的**绝对独占权**。在此期间调用 `pmm_init`、`vmm_init` 等函数时，**无需获取该子系统的 `Spinlock`**（也不应获取，因为锁可能尚未初始化）。

### 5.3 多核唤醒与并发期 (AP 启动)

- BSP 完成所有全局初始化后，通过 `__atomic_store_n(&ap_boot_sync, 1, __ATOMIC_RELEASE)` 唤醒 AP。`RELEASE` 语义保证 AP 读到 `ap_boot_sync == 1` 时，所有全局单例对象必然已构造完毕。

- AP 进入后，**只能执行 Per-CPU 的局部初始化**（如设置自身的 `stvec`、初始化 PLIC Context、创建 Per-CPU Idle Task）。

- 一旦 AP 的 Per-CPU 初始化完成并开启中断，所有子系统对全局数据的访问必须严格遵守 `spinlock.md` 契约。


## 6. 错误路径 (Error Paths)

初始化阶段的错误处理极度苛刻：

- **console_init 之前的 Panic：** 此时 UART 尚未就绪，`kernel_panic()` 无法输出任何信息。唯一行为是关中断 + `wfi` 死循环（静默死亡）。可通过 JTAG/GDB 附加调试。

- **console_init 之后的 Panic：** 可输出 Panic 消息和调用栈信息后死循环。

- 任何子系统的 `init` 方法如果检测到硬件缺失（如 FDT 解析不到内存节点）或关键资源耗尽（Slab 无法建立早期缓存），必须**立即调用 `kernel_panic()`**。

- 此阶段系统尚未具备任务调度与资源回收能力，无后路可退。


## 7. 状态机 / 时序图 (State Machine / Sequence)

### 7.1 全局初始化依赖 DAG 图

`kernel_main` 必须严格按照自顶向下的单向依赖顺序执行，任何逆序调用将导致 `kernel_panic` 或缺页崩溃。

```
                     entry.S (汇编世界)
                          │
                  early_cpp_init()  ← 遍历 .init_array (应尽量为空)
                          │
                  ════════════════
                   kernel_main()
                  ════════════════
                          │
            ┌─────────────┴──────────────┐
            │                            │
       [BSP (cpu_id == 0)]          [AP (cpu_id != 0)]
            │                            │
  1. console_init()                 自旋等待
     └─ UART 就绪                   ap_boot_sync == 1
     └─ 此后 Panic 可输出                │
            │                            │
  2. fdt_init(fdt_paddr)                 │
     └─ 解析 FDT 设备树                  │
            │                            │
  3. pmm_init()                          │
     └─ Buddy 分配器就绪                 │
            │                            │
  4. slab_init()                         │
     └─ operator new 可用                │
            │                            │
  5. vmm_init()                          │
     └─ 完整内核页表就绪                  │
     └─ 废弃 early_pgdir 恒等映射        │
            │                            │
  6. trap_init()                         │
     └─ stvec 挂载 trap_vector           │
            │                            │
  7. plic_init()                         │
     └─ PLIC 中断控制器就绪              │
            │                            │
  8. timer_init()                        │
     └─ 定时器中断就绪                   │
            │                            │
  9. sched_init()                        │
     └─ Idle Task (Task 0) 创建          │
     └─ Per-CPU 就绪队列初始化           │
            │                            │
  ──[RELEASE 屏障]──────────────────>  读到 1
     ap_boot_sync = 1                    │
            │                      1. vmm_init_ap()
            │                      2. trap_init_ap()
            │                      3. plic_init_ap()
            │                      4. timer_init_ap()
            │                      5. sched_init_ap()
            │                            │
            ▼                            ▼
     arch::cpu::intr_on()       arch::cpu::intr_on()
     BSP 变为 Idle Task          AP 变为 Idle Task
     进入调度循环                 进入调度循环
```

**BSP 进入调度的方式：** BSP 在 `sched_init()` 中将自身的执行上下文注册为 CPU 0 的 Idle Task (Task 0)。开启中断后，第一个定时器中断触发调度器接管执行流。不是通过 `sched_yield()` 主动让出，而是被定时器中断被动抢占进入调度循环。