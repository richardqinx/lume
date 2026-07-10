/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <lume/selftest.h>
#include <lume/rbtree.h>

struct TestNode {
    int key;
    struct rb_node rb;
};

static bool node_less(struct rb_node *node, const struct rb_node *parent) {
    TestNode *n = rb_entry(node, TestNode, rb);
    const TestNode *p = reinterpret_cast<const TestNode*>(
        reinterpret_cast<const char*>(parent) - __builtin_offsetof(TestNode, rb));
    return n->key < p->key;
}

static int node_cmp(const void *key, const struct rb_node *node) {
    int k = *static_cast<const int*>(key);
    const TestNode *n = reinterpret_cast<const TestNode*>(
        reinterpret_cast<const char*>(node) - __builtin_offsetof(TestNode, rb));
    if (k < n->key) return -1;
    if (k > n->key) return 1;
    return 0;
}

void selftest_rbtree() {
    st_begin("rbtree: basic insert, find, erase");
    {
        struct rb_root tree = RB_ROOT;
        TestNode n1{10, {}}, n2{20, {}}, n3{5, {}};
        
        rb_add(&n1.rb, &tree, node_less);
        rb_add(&n2.rb, &tree, node_less);
        rb_add(&n3.rb, &tree, node_less);
        
        int search_key = 20;
        struct rb_node *found = rb_find(&search_key, &tree, node_cmp);
        ST_ASSERT(found == &n2.rb);
        
        search_key = 99;
        found = rb_find(&search_key, &tree, node_cmp);
        ST_ASSERT(found == nullptr);
        
        rb_erase(&n2.rb, &tree);
        // Verify erased
        search_key = 20;
        found = rb_find(&search_key, &tree, node_cmp);
        ST_ASSERT(found == nullptr);
    }
    st_pass();

    st_begin("rbtree: ordered iteration");
    {
        struct rb_root tree = RB_ROOT;
        TestNode nodes[5] = { {50, {}}, {10, {}}, {40, {}}, {20, {}}, {30, {}} };
        for (int i=0; i<5; i++) {
            rb_add(&nodes[i].rb, &tree, node_less);
        }
        
        int expected[] = {10, 20, 30, 40, 50};
        int idx = 0;
        struct rb_node *node = rb_first(&tree);
        while (node) {
            TestNode *n = rb_entry(node, TestNode, rb);
            ST_ASSERT_EQ(n->key, expected[idx]);
            idx++;
            node = rb_next(node);
        }
        ST_ASSERT_EQ(idx, 5);
    }
    st_pass();

    st_begin("rbtree: large scale insert/erase balance");
    {
        struct rb_root tree = RB_ROOT;
        constexpr int N = 200;
        static TestNode nodes[N]; // Static to avoid blowing up the BSP stack
        for (int i=0; i<N; i++) {
            nodes[i].key = (i * 17) % N; // Pseudo-random insertions
            rb_add(&nodes[i].rb, &tree, node_less);
        }
        
        int c = 0;
        for (struct rb_node *n = rb_first(&tree); n; n = rb_next(n)) c++;
        ST_ASSERT_EQ(c, N);
        
        for (int i=0; i<N; i+=2) {
            rb_erase(&nodes[i].rb, &tree);
        }
        c = 0;
        for (struct rb_node *n = rb_first(&tree); n; n = rb_next(n)) c++;
        ST_ASSERT_EQ(c, N / 2);
    }
    st_pass();

    st_begin("rbtree: empty tree operations");
    {
        struct rb_root tree = RB_ROOT;
        ST_ASSERT(RB_EMPTY_ROOT(&tree));
        ST_ASSERT(rb_first(&tree) == nullptr);
        ST_ASSERT(rb_last(&tree) == nullptr);
    }
    st_pass();

    st_begin("rbtree: rb_erase_init after effects");
    {
        struct rb_root tree = RB_ROOT;
        TestNode n1{100, {}};
        rb_add(&n1.rb, &tree, node_less);
        ST_ASSERT(!RB_EMPTY_NODE(&n1.rb));
        
        rb_erase_init(&n1.rb, &tree);
        ST_ASSERT(RB_EMPTY_NODE(&n1.rb));
        ST_ASSERT(RB_EMPTY_ROOT(&tree));
    }
    st_pass();
}
