# 虚拟内存管理器 (Virtual Memory Manager)

## 1. 目标 (Objective)

为 LumeOS 管理虚拟地址空间。本模块分两个阶段实现：

- **Phase 1（本文档重点）：** 
  1. 在 `vmm_init()` 中建立精细化的内核页表（4KB 粒度、精确权限）。
  2. 实现基于 Rbtree 和 Slab 的 VMA (Virtual Memory Area) 区间树以管理用户态内存。
  3. 实现架构无关的按需分页 (Demand Paging) 模拟接口。
- **Phase 2（未来）：** 将 VMM 的按需分页逻辑绑定到真实的 Trap 异常中断系统，并引入进程 (Process/Task) 关联和基于硬件触发的缺页异常处理。

采用 pmap（Physical Map）分层模型：MI 层管理地址空间布局逻辑，MD 层（`arch/riscv/mm/pmap.cc`）封装 SV39 页表硬件操作。

## 2. 前置依赖 (Dependencies)

- **全局初始化契约 (`global_init.md`):** `vmm_init()` 在 `slab_init()` 和 `fdt_unflatten()` 之后、`trap_init()` 之前被 BSP 调用。
- **物理内存契约 (`pmm.md`):** 依赖 `pmm_alloc_frame()` 分配页表页。
- **Slab 分配器契约 (`slab.md`):** Phase 2 依赖 `kmalloc` 创建 VMA 对象。
- **架构抽象契约 (`arch_abstraction.md`):** 依赖 `arch::mmu::set_page_table()`, `arch::mmu::flush_tlb_all()` 切换和刷新页表。
- **链接脚本契约 (`linker_and_entry.md`):** 依赖 `_stext/_etext`, `_srodata/_erodata`, `_sdata/_edata`, `_sbss/_ebss`, `_kernel_end` 确定各段边界。

## 3. 核心数据结构 (Data Structures)

### 3.1 SV39 页表项 (PTE) 格式

```
63       54 53      28 27      19 18      10 9  8 7 6 5 4 3 2 1 0
+---------+----------+----------+----------+----+-+-+-+-+-+-+-+-+
| Reserved|  PPN[2]  |  PPN[1]  |  PPN[0]  |RSW |D|A|G|U|X|W|R|V|
|  (10)   |  (26)    |   (9)    |   (9)    |(2) |1|1|1|1|1|1|1|1|
+---------+----------+----------+----------+----+-+-+-+-+-+-+-+-+
```

权限位常量：

```cpp
namespace pmap {
    inline constexpr uint64 PTE_V = 1 << 0;  // Valid
    inline constexpr uint64 PTE_R = 1 << 1;  // Read
    inline constexpr uint64 PTE_W = 1 << 2;  // Write
    inline constexpr uint64 PTE_X = 1 << 3;  // Execute
    inline constexpr uint64 PTE_U = 1 << 4;  // User-accessible
    inline constexpr uint64 PTE_G = 1 << 5;  // Global
    inline constexpr uint64 PTE_A = 1 << 6;  // Accessed
    inline constexpr uint64 PTE_D = 1 << 7;  // Dirty
}
```

### 3.2 pmap 接口 (MD 层, namespace 函数)

遵循 `00_conventions.md` 的多态策略——pmap 为极热路径，使用 namespace 函数 + 编译期链接。

```cpp
// 定义于 arch/riscv/mm/pmap.h (arch 私有头) 和 mm/pmap.h (MI 接口)
namespace pmap {
    // 分配并初始化一个新的根页表，返回其物理地址。
    // 失败返回 0。
    uint64 create();

    // 销毁一个页表及其所有子页表页。
    void destroy(uint64 root_pa);

    // 建立映射：va -> pa，权限为 perm。
    // 自动分配中间页表页。
    // 返回 0 成功，负错误码失败。
    int map(uint64 root_pa, uint64 va, uint64 pa, uint64 perm);

    // 解除 va 处的映射。
    void unmap(uint64 root_pa, uint64 va);

    // 查询 va 对应的 pa。成功返回 true 并写入 *pa_out。
    bool lookup(uint64 root_pa, uint64 va, uint64* pa_out);

    // 将 root_pa 写入 satp 并刷新 TLB。
    void activate(uint64 root_pa);
}
```

