/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Red-Black Tree type definitions
 * Adapted from Linux kernel include/linux/rbtree_types.h
 */

#pragma once

#include <lume/types.h>

struct rb_node {
	unsigned long  __rb_parent_color;
	struct rb_node *rb_right;
	struct rb_node *rb_left;
} __attribute__((aligned(sizeof(long))));

struct rb_root {
	struct rb_node *rb_node;
};

struct rb_root_cached {
	struct rb_root rb_root;
	struct rb_node *rb_leftmost;
};

#define RB_ROOT		(struct rb_root) { nullptr, }
#define RB_ROOT_CACHED	(struct rb_root_cached) { {nullptr, }, nullptr }

