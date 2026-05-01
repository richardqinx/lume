/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Red-Black Trees — augmented operations & internal helpers
 * Adapted from Linux kernel include/linux/rbtree_augmented.h
 *
 * (C) 1999  Andrea Arcangeli <andrea@suse.de>
 * (C) 2002  David Woodhouse <dwmw2@infradead.org>
 * (C) 2012  Michel Lespinasse <walken@google.com>
 */

#pragma once

#include <lume/rbtree.h>

/* ------------------------------------------------------------------ */
/*  Augmented callback structure                                      */
/* ------------------------------------------------------------------ */

struct rb_augment_callbacks {
	void (*propagate)(struct rb_node *node, struct rb_node *stop);
	void (*copy)(struct rb_node *old, struct rb_node *_new);
	void (*rotate)(struct rb_node *old, struct rb_node *_new);
};

extern "C" void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
	void (*augment_rotate)(struct rb_node *old, struct rb_node *_new));

extern "C" void __rb_erase_color(struct rb_node *parent, struct rb_root *root,
	void (*augment_rotate)(struct rb_node *old, struct rb_node *_new));

static inline void
rb_insert_augmented(struct rb_node *node, struct rb_root *root,
		    const struct rb_augment_callbacks *augment)
{
	__rb_insert_augmented(node, root, augment->rotate);
}

static inline void
rb_insert_augmented_cached(struct rb_node *node,
			   struct rb_root_cached *root, bool newleft,
			   const struct rb_augment_callbacks *augment)
{
	if (newleft)
		root->rb_leftmost = node;
	rb_insert_augmented(node, &root->rb_root, augment);
}

/* ------------------------------------------------------------------ */
/*  Color / parent encoding helpers                                   */
/* ------------------------------------------------------------------ */

#define RB_RED		0
#define RB_BLACK	1

#define __rb_parent(pc)    ((struct rb_node *)(pc & ~3UL))

#define __rb_color(pc)     ((pc) & 1)
#define __rb_is_black(pc)  __rb_color(pc)
#define __rb_is_red(pc)    (!__rb_color(pc))
#define rb_color(rb)       __rb_color((rb)->__rb_parent_color)
#define rb_is_red(rb)      __rb_is_red((rb)->__rb_parent_color)
#define rb_is_black(rb)    __rb_is_black((rb)->__rb_parent_color)

static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
{
	rb->__rb_parent_color = rb_color(rb) + (unsigned long)p;
}

static inline void rb_set_parent_color(struct rb_node *rb,
				       struct rb_node *p, int color)
{
	rb->__rb_parent_color = (unsigned long)p + color;
}

static inline void
__rb_change_child(struct rb_node *old, struct rb_node *_new,
		  struct rb_node *parent, struct rb_root *root)
{
	if (parent) {
		if (parent->rb_left == old)
			WRITE_ONCE(parent->rb_left, _new);
		else
			WRITE_ONCE(parent->rb_right, _new);
	} else
		WRITE_ONCE(root->rb_node, _new);
}

/* ------------------------------------------------------------------ */
/*  Augmented erase (inline)                                          */
/* ------------------------------------------------------------------ */

