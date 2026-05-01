/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * FdtManager — Flattened Device Tree parser
 *
 * Two-phase design:
 *   Phase 1 (Early Scan):  Static methods that walk the raw FDT blob
 *       without any memory allocation.  Used before PMM is available.
 *   Phase 2 (Unflatten):   Builds a persistent C++ DeviceNode object
 *       tree once Slab is ready.  The tree is then globally read-only.
 *
 * Concurrency: all init is done by BSP in the single-core window.
 * After unflattening the tree is immutable — no locks required.
 *
 * Reference: docs/specs/fdt.md
 */

#include <lume/types.h>
#include <lume/device_node.h>

class FdtManager {
public:
    // Construct with the physical address of the FDT blob.
    // Called via Placement New in fdt_init().
    FdtManager(uint64 fdt_paddr);

    // --- Phase 1: Early scan (static, allocation-free) ---

    // Extract physical memory base and size from the /memory node.
    // Panics if the FDT is invalid or /memory is missing.
    static void early_scan_mem(uint64 fdt_paddr, uint64 *base, uint64 *size);

    // Extract the UART base address and size by matching compatible = "ns16550a".
    // Falls back to platform default on failure.
    static void early_scan_uart(uint64 fdt_paddr, uint64 *uart_addr, uint64 *uart_size);

    // --- Phase 2: Object tree construction (requires Slab) ---

    // Walk the FDT blob and build the DeviceNode tree.
    void unflatten();

    // --- Query interface (read-only after unflatten) ---

    // Find the first node whose "compatible" property contains the string.
    // Returns nullptr if no match.
    DeviceNode *find_compatible(const char *compat_string);

    // Look up a node by its full path (e.g. "/soc/uart@10000000").
    // Returns nullptr if not found.
    DeviceNode *get_node_by_path(const char *path);

    // Return the stored FDT physical address.
    uint64 get_paddr() const { return fdt_paddr_; }

private:
    uint64 fdt_paddr_;           // Physical address of the FDT blob
    bool is_unflattened_ = false; // True after unflatten() completes
    DeviceNode *root_ = nullptr;  // Root of the unflattened tree
};

/* Global FDT manager singleton (Placement New, see global_init.md §3.1) */
extern FdtManager *g_fdt;

// --- Public free-function API ---

// Save FDT address and validate magic. Called early by BSP.
void fdt_init(uint64 fdt_paddr);

// Build the DeviceNode object tree. Requires Slab.
void fdt_unflatten();

// Driver probing helpers (delegate to g_fdt).
DeviceNode *fdt_find_compatible(const char *compat_string);
DeviceNode *fdt_get_node_by_path(const char *path);

// Early scan wrappers (delegate to FdtManager static methods).
void fdt_early_get_mem_info(uint64 *base, uint64 *size);
void fdt_early_get_uart_info(uint64 *uart_addr, uint64 *uart_size);
