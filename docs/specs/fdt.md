# 设备树 (Flattened Device Tree)

## 1. 目标 (Objective)

为 LumeOS 提供一套标准的硬件发现与配置机制，彻底摆脱硬编码的物理地址。本模块负责解析由 Bootloader 传入的 FDT 二进制数据，并分两个阶段将其转化为内核可用的数据结构：

1.  **早期扫描 (Early Scan):** 在内存管理（PMM）初始化之前，以只读、无分配的方式扫描 FDT，提取启动所必需的核心信息（如物理内存布局）。
2.  **对象化展开 (Unflattening):** 在内存管理（PMM/Slab）就绪后，将完整的 FDT 解析为一个常驻内存的 C++ `DeviceNode` 对象树，为后续的驱动探测（Driver Probing）提供面向对象的接口。

## 2. 前置依赖 (Dependencies)

- **引导协议契约 (`linker_and_entry.md`):** 依赖 Bootloader 在跳转至内核时，将 FDT 的物理基址置于 `a1` 寄存器。
- **全局初始化契约 (`global_init.md`):** `fdt_init()` 在 `console_init()` 之后、`pmm_init()` 之前被 BSP 调用。`pmm_init()` 自身会回调 FDT 的早期扫描接口。
- **内存管理契约 (`pmm.md`, `slab.md`):** 对象化展开阶段依赖 Slab 分配器（`operator new`）来动态创建 `DeviceNode` 对象。
- **项目约定 (`00_conventions.md`):** 遵循所有命名、错误处理和 API 设计规范。

## 3. 核心数据结构 (Data Structures)

### 3.1 FDT 属性 (`struct FdtProperty`)

表示设备节点中的一个属性（如 `reg`, `compatible`）。

```cpp
// 定义于 include/lume/fdt_prop.h
struct FdtProperty {
    const char* name;   // 属性名
    const void* value;  // 指向 FDT blob 中原始数据的指针
    int len;            // 数据长度（字节）
    list_node link;     // 链接到下一个属性
};
```

### 3.2 设备节点 (`class DeviceNode`)

FDT 对象树的核心，代表一个硬件设备或总线。

```cpp
// 定义于 include/lume/device_node.h
class DeviceNode {
public:
    // 构造/析构
    DeviceNode(DeviceNode* parent, const char* name);
    ~DeviceNode();

    // 属性访问
    const FdtProperty* get_prop(const char* name) const;
    uint32_t get_prop_u32(const char* name, uint32_t default_val = 0) const;
    uint64 get_prop_u64(const char* name, uint64 default_val = 0) const;
    const char* get_prop_string(const char* name) const;

    // 子节点遍历
    DeviceNode* find_child(const char* name);
    void for_each_child(void (*callback)(DeviceNode*));

    // 内部接口，供 FdtManager 构建树时使用
    void add_child(DeviceNode* child);
    void add_prop(FdtProperty* prop);

private:
    const char* name_;
    DeviceNode* parent_;
    list_node children_list_; // list_head of children
    list_node props_list_;    // list_head of properties
    list_node sibling_link_;  // link in parent's children_list_
};
```

### 3.3 FDT 管理器 (`class FdtManager`)

全局单例，负责 FDT 的解析与查询。

```cpp
// 定义于 include/lume/fdt.h
class FdtManager {
public:
    // 由 fdt_init() 通过 Placement New 调用
    FdtManager(uint64 fdt_paddr);

    // 阶段二：对象化展开
    void unflatten();

    // 驱动探测接口
    DeviceNode* find_compatible(const char* compat_string);
    DeviceNode* get_node_by_path(const char* path);

    // 阶段一：早期扫描接口 (静态，无状态)
    static void early_scan_mem(uint64 fdt_paddr, uint64* base, uint64* size);
    static void early_scan_uart(uint64 fdt_paddr, uint64* uart_addr);

private:
    uint64 fdt_paddr_;
    DeviceNode* root_ = nullptr;
    bool is_unflattened_ = false;
};

// 全局 FDT 管理器实例指针
extern FdtManager* g_fdt;
```

## 4. 公共 API (Public APIs)

