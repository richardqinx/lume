# LumeOS 0 号规范 (Project Conventions)

本文档是 LumeOS 全项目的出厂规范。所有后续 spec 文档和代码必须遵守此规范。

---

## 1. 架构总览

### 1.1 分层模型

```
┌─────────────────────────────────────────────────────────┐
│                    User Programs                        │
│               (Busybox, init, shell)                    │
├────────────────────── syscall ABI ──────────────────────┤
│  kernel/syscall   │  kernel/proc   │  kernel/sched      │
│  (系统调用分发)    │  (任务管理)     │  (调度器)          │
├───────────────────┼────────────────┼────────────────────┤
│       fs/         │      mm/       │   kernel/trap      │
│  (VFS + 具体 FS)  │  (PMM/Slab/VMM)│  (MI 异常分发)     │
├───────────────────┴────────────────┴────────────────────┤
│                    drivers/                             │
│          (VirtIO, UART, BlockDevice 实现)                │
├─────────────────────────────────────────────────────────┤
│                   arch/$(ARCH)/                         │
│    (CSR, 上下文切换, pmap, TLB, 中断向量, uaccess)       │
├─────────────────────────────────────────────────────────┤
│                   boot/ + linker.ld                     │
│              (entry.S, 多核同步, 高半区跳转)              │
└─────────────────────────────────────────────────────────┘
```

**核心规则：** 依赖方向严格向下。上层模块可以调用下层接口，反之禁止。
`kernel/`、`fs/`、`mm/` 严禁出现内联汇编或架构特定寄存器操作。

### 1.2 多态策略

| 层级 | 多态方式 | 理由 |
|------|---------|------|
| CPU 核心层 (arch primitives) | Namespace 函数 + 编译期链接 | 零运行时开销，极热路径 |
| 设备抽象层 (BlockDevice 等) | C++ 纯虚类 | 运行时多态，驱动可替换 |
| 跨平台页表 (pmap) | Namespace 函数 + 编译期链接 | 极热路径，每次 page fault |

### 1.3 目录结构

```
lumeOS/
├── include/                # 公共头文件（跨模块可见）
│   ├── lume/               # 内核公共接口命名空间
│   │   ├── types.h         # 基础类型 (uint64, size_t, ssize_t, ...)
│   │   ├── errno.h         # 全局错误码 (-EINVAL, -ENOMEM, ...)
│   │   └── config.h        # 编译期配置 (PAGE_SIZE, NCPU, ...)
│   └── uapi/               # 用户态/内核态共享 (syscall 编号, ioctl)
│
├── arch/riscv/             # 架构相关（MD 层）
│   ├── include/arch/       # arch 私有头文件
│   ├── boot/               # entry.S, trampoline.S
│   ├── mm/                 # pmap 实现 (页表操作)
│   ├── trap/               # 中断向量, 上下文保存/恢复
│   └── uaccess.cc          # copy_from_user / exception table
│
├── mm/                     # 内存管理（MI 层）
│   ├── pmm.cc / pmm.h      # 物理页分配 (Buddy)
│   ├── slab.cc / slab.h    # 字节级分配器
│   └── vmm.cc / vmm.h      # VMA 管理, demand paging
│
├── kernel/                 # 内核核心（MI 层）
│   ├── main.cc             # kernel_main 初始化序列
│   ├── trap/               # MI 异常分发
│   ├── proc/               # TCB, 生命周期, clone/exec/exit
│   ├── sched/              # 调度器
│   ├── sync/               # Spinlock, Mutex, WaitQueue
│   └── syscall/            # syscall 跳转表与处理函数
│
├── fs/                     # 文件系统
│   ├── vfs.cc / vfs.h      # VFS 抽象层, MountTable
│   ├── file.cc / file.h    # File 基类与 FileTable
│   └── fat32/              # FatFs 胶水层
│
├── drivers/                # 设备驱动
│   ├── uart/               # 串口
│   ├── virtio/             # VirtIO Block/Net
│   └── tty/                # TTY + Line Discipline
│
├── lib/                    # 内核通用库
│   ├── kprintf.cc          # 内核格式化输出
│   ├── string.cc           # memcpy, memset, strlen, ...
│   └── rbtree.cc           # 红黑树
│
├── docs/specs/             # 模块 Spec 文档
├── linker.ld               # 链接脚本
└── Makefile                # 构建系统
```

**头文件规则：**
- 跨模块可见的接口 → `include/lume/` 或 `include/uapi/`
- 模块私有头文件 → 与 `.cc` 同目录（如 `mm/pmm.h`）
- `#pragma once` 替代 include guard

---

## 2. 统一术语表 (Ubiquitous Language)

以下术语在代码和文档中必须严格一致，不得混用同义词。

