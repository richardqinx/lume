# SLUB 分配器 (SLUB Allocator)

## 1. 目标 (Objective)

在物理内存管理器 (PMM) 之上，为内核提供高效的字节级内存分配器。采用 **SLUB** 设计（Simple List of Unfull Blocks），通过复用 PMM 的 `Frame` 描述符存储 per-page 元数据、将空闲链表嵌入对象体内、以及 Per-CPU 活跃页机制，实现低碎片、低锁竞争的小对象分配。本模块是内核 `operator new` 的直接后端。

**为何选择 SLUB 而非经典 Slab：**
- `Frame` 结构已包含 `cache` 指针和 `obj_count` 字段，无需额外的 per-page `struct Slab` 头部。
- 省去 full/partial/empty 三链表管理，仅需一个 partial 链表。
- Per-CPU 缓存仅需一个"当前活跃页"指针，无需动态分配对象数组（避免 slab_init 的鸡生蛋问题）。
- Linux 自 2.6.23 起默认 SLUB，6.8 已完全移除经典 Slab。

## 2. 前置依赖 (Dependencies)

- **全局初始化契约 (`global_init.md`):** `slab_init()` 在 `pmm_init()` 之后、`vmm_init()` 之前被 BSP 调用。
- **物理内存契约 (`pmm.md`):** 依赖 `pmm_alloc_frame()` / `pmm_free_frame()` 以及 `Frame` 描述符中的 `slab.cache` 和 `slab.obj_count` 字段。还依赖 `pa_to_frame()` / `frame_to_pa()` 进行地址转换。
- **并发同步契约 (`spinlock.md`):** 依赖 `Spinlock` 保护全局 partial 链表。
- **架构抽象契约 (`arch_abstraction.md`):** 依赖 `arch::cpu::id()` 访问 Per-CPU 缓存；依赖 `arch::cpu::intr_off()/intr_on()` 保护 Per-CPU 操作免受中断重入。
- **项目约定 (`00_conventions.md`):** 遵循所有命名和类型规范。

## 3. 核心数据结构 (Data Structures)

### 3.1 空闲对象链表（嵌入式）

空闲对象的前 `sizeof(void*)` 字节存储下一个空闲对象的指针。对象被分配后，该区域归用户使用。因此**最小对象尺寸 = `sizeof(void*)` = 8 字节**。

```
[ Free Object ]          [ Free Object ]          [ Free Object ]
+-------------+          +-------------+          +-------------+
| next ---------.------->| next ---------.------->| next = NULL |
| (unused)    |          | (unused)    |          | (unused)    |
+-------------+          +-------------+          +-------------+
```

### 3.2 Frame 描述符中的 Slab 元数据

复用 `include/lume/frame.h` 中已有的字段（无需新增结构体）：

```cpp
// 当 Frame.state == FrameState::Slab 时有效
struct {
    KmemCache* cache;     // 此页属于哪个 KmemCache
    uint32 obj_count;     // 此页上已分配的对象数量
} slab;
```

- 此外，需要在 `Frame` 的 `free` union 成员中增加一个 `void* freelist` 字段，或者直接将 freelist 头指针嵌入 union。为保持 Frame 结构简洁，**freelist 头指针存储在页面固定偏移处（页起始的前 8 字节）**，不侵入 Frame 结构。

**修正方案：** 在 `Frame` 的 `slab` union 成员中增加 `void* freelist` 字段：

```cpp
struct {
    KmemCache* cache;     // 所属缓存
    uint32 obj_count;     // 已分配对象数
    void* freelist;       // 页内空闲对象链表头
} slab;
```

### 3.3 Per-CPU 活跃页

每个 CPU 对每个 KmemCache 维护一个"当前活跃页"（cpu_slab）。分配时优先从此页的 freelist 弹出对象，无需获取全局锁。

```cpp
// 定义于 mm/slab.h (模块私有)
struct PerCpuSlab {
    Frame* active;  // 当前 CPU 正在使用的 slab 页（可能为 nullptr）
};
```

### 3.4 内核内存缓存 (`class KmemCache`)

```cpp
// 定义于 mm/slab.h
class KmemCache {
public:
    KmemCache() = default;
    void init(const char* name, uint32 obj_size, uint32 obj_align);

    void* alloc();
    void free(void* obj);

private:
    Frame* get_partial();           // 从 partial 链表取一个页
    void put_partial(Frame* f);     // 将页放入 partial 链表
    Frame* new_slab();              // 从 PMM 申请新页并格式化

    Spinlock lock_;                 // 保护 partial 链表
    list_node partial_;             // 部分填充的 slab 页链表

    PerCpuSlab cpu_slab_[kMaxCPUs]; // Per-CPU 活跃页

    const char* name_ = "uninit";
    uint32 obj_size_ = 0;          // 对齐后的对象尺寸
    uint32 obj_align_ = 0;         // 对齐要求
    uint32 objs_per_slab_ = 0;     // 每页可容纳的对象数
};
```

### 3.5 通用尺寸缓存

```cpp
// 预创建的 2^N 尺寸缓存: 8, 16, 32, 64, 128, 256, 512, 1024, 2048
inline constexpr int kNumSizeClasses = 9;
inline constexpr uint32 kSizeClasses[kNumSizeClasses] = {
    8, 16, 32, 64, 128, 256, 512, 1024, 2048
};

extern KmemCache g_size_caches[kNumSizeClasses];
```

