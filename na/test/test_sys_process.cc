/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_sys_process.cc — Self-tests for process-control syscalls
 *
 * Tests: getpid, gettid, getppid, getuid, getgid, set_tid_address,
 *        sched_yield, uname.
 */

#include <lume/selftest.h>
#include <lume/errno.h>
#include <lume/task.h>
#include <lume/types.h>

/* Syscall entry points */
int64 sys_getpid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_gettid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getppid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getuid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getgid(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_set_tid_address(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_sched_yield_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);

void selftest_sys_process()
{
    /* ---- getpid returns current tgid ---- */
    st_begin("sys_process: getpid returns valid pid");
    {
        int64 pid = sys_getpid(0, 0, 0, 0, 0, 0);
        /* Boot task pid is -1 but tgid may differ; just verify it returns */
        TaskControlBlock* curr = current_task();
        ST_ASSERT_EQ(pid, (int64)curr->tgid);
    }
    st_pass();

    /* ---- gettid returns current pid (tid) ---- */
    st_begin("sys_process: gettid returns current tid");
    {
        int64 tid = sys_gettid(0, 0, 0, 0, 0, 0);
        TaskControlBlock* curr = current_task();
        ST_ASSERT_EQ(tid, (int64)curr->pid);
    }
    st_pass();

    /* ---- getppid returns parent tgid ---- */
    st_begin("sys_process: getppid returns parent tgid");
    {
        int64 ppid = sys_getppid(0, 0, 0, 0, 0, 0);
        TaskControlBlock* curr = current_task();
        int64 expected = curr->parent ? (int64)curr->parent->tgid : 0;
        ST_ASSERT_EQ(ppid, expected);
    }
    st_pass();

    /* ---- getuid returns 0 (root) ---- */
    st_begin("sys_process: getuid returns 0 (root)");
    {
        int64 uid = sys_getuid(0, 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(uid, (int64)0);
    }
    st_pass();

    /* ---- getgid returns 0 (root) ---- */
    st_begin("sys_process: getgid returns 0 (root)");
    {
        int64 gid = sys_getgid(0, 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(gid, (int64)0);
    }
    st_pass();

    /* ---- set_tid_address stores pointer and returns tid ---- */
    st_begin("sys_process: set_tid_address returns tid");
    {
        uint64 dummy_addr = 0x12345678ULL;
        int64 tid = sys_set_tid_address(dummy_addr, 0, 0, 0, 0, 0);
        TaskControlBlock* curr = current_task();
        ST_ASSERT_EQ(tid, (int64)curr->pid);
        ST_ASSERT_EQ(curr->clear_child_tid, dummy_addr);

        /* Reset it to avoid side effects */
        curr->clear_child_tid = 0;
    }
    st_pass();

    /* ---- sched_yield returns 0 ---- */
    st_begin("sys_process: sched_yield returns 0");
    {
        int64 ret = sys_sched_yield_wrapper(0, 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);
    }
}

