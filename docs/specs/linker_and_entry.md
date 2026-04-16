# 链接器与引导入口 (Linker & Entry)

## 1. 目标 (Objective)

定义 LumeOS 在 RISC-V 64 架构上的早期内存布局与汇编启动序列。负责兼容多种 Bootloader（OpenSBI、GRUB、U-Boot），建立高半区内核（Higher-Half Kernel）映射，初始化早期 C++ 运行环境（BSS、GP 寄存器、全局构造函数），并安全地将各个 CPU 同步导入虚拟地址空间的 `kernel_main`。

## 2. 前置依赖 (Dependencies)

- **引导协议契约 (Boot Protocol)：** 为了同时支持 OpenSBI（直接跳转偏移 0）和 GRUB/U-Boot（解析元数据后引导），LumeOS 采用 **RISC-V Linux Boot Protocol**。内核文件起始处必须包含标准的 64 字节 Image Header。

- **寄存器传参契约：** 无论哪种引导器，在跳转至内核执行的第一条指令时，必须保证 `a0` = 当前 CPU ID (Hart ID)，`a1` = FDT (Device Tree) 的物理基址。

- **编译模型契约：** 内核必须使用 `-mcmodel=medany` 编译，以支持基于 PC 的相对寻址，确保在 MMU 开启前后代码均能正确执行。

- **硬件 MMU 契约：** 目标硬件必须支持 RISC-V SV39 分页模式。


## 3. 核心数据结构与内存布局 (Data Structures & Memory Map)

### 3.1 虚拟与物理地址基址

- **物理加载基址 (Physical Base)：** `0x80200000` (跳过低地址的 OpenSBI 固件区，对齐 2MB 以支持大页映射)。

- **内核虚拟基址 (Virtual Base)：** `0xFFFFFFC080200000` (SV39 地址空间顶部，硬编码偏移量 `PAGE_OFFSET = 0xFFFFFFC000000000`)。

- **虚拟-物理偏移常量：** `KERNEL_VA_OFFSET = 0xFFFFFFC000000000`，用于虚拟/物理地址互转：`VA = PA + KERNEL_VA_OFFSET`，`PA = VA - KERNEL_VA_OFFSET`。


### 3.2 链接脚本段分布 (`linker.ld`)

必须在所有代码之前放置 `.head.text` 段，以确保 Image Header 绝对位于二进制文件的第 0 字节处。所有段强制 4KB 对齐：

```
+-----------------------+ 0xFFFFFFC080200000 (Virtual) / 0x80200000 (Physical)
|  .head.text (镜像头)    | -> 严格位于内核入口 0 字节处，包含 Linux Boot Header
+-----------------------+
|  .text (执行代码)       | -> ALIGN(4096), 权限: RX
+-----------------------+
|  .rodata (只读数据)     | -> ALIGN(4096), 权限: R-
|  (含 __init_array)     | -> 全局构造函数指针表
+-----------------------+
|  .data (已初始化数据)   | -> ALIGN(4096), 权限: RW
|  (含 __global_pointer$)| -> 位于 .sdata 附近，用于优化全局变量访问
|  (含 early_pgdir)      | -> 4KB 静态早期页表
+-----------------------+
|  .bss (未初始化数据)    | -> ALIGN(4096), 权限: RW
+-----------------------+
|  boot_stack (早期栈)    | -> ALIGN(4096), 为每个 CPU 预留 8KB 栈空间
+-----------------------+
```

**链接脚本必须导出的符号：**

| 符号名 | 含义 |
|--------|------|
| `_start` | 内核入口点（Image Header 首字节） |
| `_stext` / `_etext` | .text 段边界 |
| `_srodata` / `_erodata` | .rodata 段边界 |
| `_sdata` / `_edata` | .data 段边界 |
| `_sbss` / `_ebss` | .bss 段边界（用于启动清零） |
| `__global_pointer$` | GP 寄存器锚点 |
| `__init_array_start` / `__init_array_end` | C++ 全局构造函数表边界 |
| `_kernel_end` | 内核镜像结束地址（PMM 初始化起点） |

### 3.3 早期页表 (Early Page Table)

- **`early_pgdir`:** 一块静态分配的 4KB `.data` 内存，用作初始顶级页表 (Root Page Table)。

- 内含两个 1GB 的超级大页（Giga Page）映射：

    1. **恒等映射 (Identity Map)：** `0x80000000 -> 0x80000000`，保证开启 MMU 瞬间下一条指令能正确取指。

    2. **高半区映射 (Higher-Half Map)：** `0xFFFFFFC080000000 -> 0x80000000`，供后续 C++ 代码正常运行。

- **生命周期：** 此恒等映射为临时性过渡，在 VMM 建立完整页表后必须被撤销。高半区映射将被 VMM 接管并细化为 4KB 粒度的精确权限映射。


## 4. 公共 API 与核心符号 (Public APIs & Symbols)

### 4.1 RISC-V OS Image Header 规范

在 `entry.S` 的最开始（`.head.text` 段），必须按照以下结构手写 64 字节的元数据。
定义参照 Linux `arch/riscv/include/asm/image.h` 中的 `struct riscv_image_header`：