```cpp
// === 初始化 API (由 kernel_main 调用) ===

// 阶段一和阶段二的入口。仅保存 FDT 地址，真正的解析被推迟。
void fdt_init(uint64 fdt_paddr);

// 在 Slab 就绪后调用，执行对象化展开。
void fdt_unflatten();


// === 驱动探测 API (供各驱动 init 函数调用) ===

// 根据 "compatible" 字符串查找第一个匹配的设备节点。
// 返回值：成功则为 DeviceNode 指针，失败为 nullptr。
DeviceNode* fdt_find_compatible(const char* compat_string);

// 根据完整路径查找设备节点。
DeviceNode* fdt_get_node_by_path(const char* path);


// === 早期扫描 API (供 PMM 和早期控制台调用) ===

// 扫描 FDT blob 获取 /memory 节点的 base 和 size。
// 失败则 panic。
void fdt_early_get_mem_info(uint64* base, uint64* size);

// 扫描 FDT blob 获取 /chosen/stdout-path 对应的 UART 物理地址。
void fdt_early_get_uart_info(uint64* uart_addr);
```

## 5. 并发与锁契约 (Concurrency & Locks)

- **无锁设计:** FDT 的所有初始化和解析操作（`fdt_init`, `fdt_unflatten`）均由 BSP 在多核启动前的**绝对单核期**完成。

- **只读安全:** 一旦 `fdt_unflatten()` 完成，`DeviceNode` 对象树即被视为**全局只读**数据。任何 CPU 都可以随时无锁访问它进行驱动探测和属性查询。

- **禁止修改:** 任何模块在初始化之后都**不得**修改 `DeviceNode` 树的内容。

## 6. 错误路径 (Error Paths)

- **FDT 损坏:** 在 `fdt_init()` 或 `fdt_unflatten()` 中，如果检测到 FDT 的 magic number 无效或结构损坏，必须立即调用 `kernel_panic()`。

- **关键节点缺失:** `fdt_early_get_mem_info()` 如果找不到 `/memory` 节点，说明无法确定物理内存大小，属于致命错误，必须 `kernel_panic()`。

- **内存分配失败:** `fdt_unflatten()` 在使用 `new` 创建 `DeviceNode` 时如果 Slab 返回 `nullptr`，说明内存耗尽，必须 `kernel_panic()`。

- **查询失败:** `fdt_find_compatible()` 或 `fdt_get_node_by_path()` 在未找到匹配节点时，安全地返回 `nullptr`。调用方（驱动）负责处理此情况（通常意味着该硬件不存在，驱动不进行初始化）。

## 7. 状态机 / 时序图 (State Machine / Sequence)

### FDT 二阶段解析时序

```
[entry.S] -> a1 = fdt_paddr
   │
   ▼
[kernel_main on BSP]
   │
   ├─> 1. fdt_init(fdt_paddr)
   │      └─ g_fdt = new FdtManager(fdt_paddr); // Placement New
   │         (仅保存地址，不进行任何解析)
   │
   ├─> 2. pmm_init()
   │      └─ fdt_early_get_mem_info(&base, &size);
   │         └─ FdtManager::early_scan_mem(fdt_paddr, ...);
   │            ├─ 遍历原始 FDT blob (无内存分配)
   │            ├─ 找到 /memory 节点
   │            └─ 返回 reg 属性值
   │
   ├─> 3. slab_init()
   │      └─ operator new 可用
   │
   ├─> 4. (稍后) fdt_unflatten()
   │      └─ g_fdt->unflatten();
   │         ├─ 再次遍历原始 FDT blob
   │         ├─ for each node: new DeviceNode(...)
   │         ├─ for each prop: new FdtProperty(...)
   │         └─ 构建完整的 C++ 对象树
   │
   ▼
[驱动初始化阶段, e.g., plic_init()]
   │
   ├─> node = fdt_find_compatible("riscv,plic0");
   │   └─ g_fdt->find_compatible(...);
   │      └─ 遍历已构建的 DeviceNode C++ 对象树 (只读, 无锁)
   │
   ├─> reg_prop = node->get_prop("reg");
   │
   └─> (使用 reg_prop->value 初始化 PLIC 驱动)
```