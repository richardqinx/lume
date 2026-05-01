/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * fdt.cc — Flattened Device Tree parser implementation
 *
 * Implements the two-phase FDT parsing strategy described in fdt.md:
 *
 *   Phase 1 (Early Scan):
 *     Static methods that linearly walk the raw FDT blob in-place,
 *     performing zero memory allocation.  Called before PMM/Slab exist.
 *
 *   Phase 2 (Unflatten):
 *     Builds a persistent DeviceNode C++ object tree using Slab.
 *     Stub implementation — will be completed when Slab is available.
 *
 * Reference: docs/specs/fdt.md
 */

#include <lume/fdt.h>
#include <lume/new.h>
#include <lume/klog.h>
#include <lume/addr.h>

/* ------------------------------------------------------------------ */
/*  Global singleton (Placement New pattern, see global_init.md §3.1) */
/* ------------------------------------------------------------------ */

alignas(FdtManager) uint8 g_fdt_buf[sizeof(FdtManager)];
FdtManager *g_fdt = nullptr;

/* ------------------------------------------------------------------ */
/*  FDT binary format constants (DTSpec v0.4)                         */
/* ------------------------------------------------------------------ */

struct fdt_header {
    uint32 magic;
    uint32 totalsize;
    uint32 off_dt_struct;
    uint32 off_dt_strings;
    uint32 off_mem_rsvmap;
    uint32 version;
    uint32 last_comp_version;
    uint32 boot_cpuid_phys;
    uint32 size_dt_strings;
    uint32 size_dt_struct;
};

#define FDT_MAGIC      0xd00dfeed
#define FDT_BEGIN_NODE 1
#define FDT_END_NODE   2
#define FDT_PROP       3
#define FDT_NOP        4
#define FDT_END        9

/* ------------------------------------------------------------------ */
/*  Minimal string helpers (no lib/ dependency for early boot)        */
/* ------------------------------------------------------------------ */

static inline bool str_starts_with(const char *str, const char *prefix)
{
    while (*prefix) {
        if (*str++ != *prefix++)
            return false;
    }
    return true;
}

static inline bool str_equals(const char *s1, const char *s2)
{
    while (*s1 && *s1 == *s2) {
        s1++;
        s2++;
    }
    return *s1 == *s2;
}

/*
 * Check whether a null-separated string list (e.g. the "compatible"
 * property) contains @target.
 */
static bool prop_contains_string(const char *prop_val, uint32 len,
                                 const char *target)
{
    uint32 i = 0;
    while (i < len) {
        const char *s = prop_val + i;
        if (str_equals(s, target))
            return true;
        while (i < len && prop_val[i] != '\0')
            i++;
        i++; // skip '\0' separator
    }
    return false;
}

/* ------------------------------------------------------------------ */
/*  Byte-swap helpers                                                 */
/* ------------------------------------------------------------------ */

/*
 * Manual 32-bit big-endian to little-endian conversion.
 * We cannot use __builtin_bswap32 because on RISC-V without the Zbb
 * extension the compiler emits a call to libgcc's __bswapsi2, which
 * is unavailable in a freestanding (-nostdlib) environment.
 */
static inline uint32 bswap32(uint32 x)
{
    return ((x & 0xFF000000u) >> 24) |
           ((x & 0x00FF0000u) >>  8) |
           ((x & 0x0000FF00u) <<  8) |
           ((x & 0x000000FFu) << 24);
}

/*
 * Read a big-endian cell value from the FDT struct block.
 * @cells: number of 32-bit cells (1 or 2).
 *         2-cell values are common for 64-bit addresses/sizes.
 */
static inline uint64 read_cells(const uint8 *data, uint32 cells)
{
    const uint32 *p = reinterpret_cast<const uint32 *>(data);
    if (cells == 2) {
        uint64 high = bswap32(p[0]);
        uint64 low  = bswap32(p[1]);
        return (high << 32) | low;
    }
    return bswap32(p[0]);
}

/* ------------------------------------------------------------------ */
/*  FdtManager construction                                           */
/* ------------------------------------------------------------------ */

FdtManager::FdtManager(uint64 fdt_paddr) : fdt_paddr_(ensure_va(fdt_paddr)) {}

/* ------------------------------------------------------------------ */
/*  Phase 1: Early scan — memory layout                               */
/* ------------------------------------------------------------------ */

/*
 * Walk the raw FDT struct block to locate the /memory node and
 * extract its "reg" property (base address + size).
 *
 * Cell sizes (#address-cells, #size-cells) are tracked per depth
 * level to correctly decode the "reg" value under any bus topology.
 *
 * Panics on invalid magic or missing /memory node — there is no
 * recovery path this early in boot.
 */
