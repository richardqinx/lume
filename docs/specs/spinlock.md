# 自旋锁与并发同步 (Spinlock & Synchronization)

## 1. 目标 (Objective)

为 LumeOS 提供多核环境下的底层互斥机制。本模块实现基于原子操作的自旋锁（Spinlock）和基于 RAII 范式的局部锁守卫（LockGuard）。同时，严格定义锁操作前后的硬件中断屏蔽策略（避免单核中断死锁）以及底层内存序保证（Memory Ordering）。

## 2. 前置依赖 (Dependencies)

- **全局类型契约：** `include/lume/types.h`。

- **架构原语契约：** 依赖 `arch_abstraction.md` 中的 `arch::cpu::id()`, `arch::cpu::intr_on()`, `arch::cpu::intr_off()`, `arch::cpu::intr_enabled()`。

- **Panic 机制：** 依赖底层的内核崩溃函数 `kernel_panic(const char* msg)`。

- **全局初始化契约：** `g_cpu_sync_states[]` 为 BSS 段全局数组，由 `entry.S` 的 BSS 清零保证初始值为零。`Spinlock` 作为全局对象时，必须通过 `init()` 方法显式初始化（参见 `global_init.md`），不得依赖构造函数。


## 3. 核心数据结构 (Data Structures)

### 3.1 CPU 中断嵌套跟踪器

为了支持锁的嵌套（如持有 `A` 锁时去获取 `B` 锁），必须在每 CPU 维度跟踪锁的深度，确保只有释放**最后一把锁**时，才恢复真实的中断状态。

```cpp
// 定义于 kernel/sync/cpu_state.h
namespace sync {
    struct CpuSyncState {
        int lock_depth;      // 当前 CPU 持有的自旋锁数量 (嵌套深度)
        bool intr_was_on;    // 在获取第一把锁之前，中断是否处于开启状态
    };
    // BSS 段全局数组，由 entry.S 清零初始化
    inline constexpr uint64 kInvalidCpuId = ~0ULL;
    extern CpuSyncState g_cpu_sync_states[kMaxCPUs];
}
```

### 3.2 自旋锁类 (`Spinlock`)

```cpp
// 定义于 kernel/sync/spinlock.h
class Spinlock {
public:
    // 默认构造：locked_ = 0, name_ = "uninit", cpu_id_ = kInvalidCpuId
    // 全局 Spinlock 在 BSS 清零后通过 init() 显式初始化
    Spinlock() = default;

    // 显式初始化（用于全局对象或 Placement New 场景）
    void init(const char* name);

    // 禁用拷贝与移动 (锁对象具有固定的内存地址身份)
    Spinlock(const Spinlock&) = delete;
    Spinlock& operator=(const Spinlock&) = delete;

    void acquire();
    void release();
    bool is_held_by_current_cpu() const;

private:
    uint32 locked_ = 0;                   // 锁状态：0=空闲, 1=占用
    const char* name_ = "uninit";         // 锁名称 (用于 Panic 输出)
    uint64 cpu_id_ = sync::kInvalidCpuId; // 持有者 CPU 编号
};
```

### 3.3 RAII 锁守卫 (`LockGuard`)

```cpp
// 定义于 kernel/sync/spinlock.h
class LockGuard {
public:
    explicit LockGuard(Spinlock& lock) : lock_(lock) {
        lock_.acquire();
    }

    ~LockGuard() {
        lock_.release();
    }

    // 禁用拷贝与移动
    LockGuard(const LockGuard&) = delete;
    LockGuard& operator=(const LockGuard&) = delete;

private:
    Spinlock& lock_;
};
```

## 4. 公共 API 与中断管理协议 (Public APIs)

### 4.1 中断压栈/出栈协议 (Internal API)

**这是 Spinlock 安全性的核心。** 必须在 `Spinlock::acquire()` 和 `release()` 内部隐式调用，严禁外部业务层手动调用。它实现了 `_irqsave` / `_irqrestore` 的语义。

```cpp
namespace sync {
    /**
     * @brief 保存当前中断状态、关闭中断，并增加锁嵌套深度。
     *
     * 如果是获取第一把锁 (lock_depth 从 0 变 1)，则将当前的中断使能状态
     * (sstatus.SIE) 保存到 per-cpu 的 intr_was_on 字段中。
     * 随后，无论何种情况，都关闭中断。
     */
    void push_intr_save();

    /**
     * @brief 减少锁嵌套深度，并在释放最后一层锁时恢复之前的中断状态。
     *
     * 如果锁嵌套深度降为 0，则检查 intr_was_on 字段。只有当获取第一把锁
     * 之前中断是开启的时候，才重新开启中断。
     */
    void pop_intr_restore();
}
```

### 4.2 锁语义约定

本模块属于内核生命线，发生任何违反并发契约的行为（如重复加锁、越权解锁）均属于致命代码逻辑错误。 **此类函数无返回值，一旦检测到契约被破坏，直接触发 `kernel_panic()` 宕机。**

## 5. 并发与锁契约 (Concurrency & Locks)

### 5.1 内存序保证 (Memory Order Guarantee)

为了确保临界区内的读写操作不会被编译器或 CPU 的乱序执行（Out-of-Order Execution）重排到临界区外，必须使用带有内存屏障语义的原子操作。

