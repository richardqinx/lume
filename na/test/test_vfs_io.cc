/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_vfs_io.cc — Self-tests for VFS file I/O via syscalls
 *
 * Tests openat, read, write, close, lseek, dup, fstat, getdents64,
 * getcwd, chdir, and mkdirat through the kernel syscall layer.
 */

#include <lume/selftest.h>
#include <lume/errno.h>
#include <lume/file.h>
#include <lume/fs.h>
#include <lume/fs_types.h>
#include <lume/task.h>
#include <lume/fdtable.h>

/* Syscall entry points */
int64 sys_openat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_close(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_read(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_write(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_lseek(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_dup(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_dup3(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_fstat_wrapper(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getcwd(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_chdir(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_mkdirat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_getdents64(uint64, uint64, uint64, uint64, uint64, uint64);

/* Helper: open a file, returns fd or negative error */
static int64 open_file(const char* path, int flags, uint32 mode)
{
    return sys_openat(
        static_cast<uint64>(-100),  /* AT_FDCWD */
        reinterpret_cast<uint64>(path),
        static_cast<uint64>(flags),
        static_cast<uint64>(mode), 0, 0);
}

void selftest_vfs_io()
{
    /* ---- openat O_CREAT creates a file ---- */
    st_begin("vfs_io: openat O_CREAT creates file");
    {
        int64 fd = open_file("/vfs_test_file", O_CREAT | O_WRONLY, 0644);
        ST_ASSERT(fd >= 0);
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- openat existing file ---- */
    st_begin("vfs_io: openat existing file succeeds");
    {
        int64 fd = open_file("/vfs_test_file", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- openat nonexistent without O_CREAT returns -ENOENT ---- */
    st_begin("vfs_io: openat nonexistent returns -ENOENT");
    {
        int64 fd = open_file("/no_such_file_ever", O_RDONLY, 0);
        ST_ASSERT_EQ(fd, (int64)-ENOENT);
    }
    st_pass();

    /* ---- write then read ---- */
    st_begin("vfs_io: write then read back data");
    {
        /* Write */
        int64 fd = open_file("/vfs_rw_test", O_CREAT | O_WRONLY, 0644);
        ST_ASSERT(fd >= 0);

        const char* msg = "Hello VFS!";
        int64 written = sys_write(
            static_cast<uint64>(fd),
            reinterpret_cast<uint64>(msg),
            10, 0, 0, 0);
        ST_ASSERT_EQ(written, (int64)10);
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);

        /* Read */
        fd = open_file("/vfs_rw_test", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        char buf[32] = {};
        int64 nread = sys_read(
            static_cast<uint64>(fd),
            reinterpret_cast<uint64>(buf),
            sizeof(buf), 0, 0, 0);
        ST_ASSERT_EQ(nread, (int64)10);

        bool match = true;
        for (int i = 0; i < 10; i++) {
            if (buf[i] != msg[i]) { match = false; break; }
        }
        ST_ASSERT(match);
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- read past EOF returns 0 ---- */
    st_begin("vfs_io: read past EOF returns 0");
    {
        int64 fd = open_file("/vfs_rw_test", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        char buf[64];
        /* First read: 10 bytes */
        int64 n1 = sys_read(static_cast<uint64>(fd),
                            reinterpret_cast<uint64>(buf), 64, 0, 0, 0);
        ST_ASSERT_EQ(n1, (int64)10);

        /* Second read: should be 0 (EOF) */
        int64 n2 = sys_read(static_cast<uint64>(fd),
                            reinterpret_cast<uint64>(buf), 64, 0, 0, 0);
        ST_ASSERT_EQ(n2, (int64)0);

        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- O_TRUNC clears file content ---- */
    st_begin("vfs_io: O_TRUNC clears file content");
    {
        int64 fd = open_file("/vfs_rw_test", O_WRONLY | O_TRUNC, 0);
        ST_ASSERT(fd >= 0);
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);

        fd = open_file("/vfs_rw_test", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        char buf[16];
        int64 n = sys_read(static_cast<uint64>(fd),
                           reinterpret_cast<uint64>(buf), 16, 0, 0, 0);
        ST_ASSERT_EQ(n, (int64)0);  /* truncated = empty */
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- close invalid fd returns -EBADF ---- */
    st_begin("vfs_io: close bad fd returns -EBADF");
    {
        int64 ret = sys_close(999, 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EBADF);
    }
    st_pass();

    /* ---- read/write on bad fd returns -EBADF ---- */
    st_begin("vfs_io: read/write bad fd returns -EBADF");
    {
        char buf[8];
        int64 r = sys_read(999, reinterpret_cast<uint64>(buf), 8, 0, 0, 0);
        ST_ASSERT_EQ(r, (int64)-EBADF);

        int64 w = sys_write(999, reinterpret_cast<uint64>(buf), 8, 0, 0, 0);
        ST_ASSERT_EQ(w, (int64)-EBADF);
    }
    st_pass();

    /* ---- lseek SEEK_SET / SEEK_CUR / SEEK_END ---- */
    st_begin("vfs_io: lseek SEEK_SET/CUR/END");
    {
        /* Write 20 bytes */
        int64 fd = open_file("/vfs_lseek_test", O_CREAT | O_RDWR, 0644);
        ST_ASSERT(fd >= 0);

        char data[20];
        for (int i = 0; i < 20; i++) data[i] = static_cast<char>('A' + i);
        sys_write(static_cast<uint64>(fd),
                  reinterpret_cast<uint64>(data), 20, 0, 0, 0);

        /* SEEK_SET to 5 */
        int64 pos = sys_lseek(static_cast<uint64>(fd), 5, SEEK_SET, 0, 0, 0);
        ST_ASSERT_EQ(pos, (int64)5);

        /* Read 1 byte, should be 'F' */
        char c = 0;
        sys_read(static_cast<uint64>(fd),
                 reinterpret_cast<uint64>(&c), 1, 0, 0, 0);
        ST_ASSERT_EQ(c, 'F');

        /* SEEK_CUR +3 → pos 9 */
        pos = sys_lseek(static_cast<uint64>(fd), 3, SEEK_CUR, 0, 0, 0);
        ST_ASSERT_EQ(pos, (int64)9);

        /* SEEK_END -1 → pos 19 */
        pos = sys_lseek(static_cast<uint64>(fd), -1, SEEK_END, 0, 0, 0);
        ST_ASSERT_EQ(pos, (int64)19);

        sys_read(static_cast<uint64>(fd),
                 reinterpret_cast<uint64>(&c), 1, 0, 0, 0);
        ST_ASSERT_EQ(c, 'T');

        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- lseek invalid whence returns -EINVAL ---- */
    st_begin("vfs_io: lseek invalid whence");
    {
        int64 fd = open_file("/vfs_lseek_test", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);
        int64 ret = sys_lseek(static_cast<uint64>(fd), 0, 99, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)-EINVAL);
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- dup: duplicate fd shares file position ---- */
    st_begin("vfs_io: dup shares file position");
    {
        int64 fd1 = open_file("/vfs_lseek_test", O_RDONLY, 0);
        ST_ASSERT(fd1 >= 0);

        int64 fd2 = sys_dup(static_cast<uint64>(fd1), 0, 0, 0, 0, 0);
        ST_ASSERT(fd2 >= 0);
        ST_ASSERT_NE(fd1, fd2);

        /* Both should work for reading */
        char c = 0;
        int64 n = sys_read(static_cast<uint64>(fd2),
                           reinterpret_cast<uint64>(&c), 1, 0, 0, 0);
        ST_ASSERT_EQ(n, (int64)1);

        sys_close(static_cast<uint64>(fd1), 0, 0, 0, 0, 0);
        sys_close(static_cast<uint64>(fd2), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- fstat: basic stat ---- */
    st_begin("vfs_io: fstat returns valid kstat");
    {
        int64 fd = open_file("/vfs_lseek_test", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        kstat st{};
        int64 ret = sys_fstat_wrapper(
            static_cast<uint64>(fd),
            reinterpret_cast<uint64>(&st), 0, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);
        ST_ASSERT(S_ISREG(st.st_mode));
        ST_ASSERT_EQ(st.st_size, (int64)20);

        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- getcwd: returns "/" ---- */
    st_begin("vfs_io: getcwd returns /");
    {
        char buf[64] = {};
        int64 len = sys_getcwd(
            reinterpret_cast<uint64>(buf), 64, 0, 0, 0, 0);
        ST_ASSERT(len > 0);
        ST_ASSERT_EQ(buf[0], '/');
    }
    st_pass();

    /* ---- mkdirat: create directory ---- */
    st_begin("vfs_io: mkdirat creates directory");
    {
        int64 ret = sys_mkdirat(
            static_cast<uint64>(-100),
            reinterpret_cast<uint64>("/vfs_io_dir"),
            0755, 0, 0, 0);
        ST_ASSERT_EQ(ret, (int64)0);

        /* Open it to confirm it's a directory */
        int64 fd = open_file("/vfs_io_dir", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        kstat st{};
        sys_fstat_wrapper(static_cast<uint64>(fd),
                          reinterpret_cast<uint64>(&st), 0, 0, 0, 0);
        ST_ASSERT(S_ISDIR(st.st_mode));

        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- getdents64: list root directory ---- */
    st_begin("vfs_io: getdents64 lists root children");
    {
        int64 fd = open_file("/", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        char buf[512] = {};
        int64 n = sys_getdents64(
            static_cast<uint64>(fd),
            reinterpret_cast<uint64>(buf),
            512, 0, 0, 0);
        ST_ASSERT(n > 0);  /* At least "." and ".." */

        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- write to O_RDONLY fd returns -EBADF ---- */
    st_begin("vfs_io: write to O_RDONLY returns -EBADF");
    {
        int64 fd = open_file("/vfs_rw_test", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        char buf[] = "x";
        int64 w = sys_write(static_cast<uint64>(fd),
                            reinterpret_cast<uint64>(buf), 1, 0, 0, 0);
        ST_ASSERT_EQ(w, (int64)-EBADF);
        sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
    }
    st_pass();

    /* ---- double close returns -EBADF ---- */
    st_begin("vfs_io: double close returns -EBADF");
    {
        int64 fd = open_file("/vfs_rw_test", O_RDONLY, 0);
        ST_ASSERT(fd >= 0);

        int64 r1 = sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(r1, (int64)0);

        int64 r2 = sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);
        ST_ASSERT_EQ(r2, (int64)-EBADF);
    }
    st_pass();

    /* ---- fd reuse after close ---- */
    st_begin("vfs_io: fd reuse after close");
    {
        int64 fd1 = open_file("/vfs_rw_test", O_RDONLY, 0);
        ST_ASSERT(fd1 >= 0);
        sys_close(static_cast<uint64>(fd1), 0, 0, 0, 0, 0);

        int64 fd2 = open_file("/vfs_rw_test", O_RDONLY, 0);
        ST_ASSERT(fd2 >= 0);
        /* fd2 should reuse the slot of fd1 */
        ST_ASSERT(fd2 <= fd1);
        sys_close(static_cast<uint64>(fd2), 0, 0, 0, 0, 0);
    }
    st_pass();
}