void FdtManager::early_scan_mem(uint64 fdt_paddr, uint64 *base, uint64 *size)
{
    const fdt_header *hdr = reinterpret_cast<const fdt_header *>(fdt_paddr);
    if (bswap32(hdr->magic) != FDT_MAGIC)
        kernel_panic("FDT early_scan_mem: invalid magic number", nullptr);

    const uint8 *dt_struct =
        reinterpret_cast<const uint8 *>(fdt_paddr) + bswap32(hdr->off_dt_struct);
    const char *dt_strings =
        reinterpret_cast<const char *>(fdt_paddr) + bswap32(hdr->off_dt_strings);

    uint32 offset = 0;
    int depth = -1;

    // Per-depth cell sizes (inherit from parent on entry)
    uint32 address_cells[16] = {2};
    uint32 size_cells[16]    = {1};
    bool in_memory_node = false;

    while (true) {
        uint32 token = bswap32(
            *reinterpret_cast<const uint32 *>(dt_struct + offset));
        offset += 4;

        if (token == FDT_BEGIN_NODE) {
            const char *name = reinterpret_cast<const char *>(dt_struct + offset);
            uint32 name_len = 0;
            while (name[name_len] != '\0')
                name_len++;
            offset = (offset + name_len + 1 + 3) & ~3u; // align to 4 bytes

            depth++;

            // Inherit parent's cell sizes
            if (depth > 0 && depth < 16) {
                address_cells[depth] = address_cells[depth - 1];
                size_cells[depth]    = size_cells[depth - 1];
            }

            // Match top-level "memory" or "memory@..." nodes
            in_memory_node = (depth == 1 && str_starts_with(name, "memory"));

        } else if (token == FDT_END_NODE) {
            if (depth >= 0)
                depth--;
            in_memory_node = false;

        } else if (token == FDT_PROP) {
            uint32 len = bswap32(
                *reinterpret_cast<const uint32 *>(dt_struct + offset));
            uint32 nameoff = bswap32(
                *reinterpret_cast<const uint32 *>(dt_struct + offset + 4));
            offset += 8;

            const char *prop_name = dt_strings + nameoff;
            const uint8 *prop_val = dt_struct + offset;

            if (depth >= 0 && depth < 16) {
                // Track cell size overrides at the current depth
                if (str_equals(prop_name, "#address-cells")) {
                    address_cells[depth] = bswap32(
                        *reinterpret_cast<const uint32 *>(prop_val));
                } else if (str_equals(prop_name, "#size-cells")) {
                    size_cells[depth] = bswap32(
                        *reinterpret_cast<const uint32 *>(prop_val));
                }
                // Decode the "reg" property using the parent's cell sizes
                else if (in_memory_node && str_equals(prop_name, "reg")) {
                    uint32 p_depth = (depth > 0) ? depth - 1 : 0;
                    *base = read_cells(prop_val, address_cells[p_depth]);
                    *size = read_cells(
                        prop_val + address_cells[p_depth] * 4,
                        size_cells[p_depth]);
                    return; // Success
                }
            }

            offset = (offset + len + 3) & ~3u; // align to 4 bytes

        } else if (token == FDT_NOP) {
            continue;
        } else if (token == FDT_END) {
            break;
        } else {
            kernel_panic("FDT early_scan_mem: unknown token", nullptr);
        }
    }

    kernel_panic("FDT early_scan_mem: /memory node not found", nullptr);
}

/* ------------------------------------------------------------------ */
/*  Phase 1: Early scan — UART address                                */
/* ------------------------------------------------------------------ */

/*
 * Locate a UART node by matching compatible = "ns16550a" and return
 * its base address from the "reg" property.
 *
 * Unlike early_scan_mem, failure here is non-fatal: we fall back to
 * the platform's default UART address (0x10000000 for QEMU virt).
 */