- **Acquire 语义：** `Spinlock::acquire()` 内部的原子交换必须使用 `__ATOMIC_ACQUIRE`。在 RISC-V 层面，这将生成带有 `.aq` (Acquire) 后缀的原子指令（如 `amoswap.w.aq`），确保锁获取之后的任何内存读写，都不会被重排到拿锁之前。

- **Release 语义：** `Spinlock::release()` 内部的原子写零必须使用 `__ATOMIC_RELEASE`。使用 `__atomic_store_n(&locked_, 0, __ATOMIC_RELEASE)`，在 RISC-V 层面生成 `fence rw, w` + `sw`。注意：release 不需要原子 RMW 指令（`amoswap`），普通的 release-store 即可——因为此时本 CPU 已经是唯一的锁持有者，不存在竞争写。

### 5.2 自旋优化 (TTAS: Test-and-Test-and-Set)

朴素的 `while(__atomic_exchange_n(...))` 会在每次迭代都发出总线级原子操作，导致缓存一致性协议风暴。必须使用 TTAS 模式：

```cpp
void Spinlock::acquire() {
    sync::push_intr();
    // 外层：非原子读，利用本地缓存副本空转，不产生总线流量
    while (true) {
        while (__atomic_load_n(&locked_, __ATOMIC_RELAXED))
            ;  // 在 L1 cache 上旋转，等待释放信号via cache invalidation
        // 内层：看到可能空闲，才发起真正的原子交换
        if (__atomic_exchange_n(&locked_, 1, __ATOMIC_ACQUIRE) == 0)
            break;  // 成功获取
    }
    cpu_id_ = arch::cpu::id();
}
```

### 5.3 业务层使用契约 (Caller Contract)

1. **禁止睡眠：** 在持有 `Spinlock`（或处于 `LockGuard` 作用域内）的任何期间，**绝对禁止**调用可能导致当前 Task 休眠或主动放弃 CPU 的函数（如 `sleep()`, `yield()`, 或由于分配内存触发了等待）。

2. **优先 RAII：** 常规业务逻辑中应通过 `LockGuard` 对象管理锁的生命周期，利用 C++ 析构确保锁在异常或提前 return 时必定释放。`acquire()/release()` 公开暴露仅供**调度器内部**等必须跨函数边界持有锁的特殊场景使用（如 `sleep()` 中释放锁 + 上下文切换 + 醒来后重新获取）。

3. **锁序遵守：** 嵌套获取多把 Spinlock 时，必须严格遵循全局锁序 DAG（将在 Phase 2 完成后汇总为 `lock_ordering.md`）。任何违反锁序的代码在 Code Review 中必须被驳回。


## 6. 错误路径与 Panic 触发点 (Error Paths)

在以下情况下，自旋锁必须立即执行 `kernel_panic()` 阻断系统：

1. **死锁防御 (Double Lock)：** 在 `acquire()` 中，调用 `push_intr()` 关中断后、原子操作前，检查 `is_held_by_current_cpu()`。若为 `true`，说明当前 CPU 试图获取自己持有的锁，必然死锁，立即 Panic。打印锁名称与 CPU ID。

2. **越权释放 (Invalid Release)：** 在 `release()` 中，若 `is_held_by_current_cpu()` 为 `false`，说明代码逻辑严重错乱（锁未被持有、或被其他 CPU 持有），立即 Panic。

3. **中断状态校验：** 在 `acquire()` 入口（`push_intr()` 之前），若中断已被开启但 `lock_depth > 0`，说明存在中断状态泄漏（某处代码在持有锁的同时非法开启了中断），可选 Panic。此检查在 `#ifdef DEBUG` 下启用以避免正式构建的性能损失。


## 7. 状态机 / 时序图 (State Machine / Sequence)

### 7.1 Spinlock Acquire / Release 硬件级时序

```
[当前 CPU (CPU X) 请求 LockGuard]
   │
   ├─> 1. push_intr()
   │      ├─ 读取当前中断状态: was_on = arch::cpu::intr_enabled()
   │      ├─ 关中断: arch::cpu::intr_off()
   │      └─ if (lock_depth == 0) intr_was_on = was_on; lock_depth++
   │
   ├─> 2. 断言: is_held_by_current_cpu() == false  (否则 Panic: double lock)
   │
   ├─> 3. TTAS 自旋获取
   │      ├─ 外层 while: __atomic_load_n(&locked_, RELAXED) 非原子读空转
   │      └─ 内层 CAS:  __atomic_exchange_n(&locked_, 1, ACQUIRE) == 0 → 成功
   │
   ├─> 4. 记录属主: cpu_id_ = arch::cpu::id()
   │
   ▼
[执行临界区 C++ 业务逻辑 (关中断、无休眠)]
   │
   ▼
[LockGuard 析构，触发 release()]
   │
   ├─> 1. 断言: is_held_by_current_cpu() == true  (否则 Panic: invalid release)
   │
   ├─> 2. 擦除属主: cpu_id_ = kInvalidCpuId
   │
   ├─> 3. __atomic_store_n(&locked_, 0, __ATOMIC_RELEASE)
   │      └─ RISC-V: fence rw, w + sw zero → 临界区写入全局可见后才释放锁
   │
   └─> 4. pop_intr()
          ├─ lock_depth--
          └─ if (depth == 0 && intr_was_on) arch::cpu::intr_on()
```