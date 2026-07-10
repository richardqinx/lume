/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_sys_fs_extra.cc — Self-tests for additional filesystem syscalls
 *
 * Tests: dup3, chdir/getcwd, writev, ioctl (stub), unlinkat (stub).
 * Complements test_vfs_io.cc which covers the core read/write/open/close.
 */

#include <lume/selftest.h>
#include <lume/errno.h>
#include <lume/file.h>
#include <lume/fs.h>
#include <lume/fs_types.h>
#include <lume/task.h>

/* Syscall entry points */
int64 sys_openat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_close(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_read(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_write(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_dup3(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_chdir(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getcwd(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_writev(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_ioctl(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_unlinkat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_mkdirat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_lseek(uint64, uint64, uint64, uint64, uint64, uint64);

/* ================================================================== */
/*  Helpers                                                           */
/* ================================================================== */

static int64 open_dev(const char* path, int flags)
{
    return sys_openat(
        static_cast<uint64>(-100),
        reinterpret_cast<uint64>(path),
        static_cast<uint64>(flags), 0, 0, 0);
}

static int64 do_close(int64 fd)
{
    return sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
}

static int64 do_read(int64 fd, void* buf, uint64 count)
{
    return sys_read(static_cast<uint64>(fd),
                    reinterpret_cast<uint64>(buf), count, 0, 0, 0);
}


/* iovec must match sys_fs.cc definition */
struct test_iovec {
    void*   iov_base;
    uint64  iov_len;
};

/* ================================================================== */
/*  Tests                                                             */
/* ================================================================== */

void selftest_sys_fs_extra()
{
    /* ---- dup3: duplicate fd to specific target ---- */
    st_begin("sys_fs: dup3 duplicates to specific fd");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        /* dup3 to fd 50 */
        int64 fd2 = sys_dup3(static_cast<uint64>(fd), 50, 0, 0, 0, 0);
        ST_ASSERT_EQ(fd2, (int64)50);

        /* Both should work */
        char buf[4];
        int64 r = do_read(fd2, buf, 4);
        ST_ASSERT_EQ(r, (int64)0);  /* /dev/null → EOF */

        do_close(fd);
        do_close(fd2);
    }
    st_pass();

    /* ---- dup3: same fd returns -EINVAL ---- */
    st_begin("sys_fs: dup3 same fd returns -EINVAL");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        int64 ret = sys_dup3(static_cast<uint64>(fd),
                             static_cast<uint64>(fd), 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EINVAL);

        do_close(fd);
    }
    st_pass();

    /* ---- chdir to /dev, getcwd returns /dev ---- */
    st_begin("sys_fs: chdir then getcwd returns new dir");
    {
        /* Save cwd */
        char saved_cwd[64] = {};
        sys_getcwd(reinterpret_cast<uint64>(saved_cwd), 64, 0, 0, 0, 0);

        /* chdir to /dev */
        int64 ret = sys_chdir(
            reinterpret_cast<uint64>("/dev"), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);

        /* getcwd should return /dev */
        char buf[64] = {};
        int64 len = sys_getcwd(
            reinterpret_cast<uint64>(buf), 64, 0, 0, 0, 0);
        ST_ASSERT(len > 0);
        ST_ASSERT_EQ(buf[0], '/');
        ST_ASSERT_EQ(buf[1], 'd');
        ST_ASSERT_EQ(buf[2], 'e');
        ST_ASSERT_EQ(buf[3], 'v');

        /* Restore cwd to / */
        sys_chdir(reinterpret_cast<uint64>("/"), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- chdir to nonexistent returns -ENOENT ---- */
    st_begin("sys_fs: chdir nonexistent returns -ENOENT");
    {
        int64 ret = sys_chdir(
            reinterpret_cast<uint64>("/no_such_dir"), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-ENOENT);
    }
    st_pass();

    /* ---- chdir to file returns -ENOTDIR ---- */
    st_begin("sys_fs: chdir to file returns -ENOTDIR");
    {
        int64 ret = sys_chdir(
            reinterpret_cast<uint64>("/dev/null"), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-ENOTDIR);
    }
    st_pass();

    /* ---- writev: scatter write to file ---- */
    st_begin("sys_fs: writev scatter write");
    {
        /* Create a file, write with writev, read back */
        int64 fd = sys_openat(
            static_cast<uint64>(-100),
            reinterpret_cast<uint64>("/writev_test"),
            O_CREAT | O_RDWR, 0644, 0, 0);
        ST_ASSERT(fd >= 0);

        char a[] = "AAA";
        char b[] = "BBB";
        test_iovec iov[2];
        iov[0].iov_base = a;
        iov[0].iov_len = 3;
        iov[1].iov_base = b;
        iov[1].iov_len = 3;

        int64 w = sys_writev(
            static_cast<uint64>(fd),
            reinterpret_cast<uint64>(iov), 2, 0, 0, 0);
        ST_ASSERT_EQ(w, (int64)6);

        /* Seek back to start and read */
        sys_lseek(static_cast<uint64>(fd), 0, 0 /* SEEK_SET */, 0, 0, 0);

        char buf[8] = {};
        int64 r = do_read(fd, buf, 8);
        ST_ASSERT_EQ(r, (int64)6);
        ST_ASSERT_EQ(buf[0], 'A');
        ST_ASSERT_EQ(buf[3], 'B');

        do_close(fd);
    }
    st_pass();

    /* ---- writev: bad fd returns -EBADF ---- */
    st_begin("sys_fs: writev bad fd returns -EBADF");
    {
        test_iovec iov[1];
        char dummy[] = "x";
        iov[0].iov_base = dummy;
        iov[0].iov_len = 1;

        int64 ret = sys_writev(999,
            reinterpret_cast<uint64>(iov), 1, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EBADF);
    }
    st_pass();

    /* ---- ioctl stub returns -ENOTTY ---- */
    st_begin("sys_fs: ioctl stub returns -ENOTTY");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        int64 ret = sys_ioctl(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-ENOTTY);

        do_close(fd);
    }
    st_pass();

    /* ---- unlinkat stub returns -ENOSYS ---- */
    st_begin("sys_fs: unlinkat stub returns -ENOSYS");
    {
        int64 ret = sys_unlinkat(
            static_cast<uint64>(-100),
            reinterpret_cast<uint64>("/some_file"),
            0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-ENOSYS);
    }
    st_pass();

    /* ---- getcwd: null buf returns -EINVAL ---- */
    st_begin("sys_fs: getcwd null buf returns -EINVAL");
    {
        int64 ret = sys_getcwd(0, 64, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EINVAL);
    }
    st_pass();

    /* ---- getcwd: zero size returns -EINVAL ---- */
    st_begin("sys_fs: getcwd zero size returns -EINVAL");
    {
        char buf[4];
        int64 ret = sys_getcwd(
            reinterpret_cast<uint64>(buf), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EINVAL);
    }
    st_pass();
}
