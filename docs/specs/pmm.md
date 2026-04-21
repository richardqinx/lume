# 物理内存管理器 (Physical Memory Manager)

## 1. 目标 (Objective)

为 LumeOS 提供对物理内存页帧（Frame）的分配与回收服务。本模块基于伙伴系统（Buddy System）算法管理所有可用物理内存，并引入 Per-CPU 缓存（PCP）机制以降低多核场景下的锁竞争。PMM 是 Slab 分配器和 VMM 的底层基石。

## 2. 前置依赖 (Dependencies)

- **全局初始化契约 (`global_init.md`):** `pmm_init()` 在 `fdt_init()` 之后、`slab_init()` 之前被 BSP 调用。
- **设备树契约 (`fdt.md`):** 依赖 `fdt_early_get_mem_info()` 获取物理内存的基址和大小。
- **并发同步契约 (`spinlock.md`):** 依赖 `Spinlock` 实现对全局伙伴系统的互斥访问。
- **架构抽象契约 (`arch_abstraction.md`):** 依赖 `arch::cpu::id()` 获取当前 CPU 编号以访问 Per-CPU 缓存；依赖 `arch::cpu::intr_off()/intr_on()` 保护 PCP 操作免受中断重入。
- **项目约定 (`00_conventions.md`):** 遵循所有命名、错误处理和 API 设计规范。

## 3. 核心数据结构 (Data Structures)

### 3.1 物理页帧描述符 (`struct Frame`)

为了极致地压缩元数据内存占用，`struct Frame` 采用 `union` 设计，并严格保证 `refcount` 独立于 `union` 之外，以支持 COW。

```cpp
// 定义于 include/lume/frame.h
#include <lume/types.h>
#include <lume/list.h>

class KmemCache; // 前向声明

enum class FrameState : uint8 {
    Free,       // 空闲，位于 Buddy 或 PCP 链表中
    Allocated,  // 已分配给上层（Slab, VMM）
    Slab,       // 作为 Slab 页使用
};

struct Frame {
    uint32 refcount;    // 原子引用计数（独立于 union）
    FrameState state;   // 页帧当前状态
    uint8 order;        // 伙伴系统中的阶数 (0-10 for 4KB-4MB)

    union {
        // 当 state == FrameState::Free 时
        struct {
            list_node free_link; // 用于挂载到 Buddy 或 PCP 的空闲链表
        } free;

        // 当 state == FrameState::Slab 时
        struct {
            KmemCache* cache;   // 指向所属的 Slab 缓存
            uint32 obj_count;   // 已分配对象数量
        } slab;
    };
};
```

### 3.2 Per-CPU 单页缓存 (`struct PerCpuCache`)

每个 CPU 私有的单页帧空闲链表。**访问 PCP 时必须关闭中断**，防止定时器中断处理函数在同一 CPU 上重入 PCP 操作导致链表损坏。

```cpp
// 定义于 mm/pmm.cc (模块私有)
inline constexpr int kPcpHighWatermark = 64;  // PCP 缓存上限
inline constexpr int kPcpBatchSize = 32;      // 每次 refill/drain 的批量大小

struct PerCpuCache {
    list_node free_list; // 单页帧空闲链表头
    uint32 count;        // 当前缓存的页帧数量
};
```

### 3.3 伙伴系统常量

```cpp
// 定义于 include/lume/pmm.h
inline constexpr int kMaxOrder = 11; // 阶数 0..10 → 4KB..4MB
```

## 4. 公共 API (Public APIs)

所有分配函数在失败时返回 `nullptr`。

```cpp
// === 初始化 ===
void pmm_init();  // BSP 调用，从 FDT 发现内存并初始化伙伴系统

// === 单页帧操作 (Fast Path via PCP) ===
Frame* pmm_alloc_frame();       // 分配一个 4KB 页帧
void pmm_free_frame(Frame* f);  // 释放一个 4KB 页帧

// === 多页帧操作 (Slow Path, 直接伙伴系统) ===
Frame* pmm_alloc_frames(uint8 order);         // 分配 2^order 个连续页帧
void pmm_free_frames(Frame* f, uint8 order);  // 释放 2^order 个连续页帧

// === 引用计数操作 (原子, 无锁) ===
void frame_incref(Frame* f);  // 原子递增引用计数
void frame_decref(Frame* f);  // 原子递减，降至 0 时自动释放

// === 地址转换 ===
uint64 frame_to_pa(const Frame* f);   // Frame* → 物理地址
Frame* pa_to_frame(uint64 pa);        // 物理地址 → Frame*
uint64 frame_to_va(const Frame* f);   // Frame* → 内核虚拟地址
```

## 5. 并发与锁契约 (Concurrency & Locks)

- **持有锁:** 模块内部持有一把 `Spinlock` (`g_pmm_lock`)。

- **锁的作用域:** `g_pmm_lock` **仅保护**全局伙伴系统 (`g_free_areas[]`)。

