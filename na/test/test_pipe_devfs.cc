/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_pipe_devfs.cc — Self-tests for pipe, /dev/null, /dev/zero, fcntl
 */

#include <lume/selftest.h>
#include <lume/errno.h>
#include <lume/file.h>
#include <lume/fs.h>
#include <lume/fs_types.h>
#include <lume/task.h>
#include <lume/fdtable.h>
#include <lume/pipe.h>

/* Syscall entry points */
int64 sys_openat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_close(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_read(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_write(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_pipe2(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_fcntl(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_fstat_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);

/* ================================================================== */
/*  Helpers                                                           */
/* ================================================================== */

static int64 open_dev(const char* path, int flags)
{
    return sys_openat(
        static_cast<uint64>(-100),  /* AT_FDCWD */
        reinterpret_cast<uint64>(path),
        static_cast<uint64>(flags),
        0, 0, 0);
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

static int64 do_write(int64 fd, const void* buf, uint64 count)
{
    return sys_write(static_cast<uint64>(fd),
                     reinterpret_cast<uint64>(buf), count, 0, 0, 0);
}

/* fcntl command constants — must match sys_fs.cc */
inline constexpr int F_DUPFD         = 0;
inline constexpr int F_GETFD         = 1;
inline constexpr int F_SETFD         = 2;
inline constexpr int F_GETFL         = 3;
inline constexpr int F_SETFL         = 4;
inline constexpr int F_DUPFD_CLOEXEC = 1030;
inline constexpr int FD_CLOEXEC      = 1;

/* ================================================================== */
/*  /dev/null tests                                                   */
/* ================================================================== */

void selftest_devfs()
{
    /* ---- /dev/null: read returns EOF ---- */
    st_begin("devfs: /dev/null read returns 0 (EOF)");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        char buf[16];
        int64 n = do_read(fd, buf, sizeof(buf));
        ST_ASSERT_EQ(n, (int64)0);
        do_close(fd);
    }
    st_pass();

    /* ---- /dev/null: write discards data ---- */
    st_begin("devfs: /dev/null write discards data");
    {
        int64 fd = open_dev("/dev/null", O_WRONLY);
        ST_ASSERT(fd >= 0);

        const char* msg = "discarded";
        int64 n = do_write(fd, msg, 9);
        ST_ASSERT_EQ(n, (int64)9);
        do_close(fd);
    }
    st_pass();

    /* ---- /dev/null: fstat reports S_IFCHR ---- */
    st_begin("devfs: /dev/null fstat is S_IFCHR");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        kstat st{};
        int64 ret = sys_fstat_wrapper(
            static_cast<uint64>(fd),
            reinterpret_cast<uint64>(&st), 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);
        ST_ASSERT(S_ISCHR(st.st_mode));
        do_close(fd);
    }
    st_pass();

    /* ---- /dev/zero: read returns zeros ---- */
    st_begin("devfs: /dev/zero read returns zeros");
    {
        int64 fd = open_dev("/dev/zero", O_RDONLY);
        ST_ASSERT(fd >= 0);

        char buf[32];
        /* Pre-fill with non-zero */
        for (int i = 0; i < 32; i++) buf[i] = 0xFF;

        int64 n = do_read(fd, buf, 32);
        ST_ASSERT_EQ(n, (int64)32);

        bool all_zero = true;
        for (int i = 0; i < 32; i++) {
            if (buf[i] != 0) { all_zero = false; break; }
        }
        ST_ASSERT(all_zero);
        do_close(fd);
    }
    st_pass();

    /* ---- /dev/zero: write discards data ---- */
    st_begin("devfs: /dev/zero write discards data");
    {
        int64 fd = open_dev("/dev/zero", O_WRONLY);
        ST_ASSERT(fd >= 0);

        char buf[16] = {1, 2, 3};
        int64 n = do_write(fd, buf, 16);
        ST_ASSERT_EQ(n, (int64)16);
        do_close(fd);
    }
    st_pass();
}

/* ================================================================== */
/*  Pipe tests                                                        */
/* ================================================================== */

void selftest_pipe()
{
    /* ---- pipe2: basic creation ---- */
    st_begin("pipe: pipe2 creates two valid fds");
    {
        int fds[2] = {-1, -1};
        int64 ret = sys_pipe2(
            reinterpret_cast<uint64>(fds), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);
        ST_ASSERT(fds[0] >= 0);
        ST_ASSERT(fds[1] >= 0);
        ST_ASSERT_NE(fds[0], fds[1]);

        do_close(fds[0]);
        do_close(fds[1]);
    }
    st_pass();

    /* ---- pipe: write then read ---- */
    st_begin("pipe: write then read returns correct data");
    {
        int fds[2];
        sys_pipe2(reinterpret_cast<uint64>(fds), 0, 0, 0, 0, 0);

        const char* msg = "pipe_test";
        int64 w = do_write(fds[1], msg, 9);
        ST_ASSERT_EQ(w, (int64)9);

        char buf[16] = {};
        int64 r = do_read(fds[0], buf, 16);
        ST_ASSERT_EQ(r, (int64)9);

        bool match = true;
        for (int i = 0; i < 9; i++) {
            if (buf[i] != msg[i]) { match = false; break; }
        }
        ST_ASSERT(match);

        do_close(fds[0]);
        do_close(fds[1]);
    }
    st_pass();

    /* ---- pipe: read from closed write end returns EOF ---- */
    st_begin("pipe: read after writer close returns EOF");
    {
        int fds[2];
        sys_pipe2(reinterpret_cast<uint64>(fds), 0, 0, 0, 0, 0);

        /* Write some data, then close write end */
        const char* msg = "eof";
        do_write(fds[1], msg, 3);
        do_close(fds[1]);

        /* Read the data */
        char buf[16];
        int64 r1 = do_read(fds[0], buf, 16);
        ST_ASSERT_EQ(r1, (int64)3);

        /* Next read should return 0 (EOF) */
        int64 r2 = do_read(fds[0], buf, 16);
        ST_ASSERT_EQ(r2, (int64)0);

        do_close(fds[0]);
    }
    st_pass();

    /* ---- pipe: write to closed read end returns -EPIPE ---- */
    st_begin("pipe: write after reader close returns -EPIPE");
    {
        int fds[2];
        sys_pipe2(reinterpret_cast<uint64>(fds), 0, 0, 0, 0, 0);

        /* Close read end */
        do_close(fds[0]);

        /* Write should fail */
        const char* msg = "broken";
        int64 w = do_write(fds[1], msg, 6);
        ST_ASSERT_EQ(w, (int64)-EPIPE);

        do_close(fds[1]);
    }
    st_pass();

    /* ---- pipe: multiple writes accumulate ---- */
    st_begin("pipe: multiple writes accumulate in buffer");
    {
        int fds[2];
        sys_pipe2(reinterpret_cast<uint64>(fds), 0, 0, 0, 0, 0);

        do_write(fds[1], "AAA", 3);
        do_write(fds[1], "BBB", 3);

        char buf[16] = {};
        int64 r = do_read(fds[0], buf, 16);
        ST_ASSERT_EQ(r, (int64)6);
        ST_ASSERT_EQ(buf[0], 'A');
        ST_ASSERT_EQ(buf[3], 'B');

        do_close(fds[0]);
        do_close(fds[1]);
    }
    st_pass();

    /* ---- pipe: read partial ---- */
    st_begin("pipe: partial read leaves remainder");
    {
        int fds[2];
        sys_pipe2(reinterpret_cast<uint64>(fds), 0, 0, 0, 0, 0);

        do_write(fds[1], "ABCDEF", 6);

        char buf[3] = {};
        int64 r1 = do_read(fds[0], buf, 3);
        ST_ASSERT_EQ(r1, (int64)3);
        ST_ASSERT_EQ(buf[0], 'A');
        ST_ASSERT_EQ(buf[2], 'C');

        int64 r2 = do_read(fds[0], buf, 3);
        ST_ASSERT_EQ(r2, (int64)3);
        ST_ASSERT_EQ(buf[0], 'D');
        ST_ASSERT_EQ(buf[2], 'F');

        do_close(fds[0]);
        do_close(fds[1]);
    }
    st_pass();
}

/* ================================================================== */
/*  fcntl tests                                                       */
/* ================================================================== */

void selftest_fcntl()
{
    /* ---- fcntl F_DUPFD ---- */
    st_begin("fcntl: F_DUPFD duplicates fd");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        int64 fd2 = sys_fcntl(static_cast<uint64>(fd), F_DUPFD, 0, 0, 0, 0);
        ST_ASSERT(fd2 >= 0);
        ST_ASSERT_NE(fd, fd2);

        /* Both should be valid reads */
        char buf[4];
        int64 r = do_read(fd2, buf, 4);
        ST_ASSERT_EQ(r, (int64)0);  /* /dev/null → EOF */

        do_close(fd);
        do_close(fd2);
    }
    st_pass();

    /* ---- fcntl F_DUPFD with min_fd ---- */
    st_begin("fcntl: F_DUPFD respects min_fd");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        int64 fd2 = sys_fcntl(static_cast<uint64>(fd), F_DUPFD, 100, 0, 0, 0);
        ST_ASSERT(fd2 >= 100);

        do_close(fd);
        do_close(fd2);
    }
    st_pass();

    /* ---- fcntl F_GETFD / F_SETFD ---- */
    st_begin("fcntl: F_GETFD/F_SETFD cloexec");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        /* Initially no CLOEXEC */
        int64 flags = sys_fcntl(static_cast<uint64>(fd), F_GETFD, 0, 0, 0, 0);
        ST_ASSERT_EQ(flags, (int64)0);

        /* Set CLOEXEC */
        int64 ret = sys_fcntl(static_cast<uint64>(fd), F_SETFD, FD_CLOEXEC, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);

        /* Verify it was set */
        flags = sys_fcntl(static_cast<uint64>(fd), F_GETFD, 0, 0, 0, 0);
        ST_ASSERT_EQ(flags, (int64)FD_CLOEXEC);

        /* Clear it */
        sys_fcntl(static_cast<uint64>(fd), F_SETFD, 0, 0, 0, 0);
        flags = sys_fcntl(static_cast<uint64>(fd), F_GETFD, 0, 0, 0, 0);
        ST_ASSERT_EQ(flags, (int64)0);

        do_close(fd);
    }
    st_pass();

    /* ---- fcntl F_GETFL ---- */
    st_begin("fcntl: F_GETFL returns open flags");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        int64 fl = sys_fcntl(static_cast<uint64>(fd), F_GETFL, 0, 0, 0, 0);
        /* O_RDONLY == 0, so result should have no write bits */
        ST_ASSERT_EQ(fl & O_WRONLY, (int64)0);

        do_close(fd);
    }
    st_pass();

    /* ---- fcntl F_SETFL O_NONBLOCK ---- */
    st_begin("fcntl: F_SETFL toggles O_NONBLOCK");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        /* Set O_NONBLOCK */
        sys_fcntl(static_cast<uint64>(fd), F_SETFL, O_NONBLOCK, 0, 0, 0);
        int64 fl = sys_fcntl(static_cast<uint64>(fd), F_GETFL, 0, 0, 0, 0);
        ST_ASSERT(fl & O_NONBLOCK);

        /* Clear it */
        sys_fcntl(static_cast<uint64>(fd), F_SETFL, 0, 0, 0, 0);
        fl = sys_fcntl(static_cast<uint64>(fd), F_GETFL, 0, 0, 0, 0);
        ST_ASSERT_EQ(fl & O_NONBLOCK, (int64)0);

        do_close(fd);
    }
    st_pass();

    /* ---- fcntl F_DUPFD_CLOEXEC ---- */
    st_begin("fcntl: F_DUPFD_CLOEXEC sets cloexec");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        int64 fd2 = sys_fcntl(static_cast<uint64>(fd), F_DUPFD_CLOEXEC, 0, 0, 0, 0);
        ST_ASSERT(fd2 >= 0);

        int64 flags = sys_fcntl(static_cast<uint64>(fd2), F_GETFD, 0, 0, 0, 0);
        ST_ASSERT_EQ(flags, (int64)FD_CLOEXEC);

        do_close(fd);
        do_close(fd2);
    }
    st_pass();

    /* ---- fcntl bad fd ---- */
    st_begin("fcntl: bad fd returns -EBADF");
    {
        int64 ret = sys_fcntl(999, F_GETFD, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EBADF);
    }
    st_pass();

    /* ---- fcntl unknown cmd ---- */
    st_begin("fcntl: unknown cmd returns -EINVAL");
    {
        int64 fd = open_dev("/dev/null", O_RDONLY);
        ST_ASSERT(fd >= 0);

        int64 ret = sys_fcntl(static_cast<uint64>(fd), 9999, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EINVAL);
        do_close(fd);
    }
    st_pass();
}
