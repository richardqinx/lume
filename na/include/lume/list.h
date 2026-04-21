/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

#include <lume/types.h>

/**
 * @brief The node to be embedded in a struct to make it linkable.
 *
 * An object can be on multiple lists simultaneously by embedding multiple
 * list_node members with different names.
 */
struct list_node {
    list_node* prev;
    list_node* next;

    /**
     * @brief Initializes the node to point to itself, forming an empty list head.
     */
    void init() {
        prev = this;
        next = this;
    }

    /**
     * @brief Checks if the list this node is the head of is empty.
     * @return True if the list is empty, false otherwise.
     */
    bool is_empty() const {
        return next == this;
    }
};

/*
 * Type-safe container_of: given a pointer to a list_node member,
 * recover a pointer to the enclosing object.
 * Uses pointer-to-member arithmetic — no __builtin_offsetof needed.
 */
template <typename T, list_node T::*Member>
static inline T *list_entry(list_node *node)
{
    constexpr size_t off = (size_t)(uintptr) & (((T *)nullptr)->*Member);
    return reinterpret_cast<T *>(reinterpret_cast<uintptr>(node) - off);
}

/**
 * @brief A type-safe, intrusive, doubly-linked list.
 *
 * This class manages objects of type T that have a `list_node` member.
 * It has zero runtime overhead compared to a manual C implementation and
 * provides compile-time type safety.
 *
 * @tparam T The type of the object in the list.
 * @tparam NodeMember A pointer-to-member specifying which `list_node` in T to use.
 */
template <typename T, list_node T::*NodeMember>
class List {
private:
    static list_node* get_node(T* obj) {
        return &(obj->*NodeMember);
    }

    // NOTE: `((T*)nullptr)->*NodeMember` is technically undefined behavior in
    // standard C++. However, it's a common idiom in low-level programming
    // (similar to `offsetof`) that compilers typically handle correctly,
    // especially with flags like `-fno-delete-null-pointer-checks`.
    // The alternative (using `offsetof`) would sacrifice the compile-time
    // type safety of the pointer-to-member template parameter.
    static T* get_obj(list_node* node) {
        constexpr size_t offset = (size_t)(uintptr) & (((T*)nullptr)->*NodeMember);
        return reinterpret_cast<T*>(reinterpret_cast<uintptr>(node) - offset);
    }

    static const T* get_obj(const list_node* node) {
        constexpr size_t offset = (size_t)(uintptr) & (((T*)nullptr)->*NodeMember);
        return reinterpret_cast<const T*>(reinterpret_cast<uintptr>(node) - offset);
    }

public:
    class iterator;
    class const_iterator;

    class iterator {
        friend class List<T, NodeMember>;
        friend class const_iterator;

    public:
        iterator(list_node* node) : node_(node) {}

        T& operator*() const { return *get_obj(node_); }
        T* operator->() const { return get_obj(node_); }

        iterator& operator++() {
            node_ = node_->next;
            return *this;
        }
        iterator operator++(int) {
            iterator tmp = *this;
            ++(*this);
            return tmp;
        }

        iterator& operator--() {
            node_ = node_->prev;
            return *this;
        }
        iterator operator--(int) {
            iterator tmp = *this;
            --(*this);
            return tmp;
        }

        bool operator==(const iterator& other) const { return node_ == other.node_; }
        bool operator!=(const iterator& other) const { return !(*this == other); }

    private:
        list_node* node_;
    };

    class const_iterator {
    public:
        const_iterator(const list_node* node) : node_(node) {}
        const_iterator(const iterator& other) : node_(other.node_) {}

        const T& operator*() const { return *get_obj(node_); }
        const T* operator->() const { return get_obj(node_); }

        const_iterator& operator++() {
            node_ = node_->next;
            return *this;
        }
        const_iterator operator++(int) {
            const_iterator tmp = *this;
            ++(*this);
            return tmp;
        }

        const_iterator& operator--() {
            node_ = node_->prev;
            return *this;
        }
        const_iterator operator--(int) {
            const_iterator tmp = *this;
            --(*this);
            return tmp;
        }

        bool operator==(const const_iterator& other) const { return node_ == other.node_; }
        bool operator!=(const const_iterator& other) const { return !(*this == other); }

    private:
        const list_node* node_;
    };

    List() { head_.init(); }
    ~List() = default;

    // This container is intrusive and does not own the objects.
    // Copying or moving it is a logical error.
    List(const List&) = delete;
    List& operator=(const List&) = delete;

    bool empty() const { return head_.is_empty(); }

    void push_front(T* obj) {
        list_node* node = get_node(obj);
        node->next = head_.next;
        node->prev = &head_;
        head_.next->prev = node;
        head_.next = node;
    }

    void push_back(T* obj) {
        list_node* node = get_node(obj);
        node->prev = head_.prev;
        node->next = &head_;
        head_.prev->next = node;
        head_.prev = node;
    }

    /**
     * @brief Splices all elements from another list to the front of this list.
     *
     * Moves all elements from `other` to the beginning of `this` list in O(1)
     * time. The `other` list becomes empty after the operation.
     *
     * @param other The list to splice from.
     */
    void splice_front(List& other) {
        if (other.empty()) {
            return;
        }
        list_node* this_first = head_.next;
        list_node* other_first = other.head_.next;
        list_node* other_last = other.head_.prev;

        // Link other's last to this's original first
        other_last->next = this_first;
        this_first->prev = other_last;

        // Link this's head to other's first
        head_.next = other_first;
        other_first->prev = &head_;

        // Reset the other list
        other.head_.init();
    }

    /**
     * @brief Splices all elements from another list to the back of this list.
     *
     * Moves all elements from `other` to the end of `this` list in O(1)
     * time. The `other` list becomes empty after the operation.
     *
     * @param other The list to splice from.
     */
    void splice_tail(List& other) {
        if (other.empty()) {
            return;
        }
        list_node* this_last = head_.prev;
        list_node* other_first = other.head_.next;
        list_node* other_last = other.head_.prev;

        // Link this's last to other's first
        this_last->next = other_first;
        other_first->prev = this_last;

        // Link other's last to this's head
        other_last->next = &head_;
        head_.prev = other_last;

        // Reset the other list
        other.head_.init();
    }

    T* pop_front() {
        if (empty()) {
            return nullptr;
        }
        list_node* node = head_.next;
        node->prev->next = node->next;
        node->next->prev = node->prev;
        node->init();
        return get_obj(node);
    }

    T* pop_back() {
        if (empty()) {
            return nullptr;
        }
        list_node* node = head_.prev;
        node->prev->next = node->next;
        node->next->prev = node->prev;
        node->init();
        return get_obj(node);
    }

    void remove(T* obj) {
        list_node* node = get_node(obj);
        node->prev->next = node->next;
        node->next->prev = node->prev;
        node->init();
    }

    T* front() {
        return empty() ? nullptr : get_obj(head_.next);
    }

    const T* front() const {
        return empty() ? nullptr : get_obj(head_.next);
    }

    T* back() {
        return empty() ? nullptr : get_obj(head_.prev);
    }

    const T* back() const {
        return empty() ? nullptr : get_obj(head_.prev);
    }

    iterator begin() { return iterator(head_.next); }
    iterator end() { return iterator(&head_); }
    const_iterator begin() const { return const_iterator(head_.next); }
    const_iterator end() const { return const_iterator(&head_); }
    const_iterator cbegin() const { return const_iterator(head_.next); }
    const_iterator cend() const { return const_iterator(&head_); }

private:
    list_node head_;
};