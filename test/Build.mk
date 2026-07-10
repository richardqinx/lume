targets += test/kernel
target.test/kernel.kind := kernel-test
target.test/kernel.sources := \
    test/selftest.cc test/test_pmm.cc test/test_slab.cc test/test_spinlock.cc \
    test/test_mutex.cc test/test_driver_model.cc test/test_rbtree.cc \
    test/test_vmm.cc test/test_vma.cc test/test_atomic.cc test/test_fdt.cc \
    test/test_trap.cc test/test_sched.cc test/test_klog.cc test/test_random.cc \
    test/test_waitqueue.cc test/test_uaccess.cc test/test_sys_mm.cc \
    test/test_smp.cc test/test_dcache.cc test/test_namei.cc \
    test/test_vfs_io.cc test/test_exec.cc test/test_pipe_devfs.cc \
    test/test_sys_process.cc test/test_signal.cc test/test_pid.cc \
    test/test_sys_fs_extra.cc test/test_page_cache.cc