## 4. 公共 API (Public APIs)

```cpp
// === 初始化 ===
void slab_init();  // 初始化所有通用尺寸缓存

// === 对象缓存 API ===
void kmem_cache_init(KmemCache* cache, const char* name,
                     uint32 size, uint32 align);
void* kmem_cache_alloc(KmemCache* cache);
void kmem_cache_free(KmemCache* cache, void* obj);

// === 通用分配 API ===
void* kmalloc(uint32 size);  // 自动选择尺寸缓存
void kfree(void* ptr);       // 通过 Frame 反查 cache，自动归还

// === C++ Runtime ===
void* operator new(size_t size);
void* operator new[](size_t size);
void operator delete(void* ptr) noexcept;
void operator delete[](void* ptr) noexcept;
void operator delete(void* ptr, size_t) noexcept;
void operator delete[](void* ptr, size_t) noexcept;
```

## 5. 并发与锁契约 (Concurrency & Locks)

- **持有锁:** 每个 `KmemCache` 持有一把 `Spinlock lock_`。

- **锁的作用域:** `lock_` **仅保护** `partial_` 链表。

- **Per-CPU 保护:** 访问 `cpu_slab_[cpu_id]` 时必须关闭中断（同 PMM 的 PCP 策略），防止中断重入。

- **快速路径（关中断，无锁）：** 从当前 CPU 的 `active` 页的 `freelist` 弹出/压入对象。

- **慢速路径（需要锁）：**
    - alloc：当 `active` 页无空闲对象时，获取 `lock_` 从 `partial_` 取页（或调用 PMM 新建）。
    - free：当归还对象使一个页变为完全空闲时，获取 `lock_` 归还 PMM。

- **与 PMM 交互：** `new_slab()` 调用 `pmm_alloc_frame()` 时**不持有** `lock_`（先释放锁，申请页，再获取锁挂入链表），避免 Slab lock → PMM lock 嵌套。

## 6. 错误路径 (Error Paths)

- **初始化失败:** `slab_init()` 若 PMM 无法提供页面，`kernel_panic()`。

- **分配失败:** `kmalloc()` / `kmem_cache_alloc()` 在 OOM 时返回 `nullptr`。

- **释放错误:** `kfree(nullptr)` 为 no-op。传入非法指针（不属于任何 slab 页）时 `kernel_panic()`。

## 7. 状态机 / 时序图 (State Machine / Sequence)

### 7.1 `kmem_cache_alloc` 时序

```
[kmem_cache_alloc(cache) on CPU X]
   │
   ├─> 1. 关中断
   ├─> 2. active = cache->cpu_slab_[X].active
   │
   ├─> 3. if (active && active->slab.freelist != NULL) ?
   │       ├── [是 (Fast Path)]
   │       │     ├─ obj = active->slab.freelist
   │       │     ├─ active->slab.freelist = *(void**)obj
   │       │     ├─ active->slab.obj_count++
   │       │     ├─ 恢复中断
   │       │     └─ return obj
   │       │
   │       └── [否 (Slow Path)]
   │             ├─ 4.1 将 active (若满) 从 cpu_slab 移出
   │             ├─     (满页不需要跟踪，但其 Frame 中 cache 指针仍有效)
   │             ├─ 4.2 恢复中断
   │             ├─ 4.3 LockGuard guard(cache->lock_)
   │             ├─ 4.4 new_active = get_partial()  // 从 partial 链表取
   │             │      └─ 若无，释放锁 → new_slab() → 重新获取锁
   │             ├─ 4.5 释放锁
   │             ├─ 4.6 关中断
   │             ├─ 4.7 cache->cpu_slab_[X].active = new_active
   │             ├─ 4.8 从 new_active->slab.freelist 弹出 obj
   │             ├─ 4.9 恢复中断
   │             └─ return obj
   │
   ▼
[返回 obj* 或 nullptr]
```

### 7.2 `kfree` 时序

```
[kfree(ptr)]
   │
   ├─> 1. pa = ptr 的物理地址 (对于 identity/higher-half，减去偏移)
   ├─> 2. frame = pa_to_frame(pa & ~(kPageSize-1))
   ├─> 3. cache = frame->slab.cache
   │
   ├─> 4. 关中断
   ├─> 5. 将 obj 压入 frame->slab.freelist
   ├─> 6. frame->slab.obj_count--
   │
   ├─> 7. if (obj_count == 0) ?
   │       ├── [是：页完全空闲]
   │       │     ├─ 若此页是当前 CPU 的 active，清除 active
   │       │     ├─ 恢复中断
   │       │     ├─ LockGuard: 从 partial_ 链表移除 (如果在链表中)
   │       │     └─ pmm_free_frame(frame)  // 归还 PMM
   │       │
   │       └── [否]
   │             ├─ 若此页不是任何 CPU 的 active 且不在 partial，
   │             │  则需获取锁放入 partial (满→部分满的过渡)
   │             └─ 恢复中断
   │
   ▼
[完成]
```

## 8. 已知缺陷与未来挑战

### 8.1 缓存收缩

当前不主动收缩 partial 链表。未来可增加 `kmem_cache_shrink()` 供内存回收线程调用。

### 8.2 大对象分配

大于 2048 字节的分配直接退化为 `pmm_alloc_frames()`。当前由 `kmalloc` 透明处理。