static __always_inline struct rb_node *
__rb_erase_augmented(struct rb_node *node, struct rb_root *root,
		     const struct rb_augment_callbacks *augment)
{
	struct rb_node *child = node->rb_right;
	struct rb_node *tmp = node->rb_left;
	struct rb_node *parent, *rebalance;
	unsigned long pc;

	if (!tmp) {
		/*
		 * Case 1: node to erase has no more than 1 child (easy!)
		 */
		pc = node->__rb_parent_color;
		parent = __rb_parent(pc);
		__rb_change_child(node, child, parent, root);
		if (child) {
			child->__rb_parent_color = pc;
			rebalance = nullptr;
		} else
			rebalance = __rb_is_black(pc) ? parent : nullptr;
		tmp = parent;
	} else if (!child) {
		/* Still case 1, but this time the child is node->rb_left */
		tmp->__rb_parent_color = pc = node->__rb_parent_color;
		parent = __rb_parent(pc);
		__rb_change_child(node, tmp, parent, root);
		rebalance = nullptr;
		tmp = parent;
	} else {
		struct rb_node *successor = child, *child2;

		tmp = child->rb_left;
		if (!tmp) {
			/*
			 * Case 2: node's successor is its right child
			 */
			parent = successor;
			child2 = successor->rb_right;

			augment->copy(node, successor);
		} else {
			/*
			 * Case 3: node's successor is leftmost under
			 * node's right child subtree
			 */
			do {
				parent = successor;
				successor = tmp;
				tmp = tmp->rb_left;
			} while (tmp);
			child2 = successor->rb_right;
			WRITE_ONCE(parent->rb_left, child2);
			WRITE_ONCE(successor->rb_right, child);
			rb_set_parent(child, successor);

			augment->copy(node, successor);
			augment->propagate(parent, successor);
		}

		tmp = node->rb_left;
		WRITE_ONCE(successor->rb_left, tmp);
		rb_set_parent(tmp, successor);

		pc = node->__rb_parent_color;
		tmp = __rb_parent(pc);
		__rb_change_child(node, successor, tmp, root);

		if (child2) {
			rb_set_parent_color(child2, parent, RB_BLACK);
			rebalance = nullptr;
		} else {
			rebalance = rb_is_black(successor) ? parent : nullptr;
		}
		successor->__rb_parent_color = pc;
		tmp = successor;
	}

	augment->propagate(tmp, nullptr);
	return rebalance;
}

static __always_inline void
rb_erase_augmented(struct rb_node *node, struct rb_root *root,
		   const struct rb_augment_callbacks *augment)
{
	struct rb_node *rebalance = __rb_erase_augmented(node, root, augment);
	if (rebalance)
		__rb_erase_color(rebalance, root, augment->rotate);
}

static __always_inline void
rb_erase_augmented_cached(struct rb_node *node, struct rb_root_cached *root,
			  const struct rb_augment_callbacks *augment)
{
	if (root->rb_leftmost == node)
		root->rb_leftmost = rb_next(node);
	rb_erase_augmented(node, &root->rb_root, augment);
}

/* ------------------------------------------------------------------ */
/*  Augmented callback declaration macros                             */
/* ------------------------------------------------------------------ */

#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,				\
			     RBSTRUCT, RBFIELD, RBAUGMENTED, RBCOMPUTE)	\
static inline void							\
RBNAME ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
{									\
	while (rb != stop) {						\
		RBSTRUCT *node = rb_entry(rb, RBSTRUCT, RBFIELD);	\
		if (RBCOMPUTE(node, true))				\
			break;						\
		rb = rb_parent(&node->RBFIELD);				\
	}								\
}									\
static inline void							\
RBNAME ## _copy(struct rb_node *rb_old, struct rb_node *rb_new)		\
{									\
	RBSTRUCT *old_ = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
	RBSTRUCT *new_ = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
	new_->RBAUGMENTED = old_->RBAUGMENTED;				\
}									\
static void								\
RBNAME ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
{									\
	RBSTRUCT *old_ = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
	RBSTRUCT *new_ = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
	new_->RBAUGMENTED = old_->RBAUGMENTED;				\
	RBCOMPUTE(old_, false);						\
}									\
RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
	RBNAME ## _propagate,						\
	RBNAME ## _copy,						\
	RBNAME ## _rotate						\
};

#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit_early)    \
{									      \
	RBSTRUCT *child;						      \
	RBTYPE max = RBCOMPUTE(node);					      \
	if (node->RBFIELD.rb_left) {					      \
		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
		if (child->RBAUGMENTED > max)				      \
			max = child->RBAUGMENTED;			      \
	}								      \
	if (node->RBFIELD.rb_right) {					      \
		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
		if (child->RBAUGMENTED > max)				      \
			max = child->RBAUGMENTED;			      \
	}								      \
	if (exit_early && node->RBAUGMENTED == max)			      \
		return true;						      \
	node->RBAUGMENTED = max;					      \
	return false;							      \
}									      \
RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
		     RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max)

