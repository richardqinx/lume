/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * DeviceNode — FDT object tree node
 *
 * Each DeviceNode represents a single node in the unflattened device tree.
 * Nodes form a parent-children hierarchy via intrusive linked lists.
 * After unflattening, the tree is globally read-only and requires no locks.
 *
 * Created when Slab is available.
 *
 * Reference: docs/specs/fdt.md §3.2
 */

#include <lume/types.h>
#include <lume/list.h>
#include <lume/fdt_prop.h>

class DeviceNode {
public:
    // Construction / destruction (used by FdtManager::unflatten)
    DeviceNode(DeviceNode *parent, const char *name);
    ~DeviceNode();

    // --- Property access ---

    // Look up a property by name. Returns nullptr if not found.
    const FdtProperty *get_prop(const char *name) const;

    // Convenience helpers that decode the property value.
    // Return default_val when the property does not exist.
    uint32 get_prop_u32(const char *name, uint32 default_val = 0) const;
    uint64 get_prop_u64(const char *name, uint64 default_val = 0) const;
    const char *get_prop_string(const char *name) const;

    // --- Child traversal ---

    // Find a direct child by name. Returns nullptr if not found.
    DeviceNode *find_child(const char *name);

    // Invoke callback for every direct child.
    void for_each_child(void (*callback)(DeviceNode *));

    // --- Internal (used by FdtManager to build the tree) ---
    void add_child(DeviceNode *child);
    void add_prop(FdtProperty *prop);

    // --- Accessors for tree traversal ---
    const char *get_name() const { return name_; }
    list_node *children_list_head() { return children_list_.next; }
    list_node *children_list_sentinel() { return &children_list_; }

    // sibling_link_ offset needed by container_of in fdt.cc
    list_node sibling_link_;     // Link in parent's children_list_

private:
    const char *name_;           // Node name (e.g. "memory@80000000")
    DeviceNode *parent_;         // Parent node (nullptr for root)
    list_node children_list_;    // Head of the children linked list
    list_node props_list_;       // Head of the property linked list
};