| 概念 | 术语 | 禁止混用 |
|------|------|---------|
| 物理处理器核心 | `CPU` | ~~Hart, core, processor~~ (RISC-V 文档中 Hart 仅在 arch/ 层内部使用) |
| 逻辑调度单元 | `Task` | ~~Process, Thread~~ (对用户态呈现时可说"进程/线程"，内核代码统一用 Task) |
| 任务控制块 | `TaskControlBlock` / `TCB` | ~~Proc, PCB~~ |
| 物理内存页帧 | `Frame` | ~~physical page~~ |
| 虚拟页 | `Page` | 仅在虚拟地址语境使用 |
| 虚拟地址区域 | `VMA` (Virtual Memory Area) | ~~vm_area, segment~~ |
| 页表操作层 | `pmap` | ~~pagetable, mmu~~ |
| 内核地址空间 | `kernel space` | ~~supervisor space~~ (代码中 S-mode 指特权级，不指地址空间) |
| 中断请求号 | `irq` | ~~interrupt number~~ |
| 文件描述符编号 | `fd` | ~~fileno, handle~~ |
| 系统调用编号 | `sysno` | ~~syscall_nr, scall~~ |

---

## 3. 全局错误处理范式

**选定方案：Linux 负错误码（方案 A）。全局死守，不得例外。**

### 3.1 函数返回值约定

```cpp
// 返回 int 的函数：
//   成功 → 0 或正数（如 read 返回字节数）
//   失败 → 负的错误码（-EINVAL, -ENOMEM, -EFAULT, ...）
int vfs_read(File *f, char *buf, size_t n);

// 返回指针的函数（仅当失败原因唯一时允许）：
//   成功 → 有效指针
//   失败 → nullptr
//   适用场景：失败原因显而易见且唯一（如"内存不足"）
Frame *pmm_alloc_frame();

// 返回指针但失败原因可能有多种时 → 禁止返回裸指针。
// 必须改为返回 int 错误码 + 出参：
int task_alloc(TaskControlBlock **out);  // 成功: *out = 有效指针, 返回 0
                                         // 失败: *out 不变, 返回 -ENOMEM / -EINVAL
```

### 3.2 错误码定义

所有错误码定义在 `include/lume/errno.h`，编号严格对齐 Linux `asm-generic/errno-base.h`：

```cpp
#define EPERM   1   // Operation not permitted
#define ENOENT  2   // No such file or directory
#define ENOMEM 12   // Out of memory
#define EFAULT 14   // Bad address
#define EINVAL 22   // Invalid argument
// ...
```

### 3.3 禁止事项

- **禁止** 使用布尔值表示可能有多种失败原因的操作
- **禁止** 使用魔数（如 `-1`）代替命名错误码
- **禁止** 忽略被调用函数的返回值（必须检查或显式 `(void)` 标记）

---

## 4. C++ 命名与格式规范

### 4.1 命名约定

| 元素 | 风格 | 示例 |
|------|------|------|
| 类 / 结构体 | `PascalCase` | `TaskControlBlock`, `Spinlock` |
| 函数 / 方法 | `snake_case` | `pmm_alloc_frame()`, `task.get_pid()` |
| 局部变量 | `snake_case` | `page_count`, `vma_entry` |
| 私有成员变量 | `snake_case` + `_` 后缀 | `lock_`, `state_`, `parent_` |
| 全局变量 | `g_` 前缀 | `g_pmm`, `g_sched` |
| 编译期常量 | `k` 前缀 + `PascalCase` | `kPageSize`, `kMaxHarts` |
| 宏 / 枚举值 | `UPPER_SNAKE` | `PAGE_SIZE`, `RUNNABLE` |
| 命名空间 | `snake_case` | `namespace arch`, `namespace pmap` |
| 抽象接口类 | 直接命名，无前缀 | `BlockDevice`（不用 `IBlockDevice`） |

### 4.2 文件命名

- 源文件：`snake_case.cc`（C++）、`snake_case.S`（汇编）
- 头文件：`snake_case.h`
- 一个 `.h` + 一个 `.cc` 组成一个模块单元，文件名一致

### 4.3 格式（交给工具）

- 缩进、花括号、列宽等由 `.clang-format` 统一管控
- 代码提交前必须通过 `clang-format` 格式化

### 4.4 C++ 使用边界

| 特性 | 允许 | 禁止 |
|------|------|------|
| 类 / 继承 / 虚函数 | ✅ | |
| 模板（简单泛型） | ✅ | |
| RAII (LockGuard) | ✅ | |
| Placement new | ✅ | |
| 异常 (throw/catch) | | ❌ `-fno-exceptions` |
| RTTI (dynamic_cast) | | ❌ `-fno-rtti` |
| STL 容器 | | ❌ 依赖堆分配器 |
| 全局构造函数（隐式） | | ❌ 使用 Placement New |

---

## 5. 并发与锁约定

### 5.1 锁声明要求

每个持有锁的数据结构，必须在头文件注释中声明：
```cpp
// 锁契约：
//   持有: pmm_lock_ (内部自旋锁)
//   可能获取: 无
//   调用方禁止持有: sched_lock (避免反向依赖)
class PhysicalMemoryManager {
    Spinlock pmm_lock_;
    // ...
};
```

### 5.2 全局锁序

各 spec 文档必须声明"本模块持有哪些锁、需要获取哪些外部锁"。
Phase 2 全部完成后，从各 spec 中提取汇总为 `docs/specs/lock_ordering.md` 全局 DAG。