### 3.3 内核地址空间布局

`vmm_init()` 建立的精细内核映射：

```
Virtual Address               Physical Address       Perm   Description
─────────────────────────────────────────────────────────────────────
arch::kVAOffset + 0x80200000  0x80200000             R-X    .text (代码段)
arch::kVAOffset + _srodata    _srodata_pa            R--    .rodata (只读数据)
arch::kVAOffset + _sdata      _sdata_pa              RW-    .data + .bss
arch::kVAOffset + frame_map_pa frame_map_pa          RW-    PMM frame_map 数组
arch::kVAOffset + 0x10000000  0x10000000             RW-    UART MMIO
arch::kVAOffset + 0x0C000000  0x0C000000             RW-    PLIC MMIO
arch::kVAOffset + mem_end     ...                    RW-    剩余物理内存 (到 mem_end)
```

## 4. 公共 API (Public APIs)

### 4.1 Phase 1 API

```cpp
// 初始化内核页表，替代 early_pgdir。
// 1. 分配新根页表
// 2. 按段权限映射内核各段
// 3. 映射 MMIO 区域
// 4. 激活新页表
// 5. 旧的 early_pgdir 恒等映射自动失效
void vmm_init();

// AP 切换到 BSP 建好的内核页表
void vmm_init_ap();
```

### 4.2 Phase 2 API (未来)

```cpp
// 暂为 stub，Phase 2 实现
int vmm_map_user(uint64 root_pa, uint64 va, uint64 len, uint64 perm);
int vmm_unmap_user(uint64 root_pa, uint64 va, uint64 len);
int vmm_handle_page_fault(uint64 root_pa, uint64 fault_addr, uint64 cause);
uint64 vmm_clone(uint64 parent_root_pa);
```

## 5. 并发与锁契约 (Concurrency & Locks)

- **Phase 1:** `vmm_init()` 在 BSP 单核期执行，无需锁。
- **pmap 锁：** 每个根页表关联一把 Spinlock（Phase 2 在 AddressSpace 结构中）。多核操作同一页表必须持有此锁。
- **TLB Shootdown：** Phase 1 仅有内核页表且在单核期建立，无需 shootdown。Phase 2 需实现。

## 6. 错误路径 (Error Paths)

- `pmap::create()` 或 `pmap::map()` 中 `pmm_alloc_frame()` 失败 → `kernel_panic()`（内核页表映射失败不可恢复）。
- `vmm_init()` 中任何映射步骤失败 → `kernel_panic()`。

## 7. 状态机 / 时序图 (State Machine / Sequence)

### 7.1 vmm_init 时序

```
[kernel_main on BSP, after slab_init + fdt_unflatten]
   │
   ├─> 1. root_pa = pmap::create()  // 分配新根页表
   │
   ├─> 2. 映射内核 .text 段 (RX)
   │      for (pa = _stext_pa; pa < _etext_pa; pa += PAGE_SIZE)
   │          pmap::map(root_pa, pa + arch::kVAOffset, pa, PTE_R|PTE_X|PTE_G)
   │
   ├─> 3. 映射 .rodata 段 (R-)
   ├─> 4. 映射 .data + .bss 段 (RW)
   ├─> 5. 映射 frame_map 区域 (RW)
   ├─> 6. 映射剩余物理内存 (RW)
   ├─> 7. 映射 MMIO: UART 0x10000000, PLIC 0x0C000000 (RW)
   │
   ├─> 8. pmap::activate(root_pa)  // 写 satp, sfence.vma
   │      └─ 此刻 early_pgdir 的恒等映射失效
   │      └─ 代码继续执行（因为高半区映射已建立）
   │
   └─> 9. 保存 root_pa 到全局变量 g_kernel_pgtbl
```
