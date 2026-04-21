# 测试与持续集成 (Testing & CI)

## 1. 目标 (Objective)

为 LumeOS 项目定义自底向上的自动化测试标准与持续集成（CI）规范。通过建立在系统早期启动阶段驻留执行的 Boot Self-Test（KUnit）框架，严格确保内存管理、调度器、同步原语等底层基础设施无隐患。配合 `make test` Makefile 目标以及退出码（Exit Code）规范，构筑防止代码腐化的防线。

## 2. 前置依赖 (Dependencies)

- **全局类型契约：** `include/lume/types.h`。
- **输出机制：** 早期格式化输出需求依赖 `early_puts` 和 `early_putc` 等纯串口驱动原语。
- **宕机机制：** 依赖 `include/lume/panic.h` 定义的 `kernel_panic` 用于对测试失败执行终端处决。
- **QEMU CI 环境：** 自动化截取退出码依赖硬件特性的 `sifive_test` 接口（通过 OpenSBI 提供 System Reset/Poweroff 的底层能力）。

## 3. 核心机制设计

为了不侵入或依赖过于复杂的上下文结构，测试系统在操作系统生命周期的“最初始安全阶段”进行：
- **执行点：** 位于 `kernel_main()` 核心初始化逻辑收尾后（所有关键数据结构已分配完毕），但在多核被唤醒（AP 启动）以及用户态进程加载之前。
- **单核无中断：** 测试套件固定且绝对运行于 BSP (CPU 0) 的单核互斥环境中。在这些断言执行时，硬件中断是被严格关闭的。

## 4. KUnit 宏签名与接口规范 (Public APIs)

在 `include/lume/selftest.h` 中对外暴露以下断言宏。所有测试文件的断言仅允许使用下述原语：

### 4.1 核心断言宏

所有断言宏若验证通过通常无反馈，一旦发现断言失败即发生 `Panic` 导致系统停机。

```cpp
// 最基础的条件真实性断言
#define ST_ASSERT(cond)

// 验证两个数值、指针或枚举绝对相等的断言
// 失败时会自动将变量与地址分别序列化输出以协助排查
#define ST_ASSERT_EQ(a, b)

// 验证两个量绝对不相等的断言
#define ST_ASSERT_NE(a, b)
```

### 4.2 控制与排版原语

```cpp
// 在每个用例的前置输出 `[test] <name> ... `
void st_begin(const char* name);

// 在用例顺利通过后输出 `PASS` 并换行
void st_pass();

// C++ 自检主函数，由各个测试子模块（如 test_pmm.cc）自行声明填充。
// 必须注册到 kernel_main 中调用的 `selftest_run_all()` 总表中。
void selftest_xxx(); 
```

## 5. Panic 退出码与 QEMU CI 自动退出 (Exit Codes)

为了让 GitHub Actions 或者外部自动化测试流水线有效地判决 LumeOS 是否正确运行，我们需要与 QEMU 沟通，而不是靠正则表达式提取输出文字。

### 5.1 失败与宕机 (Panic)

当某个 `ST_ASSERT` 失效时：
1. `kernel_panic("selftest failed", detail);` 触发。
2. 串口向屏幕喷出宕机回溯（行号与文件名）。
3. **调用 SBI 接口终止运行：**内核使用 OpenSBI (EID `0x53525354` System Reset Extension)，发起 System Failure 指令并传送特定的退出码（例如 Exit Code 127）。

### 5.2 成功退出校验

当所有的 `selftest` 在 `make test` 命令中走通并通过所有的断言验证时：
1. 输出 `All self-tests PASSED`。
2. 不会进入系统的死循环（挂机状态）。
3. 核发送带有 Exit Code 0 的 SBI 成功关机请求，使得宿主机的 `make test` 返回码为成功，绿灯放行 CI 。

## 6. `make test` 规范 (Make Target)

`make test` 须作为一个专职的自动化冒烟测试管道：

- `make test` 将编译特制的测试版本（例如自动注册带有 CI 自动关机行为的 Flag ）。
- **屏蔽图形学延误：** 测试应当在 Makefile 使用 `-nographic` 的纯无头界面（Headless）运行 QEMU。
- **无等待结束：** QEMU 只要执行测试程序，系统即可在极短时间内得到退出码反馈结果，不会陷入一直等待。
- **集成于构建流：** `make fmt && make lint && make test` 是提交到 Main 分支之前在开发者本地应当成为默认习惯的行为指令链。

## 7. 错误路径 (Error Paths)

因为其测试属性：只要未跑通，便进入灾难模式（Panic）。此时不考虑优雅释放任何当前持有的锁，亦不关闭或清理页表，而是立刻抛血书以保护现场，等待开发者进行后续 GDB 对照排查。