void FdtManager::early_scan_uart(uint64 fdt_paddr, uint64 *uart_addr, uint64 *uart_size)
{
    if (!uart_addr || !uart_size)
        return;

    const fdt_header *hdr = reinterpret_cast<const fdt_header *>(fdt_paddr);
    if (bswap32(hdr->magic) != FDT_MAGIC)
        return;

    const uint8 *dt_struct =
        reinterpret_cast<const uint8 *>(fdt_paddr) + bswap32(hdr->off_dt_struct);
    const char *dt_strings =
        reinterpret_cast<const char *>(fdt_paddr) + bswap32(hdr->off_dt_strings);

    uint32 offset = 0;
    int depth = -1;
    uint32 address_cells[16] = {2};
    uint32 size_cells[16]    = {1};
    bool in_uart_node = false;
    bool has_current_node_reg = false;
    uint64 current_node_reg = 0;
    uint64 current_node_size = 0;

    while (true) {
        uint32 token = bswap32(
            *reinterpret_cast<const uint32 *>(dt_struct + offset));
        offset += 4;

        if (token == FDT_BEGIN_NODE) {
            const char *name = reinterpret_cast<const char *>(dt_struct + offset);
            uint32 name_len = 0;
            while (name[name_len] != '\0')
                name_len++;
            offset = (offset + name_len + 1 + 3) & ~3u;

            depth++;
            if (depth > 0 && depth < 16) {
                address_cells[depth] = address_cells[depth - 1];
                size_cells[depth]    = size_cells[depth - 1];
            }
            in_uart_node = false;
            has_current_node_reg = false;

        } else if (token == FDT_END_NODE) {
            if (depth >= 0)
                depth--;
            in_uart_node = false;
            has_current_node_reg = false;

        } else if (token == FDT_PROP) {
            uint32 len = bswap32(
                *reinterpret_cast<const uint32 *>(dt_struct + offset));
            uint32 nameoff = bswap32(
                *reinterpret_cast<const uint32 *>(dt_struct + offset + 4));
            offset += 8;

            const char *prop_name = dt_strings + nameoff;
            const uint8 *prop_val = dt_struct + offset;

            if (depth >= 0 && depth < 16) {
                if (str_equals(prop_name, "#address-cells")) {
                    address_cells[depth] = bswap32(
                        *reinterpret_cast<const uint32 *>(prop_val));
                } else if (str_equals(prop_name, "#size-cells")) {
                    size_cells[depth] = bswap32(
                        *reinterpret_cast<const uint32 *>(prop_val));
                } else if (str_equals(prop_name, "compatible")) {
                    if (prop_contains_string(
                            reinterpret_cast<const char *>(prop_val),
                            len, "ns16550a")) {
                        in_uart_node = true;
                        if (has_current_node_reg) {
                            *uart_addr = current_node_reg;
                            *uart_size = current_node_size;
                            return;
                        }
                    }
                } else if (str_equals(prop_name, "reg")) {
                    uint32 p_depth = (depth > 0) ? depth - 1 : 0;
                    current_node_reg = read_cells(prop_val, address_cells[p_depth]);
                    current_node_size = read_cells(
                        prop_val + address_cells[p_depth] * 4,
                        size_cells[p_depth]);
                    has_current_node_reg = true;
                    if (in_uart_node) {
                        *uart_addr = current_node_reg;
                        *uart_size = current_node_size;
                        return; // Found it
                    }
                }
            }

            offset = (offset + len + 3) & ~3u;

        } else if (token == FDT_NOP) {
            continue;
        } else if (token == FDT_END) {
            break;
        } else {
            break; // Unknown token — give up silently
        }
    }

    *uart_addr = 0;
    *uart_size = 0;
}

/* ------------------------------------------------------------------ */
/*  Phase 2: Unflatten (stub — requires Slab)                        */
/* ------------------------------------------------------------------ */

void FdtManager::unflatten()
{
    const fdt_header *hdr = reinterpret_cast<const fdt_header *>(fdt_paddr_);
    if (bswap32(hdr->magic) != FDT_MAGIC)
        kernel_panic("fdt unflatten: invalid magic", nullptr);

    const uint8 *dt_struct =
        reinterpret_cast<const uint8 *>(fdt_paddr_) + bswap32(hdr->off_dt_struct);
    const char *dt_strings =
        reinterpret_cast<const char *>(fdt_paddr_) + bswap32(hdr->off_dt_strings);

    uint32 offset = 0;

    /* Stack to track current node at each depth (max 16 levels) */
    DeviceNode *stack[16] = {};
    int depth = -1;

    while (true) {
        uint32 token = bswap32(
            *reinterpret_cast<const uint32 *>(dt_struct + offset));
        offset += 4;

        if (token == FDT_BEGIN_NODE) {
            const char *name = reinterpret_cast<const char *>(dt_struct + offset);
            uint32 name_len = 0;
            while (name[name_len] != '\0')
                name_len++;
            offset = (offset + name_len + 1 + 3) & ~3u;

            depth++;
            if (depth >= 16)
                kernel_panic("fdt unflatten: tree too deep", nullptr);

            DeviceNode *parent = (depth > 0) ? stack[depth - 1] : nullptr;
            DeviceNode *node = new DeviceNode(parent, name);
            if (!node)
                kernel_panic("fdt unflatten: OOM creating DeviceNode", nullptr);

            stack[depth] = node;

            if (parent)
                parent->add_child(node);
            else
                root_ = node; /* Root node */

        } else if (token == FDT_END_NODE) {
            if (depth >= 0)
                depth--;

        } else if (token == FDT_PROP) {
            uint32 len = bswap32(
                *reinterpret_cast<const uint32 *>(dt_struct + offset));
            uint32 nameoff = bswap32(
                *reinterpret_cast<const uint32 *>(dt_struct + offset + 4));
            offset += 8;

            const char *prop_name = dt_strings + nameoff;
            const void *prop_val = dt_struct + offset;

            if (depth >= 0 && depth < 16 && stack[depth]) {
                FdtProperty *prop = new FdtProperty;
                if (!prop)
                    kernel_panic("fdt unflatten: OOM creating FdtProperty", nullptr);
                prop->name = prop_name;
                prop->value = prop_val;
                prop->len = static_cast<int>(len);
                prop->link.init();
                stack[depth]->add_prop(prop);
            }

            offset = (offset + len + 3) & ~3u;

        } else if (token == FDT_NOP) {
            continue;
        } else if (token == FDT_END) {
            break;
        } else {
            kernel_panic("fdt unflatten: unknown token", nullptr);
        }
    }

    is_unflattened_ = true;
}

