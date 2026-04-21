# 原子操作与内存序 (Atomics & Memory Ordering)

## 1. 目标 (Objective)

为 LumeOS 在 RISC-V 弱内存模型 (RVWMO) 环境下提供一套安全、可控的原子操作库。本模块旨在通过封装 C++ `std::atomic` 风格的接口，强制开发者在进行无锁编程时显式考虑内存序 (Memory Ordering)，以避免因指令重排导致的、难以复现的并发 Bug。

## 2. 前置依赖 (Dependencies)

- **编译器支持：** 依赖 GCC/Clang 的 `__atomic_*` 内建函数。

## 3. 核心设计：`lume::atomic<T>`

### 3.1 问题背景：弱内存模型 (RVWMO)

RISC-V 采用弱内存模型，允许 CPU 和编译器进行激进的指令重排。在无锁数据结构（如 Per-CPU 缓存的无锁链表）中，如果仅使用简单的原子操作而没有指定正确的内存序，可能发生以下灾难：

- **场景：** CPU A 分配一个新节点 `node`，填充其数据 `node->data = val`，然后通过原子交换将其链接到链表头 `head.exchange(node)`。
- **风险：** CPU B 可能先观测到 `head` 指针的更新，但由于指令重排，`node->data` 的写入尚未对 CPU B 可见，导致 CPU B 读取到未初始化的垃圾数据。

`Spinlock` 内部的 `fence` 无法保护这种无锁路径。

### 3.2 解决方案：封装 `std::atomic` 风格接口

LumeOS 将提供 `lume::atomic<T>` 模板类，禁止直接使用 `__atomic_*` 内建函数。

1.  **定义 `memory_order` 枚举：**
    ```cpp
    // in include/lume/atomic.h
    namespace lume {
        enum memory_order {
            relaxed = __ATOMIC_RELAXED,
            consume = __ATOMIC_CONSUME,
            acquire = __ATOMIC_ACQUIRE,
            release = __ATOMIC_RELEASE,
            acq_rel = __ATOMIC_ACQ_REL,
            seq_cst = __ATOMIC_SEQ_CST
        };
    }
    ```

2.  **创建 `lume::atomic<T>` 模板类：**
    ```cpp
    // in include/lume/atomic.h
    namespace lume {
        template <typename T>
        struct atomic {
            T value;

            T load(memory_order order = seq_cst) const {
                return __atomic_load_n(&value, order);
            }

            void store(T desired, memory_order order = seq_cst) {
                __atomic_store_n(&value, desired, order);
            }

            T fetch_add(T arg, memory_order order = seq_cst) {
                return __atomic_fetch_add(&value, arg, order);
            }
            // ... 其他 fetch_*, exchange, compare_exchange_strong 等方法
        };
    }
    ```

3.  **强制使用规范：**
    在 `00_conventions.md` 中明确规定：所有在多核间无锁共享的数据（如 `Frame::refcount`，PCP 链表头指针），其类型**必须**是 `lume::atomic<T>`，严禁使用原生类型或 `volatile`。

    **示例 (PMM):**
    ```cpp
    // in mm/frame.h
    #include <lume/atomic.h>
    struct Frame {
        lume::atomic<uint32_t> refcount;
        // ...
    };
    ```

## 4. 公共 API

`lume::atomic<T>` 的 API 设计将严格对齐 C++ 标准库的 `std::atomic<T>`，降低学习成本。