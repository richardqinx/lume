# C++ 内核运行时 (C++ Kernel Runtime)

## 1. 目标 (Objective)

为 LumeOS 内核提供最小化的 C++ ABI 存根函数。在 `-fno-exceptions -fno-rtti -nostdlib` 环境下，编译器和链接器仍会引用若干 C++ 运行时符号（如纯虚函数陷阱、全局析构注册、DSO handle）。本模块提供这些符号的内核实现，防止链接失败。

**职责边界：**
- `operator new/delete` 由 Slab 分配器模块 (`mm/slab.cc`) 提供，**不在本模块**。
- Placement new 由 `include/lume/new.h` 提供，**不在本模块**。
- 本模块仅提供 ABI 存根和编译器辅助符号。

## 2. 前置依赖 (Dependencies)

- **Panic 机制 (`lib/panic.cc`):** 依赖 `kernel_panic()` 在遇到不可恢复错误时终止系统。
- **项目约定 (`00_conventions.md`):** 遵循 `-fno-exceptions -fno-rtti` 编译约束。

## 3. 核心数据结构 (Data Structures)

无。本模块仅实现全局函数和符号。

## 4. 公共 API (Public APIs)

这些符号由编译器/链接器隐式引用，内核代码不应直接调用。

```cpp
// 定义于 lib/cxx_abi.cc

// 当代码通过基类指针调用未实现的纯虚函数时，
// 编译器生成的 vtable 条目会引用此符号。
// 这是不可恢复的编程错误。
extern "C" void __cxa_pure_virtual();

// 全局对象析构注册。内核不支持全局对象析构（全局对象
// 通过 Placement New 手动管理生命周期）。若编译器生成
// 对此符号的调用，说明代码中存在违规的全局对象。
extern "C" int __cxa_atexit(void (*func)(void*), void* arg, void* dso_handle);

// DSO handle — 链接器在某些情况下引用此符号
// （与 __cxa_atexit 配合标识动态共享对象）。
// 内核为静态链接，此符号仅需存在即可。
extern "C" void* __dso_handle;
```

## 5. 并发与锁契约 (Concurrency & Locks)

无。所有函数要么立即 panic，要么是静态符号。

## 6. 错误路径 (Error Paths)

- `__cxa_pure_virtual()` → 立即 `kernel_panic("pure virtual function call")`。
- `__cxa_atexit()` → 立即 `kernel_panic("__cxa_atexit called in kernel")`。

## 7. 状态机 / 时序图 (State Machine / Sequence)

无复杂时序。所有路径均为：检测到违规 → panic。
