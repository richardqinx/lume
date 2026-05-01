/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Red-Black Trees — public API
 * Adapted from Linux kernel include/linux/rbtree.h
 *
 * (C) 1999  Andrea Arcangeli <andrea@suse.de>
 */

#pragma once

#include <lume/compiler.h>
#include <lume/rbtree_types.h>

/* ------------------------------------------------------------------ */
/*  Linux-compat macros for freestanding kernel                       */
/* ------------------------------------------------------------------ */

#ifndef container_of
#define container_of(ptr, type, member) \
	reinterpret_cast<type *>( \
		reinterpret_cast<char *>(ptr) - __builtin_offsetof(type, member))
#endif

/* ------------------------------------------------------------------ */
/*  Core macros                                                       */
/* ------------------------------------------------------------------ */

#define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3UL))

#define rb_entry(ptr, type, member)  container_of(ptr, type, member)

#define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == nullptr)

#define RB_EMPTY_NODE(node)  \
	((node)->__rb_parent_color == (unsigned long)(node))
#define RB_CLEAR_NODE(node)  \
	((node)->__rb_parent_color = (unsigned long)(node))

/* ------------------------------------------------------------------ */
/*  Core API (implemented in lib/rbtree.cc)                           */
/* ------------------------------------------------------------------ */

#ifdef __cplusplus
extern "C" {
#endif

void rb_insert_color(struct rb_node *, struct rb_root *);
void rb_erase(struct rb_node *, struct rb_root *);

struct rb_node *rb_next(const struct rb_node *);
struct rb_node *rb_prev(const struct rb_node *);
struct rb_node *rb_first(const struct rb_root *);
struct rb_node *rb_last(const struct rb_root *);

struct rb_node *rb_first_postorder(const struct rb_root *);
struct rb_node *rb_next_postorder(const struct rb_node *);

void rb_replace_node(struct rb_node *victim, struct rb_node *_new,
		     struct rb_root *root);

#ifdef __cplusplus
}
#endif

/* ------------------------------------------------------------------ */
/*  Inline helpers                                                    */
/* ------------------------------------------------------------------ */

static inline void rb_link_node(struct rb_node *node, struct rb_node *parent,
				struct rb_node **rb_link)
{
	node->__rb_parent_color = (unsigned long)parent;
	node->rb_left = node->rb_right = nullptr;
	*rb_link = node;
}

#define rb_entry_safe(ptr, type, member) \
	({ __typeof__(ptr) ____ptr = (ptr); \
	   ____ptr ? rb_entry(____ptr, type, member) : nullptr; \
	})

/* ------------------------------------------------------------------ */
/*  Cached (leftmost) tree helpers                                    */
/* ------------------------------------------------------------------ */

#define rb_first_cached(root) (root)->rb_leftmost

static inline void rb_insert_color_cached(struct rb_node *node,
					  struct rb_root_cached *root,
					  bool leftmost)
{
	if (leftmost)
		root->rb_leftmost = node;
	rb_insert_color(node, &root->rb_root);
}

static inline void rb_erase_cached(struct rb_node *node,
				   struct rb_root_cached *root)
{
	if (root->rb_leftmost == node)
		root->rb_leftmost = rb_next(node);
	rb_erase(node, &root->rb_root);
}

static inline void rb_replace_node_cached(struct rb_node *victim,
					  struct rb_node *_new,
					  struct rb_root_cached *root)
{
	if (root->rb_leftmost == victim)
		root->rb_leftmost = _new;
	rb_replace_node(victim, _new, &root->rb_root);
}

static inline void rb_erase_init(struct rb_node *n, struct rb_root *root)
{
	rb_erase(n, root);
	RB_CLEAR_NODE(n);
}

/* ------------------------------------------------------------------ */
/*  Generic insert / find helpers (inline, using function pointers)   */
/* ------------------------------------------------------------------ */

static inline void
rb_add(struct rb_node *node, struct rb_root *tree,
       bool (*less)(struct rb_node *, const struct rb_node *))
{
	struct rb_node **link = &tree->rb_node;
	struct rb_node *parent = nullptr;

	while (*link) {
		parent = *link;
		if (less(node, parent))
			link = &parent->rb_left;
		else
			link = &parent->rb_right;
	}

	rb_link_node(node, parent, link);
	rb_insert_color(node, tree);
}

static inline void
rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
	      bool (*less)(struct rb_node *, const struct rb_node *))
{
	struct rb_node **link = &tree->rb_root.rb_node;
	struct rb_node *parent = nullptr;
	bool leftmost = true;

	while (*link) {
		parent = *link;
		if (less(node, parent)) {
			link = &parent->rb_left;
		} else {
			link = &parent->rb_right;
			leftmost = false;
		}
	}

	rb_link_node(node, parent, link);
	rb_insert_color_cached(node, tree, leftmost);
}

static inline struct rb_node *
rb_find(const void *key, const struct rb_root *tree,
	int (*cmp)(const void *key, const struct rb_node *))
{
	struct rb_node *node = tree->rb_node;

	while (node) {
		int c = cmp(key, node);
		if (c < 0)
			node = node->rb_left;
		else if (c > 0)
			node = node->rb_right;
		else
			return node;
	}
	return nullptr;
}

static inline struct rb_node *
rb_find_add(struct rb_node *node, struct rb_root *tree,
	    int (*cmp)(struct rb_node *, const struct rb_node *))
{
	struct rb_node **link = &tree->rb_node;
	struct rb_node *parent = nullptr;
	int c;

	while (*link) {
		parent = *link;
		c = cmp(node, parent);
		if (c < 0)
			link = &parent->rb_left;
		else if (c > 0)
			link = &parent->rb_right;
		else
			return parent;
	}

	rb_link_node(node, parent, link);
	rb_insert_color(node, tree);
	return nullptr;
}

/* ------------------------------------------------------------------ */
/*  Iteration macros                                                  */
/* ------------------------------------------------------------------ */

#define rbtree_postorder_for_each_entry_safe(pos, n, root, field) \
	for (pos = rb_entry_safe(rb_first_postorder(root), __typeof__(*pos), field); \
	     pos && ({ n = rb_entry_safe(rb_next_postorder(&pos->field), \
			__typeof__(*pos), field); 1; }); \
	     pos = n)