### 5.3 原子操作

- 引用计数（`refcount`）使用 `__atomic_fetch_sub` / `__atomic_fetch_add` + `__ATOMIC_ACQ_REL`
- Spinlock 的 acquire/release 内含隐式 fence，临界区内无需额外屏障
- **禁止** 用裸 `volatile` 替代原子操作

---

## 6. Spec 文档标准模板

后续每份 spec 文档必须包含以下章节：

```markdown
# 模块名称 (Module Name)

## 1. 目标 (Objective)
一句话描述本模块的职责边界。

## 2. 前置依赖 (Dependencies)
列出本模块依赖的其他模块及其接口。

## 3. 核心数据结构 (Data Structures)
结构体定义、内存布局、字段含义。

## 4. 公共 API (Public APIs)
函数签名、参数语义、返回值约定、错误码。

## 5. 并发与锁契约 (Concurrency & Locks)
- 本模块持有的锁
- 本模块可能获取的外部锁
- 调用方的锁限制

## 6. 错误路径 (Error Paths)
每个 API 失败时的副作用（是否回滚已分配资源）。

## 7. 状态机 / 时序图 (State Machine / Sequence)
（如适用）关键流程的状态转换或调用时序。
```

---

## 7. 构建系统架构

### 7.1 工具链

| 项目 | 选择 |
|------|------|
| 构建系统 | GNU Make (非递归模式) |
| 编译器 | `riscv64-*-gcc` / `riscv64-*-g++` |
| C++ 标准 | C++17 (`-std=c++17`) |
| 关键编译选项 | `-ffreestanding -nostdlib -fno-exceptions -fno-rtti -mcmodel=medany` |
| 代码格式化 | `clang-format`（`.clang-format` 配置） |
| 静态分析 | `clang-tidy`（通过 `bear -- make` 生成 `compile_commands.json`） |
| 调试 | QEMU + GDB (`make debug`) |
| 许可证 | GPL-2.0-or-later |
| 源文件头 | 必须包含 SPDX 标识符和版权声明 |

### 7.2 构建模式：非递归 Make + 模块片段

采用**单一顶层 Makefile + 各模块 `module.mk` 片段**的非递归模式，兼顾模块化与依赖正确性。

**目录结构示例：**
```
lumeOS/
├── Makefile              # 顶层：定义规则、变量、include 所有 module.mk
├── arch/riscv/module.mk  # 声明 arch 层源文件
├── mm/module.mk          # 声明内存管理源文件
├── kernel/module.mk      # 声明内核核心源文件
├── fs/module.mk          # 声明文件系统源文件
├── drivers/module.mk     # 声明驱动源文件
├── lib/module.mk         # 声明通用库源文件
└── build/                # 编译产出目录 (out-of-tree)
```

**模块片段 (`module.mk`) 格式：**
```makefile
# mm/module.mk
# 每个模块只声明自己的源文件列表，追加到全局变量

SRCS_CC += mm/pmm.cc mm/slab.cc mm/vmm.cc
SRCS_CC += mm/cow.cc
```

**顶层 Makefile 骨架：**
```makefile
# === 变量定义 ===
ARCH    := riscv
BUILD   := build
TARGET  := $(BUILD)/kernel.elf

# === 包含所有模块片段 ===
SRCS_CC :=
SRCS_S  :=
include arch/$(ARCH)/module.mk
include mm/module.mk
include kernel/module.mk
include fs/module.mk
include drivers/module.mk
include lib/module.mk

# === 统一规则 ===
OBJS := $(patsubst %.cc,$(BUILD)/%.o,$(SRCS_CC)) \
        $(patsubst %.S,$(BUILD)/%.o,$(SRCS_S))

$(TARGET): $(OBJS) linker.ld
	$(LD) -T linker.ld -o $@ $(OBJS)

$(BUILD)/%.o: %.cc
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD)/%.o: %.S
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# 自动依赖追踪
-include $(OBJS:.o=.d)
```

### 7.3 构建规范

- **Out-of-tree 编译：** 所有 `.o` 和 `.d` 文件输出到 `build/` 目录，不污染源码树
- **自动依赖：** 编译时加 `-MMD -MP` 生成 `.d` 依赖文件，增量构建正确追踪头文件变更
- **新增模块流程：** 创建目录 → 创建 `module.mk` 声明源文件 → 在顶层 Makefile 一行 `include` → 完成
- **禁止递归 Make：** 不使用 `$(MAKE) -C subdir`，避免依赖追踪断裂

### 7.4 标准 Make Target

| Target | 含义 |
|--------|------|
| `make` / `make all` | 编译内核 ELF |
| `make run` | QEMU 运行（无 GDB） |
| `make debug` | QEMU 运行 + 等待 GDB 附加 |
| `make clean` | 清理 `build/` 目录 |
| `make fmt` | `clang-format -i` 格式化所有源文件 |
| `make lint` | `clang-tidy` 静态分析 |
| `make test` | QEMU 无头冒烟测试 (Phase 4) |