- **PCP 保护机制:** PCP 操作**必须在中断关闭状态下**执行。这不是"无锁"——而是通过关中断防止同一 CPU 上的重入（定时器中断 → IRQ handler → pmm_alloc_frame → 损坏 PCP 链表）。关中断由 `pmm_alloc_frame()`/`pmm_free_frame()` 内部自动管理。

- **加锁慢速路径:**
    - 当 PCP 为空时，`refill_pcp()` 获取 `g_pmm_lock` 从伙伴系统批量取页。
    - 当 PCP 达到 `kPcpHighWatermark` 时，`drain_pcp()` 获取 `g_pmm_lock` 归还半数页帧。
    - `pmm_alloc_frames()` 和 `pmm_free_frames()` 因直接操作伙伴系统，**始终需要**获取 `g_pmm_lock`。

- **原子操作:** `frame_incref()` / `frame_decref()` 使用 `__atomic_fetch_add/sub` + `__ATOMIC_ACQ_REL`。

## 6. 错误路径 (Error Paths)

- **初始化失败:** `pmm_init()` 若无法从 FDT 找到可用内存，或无法为 `frame_map` 分配空间，则 `kernel_panic()`。

- **分配失败:** `pmm_alloc_*()` 在物理内存耗尽时返回 `nullptr`。上层负责处理。

- **释放错误:** `pmm_free_*()` 若接收到 `nullptr`，立即 `kernel_panic()`。

## 7. 状态机 / 时序图 (State Machine / Sequence)

### 7.1 单页分配时序 (Fast & Slow Path)

```
[pmm_alloc_frame() on CPU X]
   │
   ├─> 1. 关闭中断 (防止同 CPU 重入)
   │
   ├─> 2. 获取 pcp = &g_pcp[cpu_id]
   │
   ├─> 3. if (pcp->count > 0) ?
   │       ├── [是 (Fast Path)]
   │       │     ├─ 3.1 从 pcp->free_list 弹出一个 Frame
   │       │     ├─ 3.2 设置 state=Allocated, refcount=1
   │       │     └─ 3.3 恢复中断, return Frame
   │       │
   │       └── [否 (Slow Path)]
   │             ├─ 4.1 LockGuard guard(g_pmm_lock);
   │             ├─ 4.2 refill_pcp(pcp);  // 批量从 Buddy 取 kPcpBatchSize 页
   │             ├─ 4.3 释放锁
   │             └─ 4.4 回到步骤 3 重试
   │
   ▼
[恢复中断, 返回 Frame* 或 nullptr]
```

### 7.2 初始化时序

```
[pmm_init() — BSP 单核期]
   │
   ├─> 1. fdt_early_get_mem_info(&base, &size)
   │      └─ 获取物理内存基址和大小
   │
   ├─> 2. 计算 frame_map 位置 (紧跟 _kernel_end 之后, 页对齐)
   │      └─ frame_map 大小 = num_frames * sizeof(Frame)
   │
   ├─> 3. 清零 frame_map
   │
   ├─> 4. 初始化 Spinlock 和 Buddy 空闲链表头
   │
   ├─> 5. 初始化所有 PCP 链表头
   │
   └─> 6. 将所有空闲页帧 (frame_map 之后) 按最大对齐阶数插入 Buddy
```

### 7.3 写时复制 (COW) 引用计数流程

```
[父进程 fork() 创建子进程]
   │
   ├─> 1. 遍历父进程所有可写 VMA
   │
   ├─> 2. for each VMA:
   │      ├─ 2.1 复制父进程的 PTE 到子进程页表
   │      ├─ 2.2 清除父、子 PTE 的 'Write' 权限位
   │      ├─ 2.3 设置父、子 PTE 的 'COW' 软件标志位
   │      └─ 2.4 frame_incref(pa_to_frame(PTE->paddr));
   │
   ▼
[子进程尝试写入共享页面]
   │
   ├─> 1. 触发 Store Page Fault
   │
   ├─> 2. VMM 陷阱处理:
   │      ├─ 2.1 检查 PTE，确认是合法的 COW Fault
   │      ├─ 2.2 old_frame = pa_to_frame(PTE->paddr)
   │      ├─ 2.3 if (old_frame->refcount == 1) ?
   │      │       ├── [是] 直接恢复 Write 权限，无需拷贝
   │      │       └── [否] 分配新页, 拷贝, 修改 PTE, frame_decref(old)
   │
   ▼
[返回用户态，写操作成功]
```

## 8. 已知缺陷与未来挑战 (Known Weaknesses & Future Challenges)

### 8.1 内存回收

当前 API 在物理内存耗尽时仅返回 `nullptr`，缺乏主动回收机制。未来需引入内存回收器。

### 8.2 frame_map 存储

当前设计假设单一连续 `frame_map` 数组，适用于 QEMU 线性内存。对于多内存区域的真实硬件，需演进为稀疏内存模型。