/* Recursive helper: find first node with matching compatible string */
static DeviceNode *find_compat_recursive(DeviceNode *node, const char *compat)
{
    const FdtProperty *prop = node->get_prop("compatible");
    if (prop) {
        const char *val = static_cast<const char *>(prop->value);
        uint32 i = 0;
        while (i < static_cast<uint32>(prop->len)) {
            const char *s = val + i;
            if (str_equals(s, compat))
                return node;
            while (i < static_cast<uint32>(prop->len) && val[i] != '\0')
                i++;
            i++;
        }
    }

    /* Search children */
    list_node *cur = node->children_list_head();
    list_node *end = node->children_list_sentinel();
    while (cur != end) {
        DeviceNode *child = list_entry<DeviceNode, &DeviceNode::sibling_link_>(cur);
        DeviceNode *found = find_compat_recursive(child, compat);
        if (found)
            return found;
        cur = cur->next;
    }
    return nullptr;
}

DeviceNode *FdtManager::find_compatible(const char *compat_string)
{
    if (!is_unflattened_)
        kernel_panic("fdt: tree not unflattened yet", nullptr);
    if (!root_)
        return nullptr;
    return find_compat_recursive(root_, compat_string);
}

DeviceNode *FdtManager::get_node_by_path(const char *path)
{
    if (!is_unflattened_)
        kernel_panic("fdt: tree not unflattened yet", nullptr);
    if (!root_ || !path)
        return nullptr;

    /* Skip leading '/' */
    if (*path == '/')
        path++;
    if (*path == '\0')
        return root_;

    DeviceNode *cur = root_;
    while (*path && cur) {
        /* Extract next path component */
        const char *end = path;
        while (*end && *end != '/')
            end++;

        /* Search children for a name matching this component */
        bool found = false;
        list_node *lc = cur->children_list_head();
        list_node *le = cur->children_list_sentinel();
        while (lc != le) {
            DeviceNode *child = list_entry<DeviceNode, &DeviceNode::sibling_link_>(lc);
            /* Compare name up to the component length */
            const char *cn = child->get_name();
            const char *p = path;
            const char *e = end;
            bool match = true;
            while (p < e) {
                if (*cn != *p) { match = false; break; }
                cn++; p++;
            }
            if (match && *cn == '\0') {
                cur = child;
                found = true;
                break;
            }
            lc = lc->next;
        }

        if (!found)
            return nullptr;

        path = (*end == '/') ? end + 1 : end;
    }
    return cur;
}

/* ------------------------------------------------------------------ */
/*  Public free-function API                                          */
/* ------------------------------------------------------------------ */

void fdt_init(uint64 fdt_paddr)
{
    const uint32 *magic_ptr = reinterpret_cast<const uint32 *>(fdt_paddr);
    if (bswap32(*magic_ptr) != FDT_MAGIC)
        kernel_panic("fdt_init: invalid FDT magic number",  nullptr);

    g_fdt = new (g_fdt_buf) FdtManager(fdt_paddr);
}

void fdt_unflatten()
{
    g_fdt->unflatten();
}

DeviceNode *fdt_find_compatible(const char *compat_string)
{
    return g_fdt->find_compatible(compat_string);
}

DeviceNode *fdt_get_node_by_path(const char *path)
{
    return g_fdt->get_node_by_path(path);
}

void fdt_early_get_mem_info(uint64 *base, uint64 *size)
{
    FdtManager::early_scan_mem(g_fdt->get_paddr(), base, size);
}

void fdt_early_get_uart_info(uint64 *uart_addr, uint64 *uart_size)
{
    FdtManager::early_scan_uart(g_fdt->get_paddr(), uart_addr, uart_size);
}
