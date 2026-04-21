/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * device_node.cc — DeviceNode implementation
 *
 * Provides property lookup and child traversal for the unflattened
 * device tree.  After construction, the tree is globally read-only.
 *
 * Reference: docs/specs/fdt.md §3.2
 */

#include <lume/device_node.h>

/* Minimal strcmp — no lib dependency */
static bool str_eq(const char *a, const char *b)
{
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

/* ------------------------------------------------------------------ */
/*  Construction / Destruction                                        */
/* ------------------------------------------------------------------ */

DeviceNode::DeviceNode(DeviceNode *parent, const char *name)
    : name_(name), parent_(parent)
{
    children_list_.init();
    props_list_.init();
    sibling_link_.init();
}

DeviceNode::~DeviceNode()
{
    /* Recursively delete children */
    list_node *cur = children_list_.next;
    while (cur != &children_list_) {
        list_node *next = cur->next;
        /* Recover DeviceNode* from sibling_link_ offset */
        DeviceNode *child = list_entry<DeviceNode, &DeviceNode::sibling_link_>(cur);
        delete child;
        cur = next;
    }

    /* Delete properties */
    list_node *pc = props_list_.next;
    while (pc != &props_list_) {
        list_node *pn = pc->next;
        FdtProperty *prop = reinterpret_cast<FdtProperty *>(
            reinterpret_cast<uintptr>(pc) -
            __builtin_offsetof(FdtProperty, link));
        delete prop;
        pc = pn;
    }
}

/* ------------------------------------------------------------------ */
/*  Tree construction (used by FdtManager::unflatten)                 */
/* ------------------------------------------------------------------ */

void DeviceNode::add_child(DeviceNode *child)
{
    /* Append to end of children list */
    list_node *node = &child->sibling_link_;
    node->prev = children_list_.prev;
    node->next = &children_list_;
    children_list_.prev->next = node;
    children_list_.prev = node;
}

void DeviceNode::add_prop(FdtProperty *prop)
{
    list_node *node = &prop->link;
    node->prev = props_list_.prev;
    node->next = &props_list_;
    props_list_.prev->next = node;
    props_list_.prev = node;
}

/* ------------------------------------------------------------------ */
/*  Property access                                                   */
/* ------------------------------------------------------------------ */

const FdtProperty *DeviceNode::get_prop(const char *name) const
{
    const list_node *cur = props_list_.next;
    while (cur != &props_list_) {
        const FdtProperty *prop = reinterpret_cast<const FdtProperty *>(
            reinterpret_cast<uintptr>(cur) -
            __builtin_offsetof(FdtProperty, link));
        if (str_eq(prop->name, name))
            return prop;
        cur = cur->next;
    }
    return nullptr;
}

/* Big-endian helpers for decoding property values */
static inline uint32 be32(const void *p)
{
    const uint8 *b = static_cast<const uint8 *>(p);
    return (uint32(b[0]) << 24) | (uint32(b[1]) << 16) |
           (uint32(b[2]) << 8)  |  uint32(b[3]);
}

static inline uint64 be64(const void *p)
{
    const uint8 *b = static_cast<const uint8 *>(p);
    return (uint64(be32(b)) << 32) | uint64(be32(b + 4));
}

uint32 DeviceNode::get_prop_u32(const char *name, uint32 default_val) const
{
    const FdtProperty *p = get_prop(name);
    if (!p || p->len < 4)
        return default_val;
    return be32(p->value);
}

uint64 DeviceNode::get_prop_u64(const char *name, uint64 default_val) const
{
    const FdtProperty *p = get_prop(name);
    if (!p)
        return default_val;
    if (p->len >= 8)
        return be64(p->value);
    if (p->len >= 4)
        return be32(p->value);
    return default_val;
}

const char *DeviceNode::get_prop_string(const char *name) const
{
    const FdtProperty *p = get_prop(name);
    if (!p || p->len == 0)
        return nullptr;
    return static_cast<const char *>(p->value);
}

/* ------------------------------------------------------------------ */
/*  Child traversal                                                   */
/* ------------------------------------------------------------------ */

DeviceNode *DeviceNode::find_child(const char *name)
{
    list_node *cur = children_list_.next;
    while (cur != &children_list_) {
        DeviceNode *child = list_entry<DeviceNode, &DeviceNode::sibling_link_>(cur);
        if (str_eq(child->name_, name))
            return child;
        cur = cur->next;
    }
    return nullptr;
}

void DeviceNode::for_each_child(void (*callback)(DeviceNode *))
{
    list_node *cur = children_list_.next;
    while (cur != &children_list_) {
        list_node *next = cur->next;
        DeviceNode *child = list_entry<DeviceNode, &DeviceNode::sibling_link_>(cur);
        callback(child);
        cur = next;
    }
}