```asm
    .section .head.text, "ax"
    .globl _start
_start:
    /* code0 (u32, offset 0): 可执行跳转指令，OpenSBI 裸启入口 */
    j real_start
    /* code1 (u32, offset 4): 保留 */
    .word 0
    /* text_offset (u64, offset 8): Image 加载偏移 */
    .dword 0x200000
    /* image_size (u64, offset 16): 镜像大小，链接后由脚本填充，初期可写 0 */
    .dword 0
    /* flags (u64, offset 24): 内核标志位 (bit 0: 0=LE, 1=BE) */
    .dword 0
    /* version (u32, offset 32): Header 版本 (major << 16 | minor)，当前 0.2 */
    .word 0x0002
    /* res1 (u32, offset 36): 保留 */
    .word 0
    /* res2 (u64, offset 40): 保留 */
    .dword 0
    /* magic (u64, offset 48): RISCV_IMAGE_MAGIC = "RISCV\0\0\0" (LE) */
    .dword 0x5643534952
    /* magic2 (u32, offset 56): RISCV_IMAGE_MAGIC2 = "RSC\x05" (LE) */
    .word 0x05435352
    /* res3 (u32, offset 60): 预留给 PE/COFF 偏移 (UEFI)，目前填 0 */
    .word 0
```

### 4.2 汇编函数签名

```cpp
// 定义于 arch/riscv/boot/entry.S
// _start 中的 `j real_start` 跳转目标，执行早期硬件初始化。
void real_start() __attribute__((noreturn));  // 汇编实现，无 C++ 调用约定

// 定义于 arch/riscv/boot/entry.S 或 kernel/main.cc
// 仅由 CPU 0 调用，遍历 .init_array 执行全局构造函数。
void early_cpp_init();

// 定义于 kernel/main.cc
// C++ 内核总入口。各 CPU 在开启 MMU 后汇聚于此。
// 参数：cpu_id = 当前 CPU 编号，fdt_paddr = FDT 物理基址。
void kernel_main(uint64 cpu_id, uint64 fdt_paddr) __attribute__((noreturn));
```

## 5. 并发与锁契约 (Concurrency & Locks)

此时 `Spinlock` 尚未初始化，必须使用汇编级的极简同步机制来避免多核访问冲突。

- **本模块持有的锁：** 无高级锁。

- **本模块可能获取的外部锁：** 无。

- **原子同步契约 (SMP Sync)：**

    1. 在 `.data` 段定义一个全局标志 `uint32 boot_sync_flag = 0;`。

    2. 只有 **CPU 0** (或 `a0` 读取到的第一个 CPU) 作为主核心 (BSP)，获准执行 BSS 清零、早期页表填充等破坏性操作。

    3. **副核心 (AP, Application Processors)** 必须使用原子加载指令在汇编层盲等 `boot_sync_flag` 变为 1。具体实现为 `lw` + 循环比较（不需要 `amoswap`，因为只有 BSP 写入，AP 只读）。

    4. BSP 完成 `early_pgdir` 写入并唤醒 AP 前，必须执行 `fence rw, rw` 以保证所有先前的内存写入对其他 CPU 可见，随后使用 `fence.i` 刷新指令缓存（如有需要），最后将 `boot_sync_flag` 设为 1。


## 6. 错误路径 (Error Paths)

在早期的裸机启动阶段，内核没有任何错误恢复能力。

- **检测点：** 所有 CPU 在 `real_start` 入口处可选地检查 `misa` 或 `marchid` 判断基本硬件兼容性（如 64 位检查）。

- **失败行为：** 立即关闭本 CPU 的中断使能（`csrc sstatus, SSTATUS_SIE`），进入 `wfi` 死循环。无串口输出（此时 UART 尚未初始化）。

- **无回滚：** 早期启动无任何资源可回收，失败即死。


## 7. 状态机 / 时序图 (State Machine / Sequence)

以下描述了从底层固件直到进入 `kernel_main` 的全流程：

```
[引导分流]
  ├──> OpenSBI 裸启: 直接跳转到内存基址 (0x80200000)
  │      └─ 命中 _start 处的第一条指令 `j real_start`
  │
  └──> GRUB / U-Boot 引导: 解析位于 0x80200000 处的 64 字节 Header
         ├─ 验证 magic ("RISCV\0\0\0") 与 magic2 ("RSC\x05")
         ├─ 验证 text_offset
         └─ 跳转到 0x80200000 (此时 a0=cpu_id, a1=fdt_paddr)
                └─ 同样命中 _start 处的第一条指令 `j real_start`

      │ (汇聚点)
      ▼
[real_start]
  │
  ├─> 1. 设置 gp 寄存器 (la gp, __global_pointer$)
  │   // 极其关键：medany 模型下访问全局变量依赖此寄存器
  │
  ├─> 2. 设置早期内核栈 (la sp, boot_stack + (cpu_id + 1) * 8192)
  │
  ├─> 3. 判断是否为主核心 (CPU 0)?
  │       ├── [是 (BSP)]
  │       │     ├─ 3.1 循环清理 BSS 段 (_sbss 至 _ebss 填 0)
  │       │     ├─ 3.2 填充 early_pgdir (建立恒等映射与高半区映射)
  │       │     ├─ 3.3 fence rw, rw (确保内存修改对其他 CPU 可见)
  │       │     └─ 3.4 释放副核心 (boot_sync_flag = 1)
  │       │
  │       └── [否 (AP)]
  │             └─ 3.1 汇编级自旋等待，直到 boot_sync_flag == 1
  │
  ├─> 4. 高半区蹦床 (Higher-Half Trampoline - 所有 CPU 执行)
  │     ├─ 4.1 将 early_pgdir 物理地址写入 satp 寄存器 (MODE=SV39)
  │     ├─ 4.2 执行 sfence.vma 刷新 TLB
  │     ├─ 4.3 计算 kernel_main 的高半区虚拟地址
  │     └─ 4.4 jr 绝对跳转至虚拟地址，彻底抛弃低位物理 PC
  │
  ▼
[进入虚拟世界: call early_cpp_init] (仅 BSP 执行)
  │
  └─> 遍历 __init_array_start 到 __init_array_end
      依次调用全局构造函数，完成 C++ early runtime setup
  │
  ▼
[跳转至 C++ 逻辑: call kernel_main(a0, a1)] (所有 CPU 汇合)
```