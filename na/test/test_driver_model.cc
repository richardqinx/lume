/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_driver_model — exercises kref, kobject, and the bus/device/driver
 * core.  Uses a dummy bus + dummy driver + dummy device so the test is
 * self-contained and doesn't depend on FDT/platform_device.
 */

#include <lume/selftest.h>
#include <lume/kref.h>
#include <lume/kobject.h>
#include <lume/device.h>

/* ------------------------------------------------------------------ */
/*  Test 1: kref get/put + release fires exactly once                  */
/* ------------------------------------------------------------------ */

namespace {

struct krefable {
    kref ref;
    int  release_count;
};

void krefable_release(kref* r)
{
    auto* k = container_of(r, krefable, ref);
    k->release_count++;
}

void test_kref()
{
    st_begin("kref: init/get/put");

    krefable k = {};
    kref_init(&k.ref);

    ST_ASSERT_EQ(kref_read(&k.ref), 1);

    kref_get(&k.ref);
    kref_get(&k.ref);
    ST_ASSERT_EQ(kref_read(&k.ref), 3);

    ST_ASSERT_EQ(kref_put(&k.ref, krefable_release), 0);
    ST_ASSERT_EQ(kref_put(&k.ref, krefable_release), 0);
    ST_ASSERT_EQ(k.release_count, 0);

    ST_ASSERT_EQ(kref_put(&k.ref, krefable_release), 1);
    ST_ASSERT_EQ(k.release_count, 1);

    st_pass();
}

/* ------------------------------------------------------------------ */
/*  Test 2: kobject parent/child + release on final put                */
/* ------------------------------------------------------------------ */

int g_child_released = 0;
int g_parent_released = 0;

void child_release(kobject*) { g_child_released++; }
void parent_release(kobject*) { g_parent_released++; }

const kobj_type child_ktype  = { .release = child_release };
const kobj_type parent_ktype = { .release = parent_release };

void test_kobject_hierarchy()
{
    st_begin("kobject: parent/child + ref counting");

    g_child_released = 0;
    g_parent_released = 0;

    kobject parent;
    kobject_init(&parent, &parent_ktype);

    kobject child;
    kobject_init(&child, &child_ktype);
    kobject_add(&child, &parent, "child");

    /* Adding child took a ref on parent. */
    ST_ASSERT_EQ(kref_read(&parent.refcount), 2);
    ST_ASSERT(child.parent == &parent);

    /* Drop child's "added" reference — release should NOT fire because
     * we (the test) still hold the original kobject_init ref. */
    kobject_del(&child);
    ST_ASSERT(child.parent == nullptr);
    ST_ASSERT_EQ(kref_read(&parent.refcount), 1);
    ST_ASSERT_EQ(g_child_released, 0);
    ST_ASSERT_EQ(g_parent_released, 0);

    /* Drop final refs. */
    kobject_put(&child);
    ST_ASSERT_EQ(g_child_released, 1);

    kobject_put(&parent);
    ST_ASSERT_EQ(g_parent_released, 1);

    st_pass();
}

/* ------------------------------------------------------------------ */
/*  Test 3: bus / device / driver bind via match + probe               */
/* ------------------------------------------------------------------ */

struct dummy_dev   { device dev;  int probed; };
struct dummy_drv   { device_driver drv; const char* want; };

int g_probes = 0;

int dummy_match(device* dev, device_driver* drv)
{
    auto* dd = container_of(drv, dummy_drv, drv);
    return (dev->init_name != nullptr &&
            dd->want != nullptr &&
            __builtin_strcmp(dev->init_name, dd->want) == 0) ? 1 : 0;
}

int dummy_probe(device* dev)
{
    auto* dd = container_of(dev, dummy_dev, dev);
    dd->probed++;
    g_probes++;
    return 0;
}

bus_type dummy_bus = {
    .name       = "test_dummy",
    .match      = dummy_match,
    .probe      = nullptr,    /* fall through to drv->probe */
    .devices    = {},
    .drivers    = {},
    .lock       = {},
    .registered = false,
};

void test_bus_bind()
{
    st_begin("driver model: bus / driver / device bind");

    g_probes = 0;
    ST_ASSERT_EQ(bus_register(&dummy_bus), 0);

    /* Register driver before any matching device exists. */
    dummy_drv drv_a = {};
    drv_a.drv.name  = "drv_a";
    drv_a.drv.bus   = &dummy_bus;
    drv_a.drv.probe = dummy_probe;
    drv_a.want      = "compat_a";
    ST_ASSERT_EQ(driver_register(&drv_a.drv), 0);

    /* Register a device that should bind to drv_a immediately. */
    dummy_dev dev_a = {};
    dev_a.dev.bus       = &dummy_bus;
    dev_a.dev.init_name = "compat_a";
    ST_ASSERT_EQ(device_register(&dev_a.dev), 0);
    ST_ASSERT_EQ(dev_a.probed, 1);
    ST_ASSERT(dev_a.dev.driver == &drv_a.drv);

    /* Register a device first, then a driver — should also bind. */
    dummy_dev dev_b = {};
    dev_b.dev.bus       = &dummy_bus;
    dev_b.dev.init_name = "compat_b";
    ST_ASSERT_EQ(device_register(&dev_b.dev), 0);
    ST_ASSERT_EQ(dev_b.probed, 0);

    dummy_drv drv_b = {};
    drv_b.drv.name  = "drv_b";
    drv_b.drv.bus   = &dummy_bus;
    drv_b.drv.probe = dummy_probe;
    drv_b.want      = "compat_b";
    ST_ASSERT_EQ(driver_register(&drv_b.drv), 0);
    ST_ASSERT_EQ(dev_b.probed, 1);
    ST_ASSERT(dev_b.dev.driver == &drv_b.drv);

    /* Non-matching device sits unbound. */
    dummy_dev dev_c = {};
    dev_c.dev.bus       = &dummy_bus;
    dev_c.dev.init_name = "compat_unknown";
    ST_ASSERT_EQ(device_register(&dev_c.dev), 0);
    ST_ASSERT_EQ(dev_c.probed, 0);
    ST_ASSERT(dev_c.dev.driver == nullptr);

    ST_ASSERT_EQ(g_probes, 2);

    /* Cleanup. */
    device_unregister(&dev_a.dev);
    device_unregister(&dev_b.dev);
    device_unregister(&dev_c.dev);
    driver_unregister(&drv_a.drv);
    driver_unregister(&drv_b.drv);

    st_pass();
}

}  // namespace

/* ------------------------------------------------------------------ */
/*  Entry                                                              */
/* ------------------------------------------------------------------ */

void selftest_driver_model()
{
    test_kref();
    test_kobject_hierarchy();
    test_bus_bind();
}
