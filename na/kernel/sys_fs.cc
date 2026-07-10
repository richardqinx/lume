/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * sys_fs.cc — Filesystem-related syscall handlers
 *
 * Implements: openat, close, read, write, lseek, fstat, getdents64,
 *             dup, dup3, getcwd, chdir, mkdirat, unlinkat
 */

#include <lume/syscall.h>
#include <lume/syscall_nr.h>
#include <lume/errno.h>
#include <lume/console.h>
#include <lume/task.h>
#include <lume/fs.h>
#include <lume/file.h>
#include <lume/dcache.h>
#include <lume/namei.h>
#include <lume/fdtable.h>
#include <lume/fs_struct.h>
#include <lume/mount.h>
#include <lume/fs_types.h>
#include <lume/klog.h>

/* ================================================================== */
/*  Helpers                                                           */
/* ================================================================== */

static files_struct* current_files()
{
    TaskControlBlock* t = current_task();
    return t ? t->files : nullptr;
}

static fs_struct* current_fs()
{
    TaskControlBlock* t = current_task();
    return t ? t->fs : nullptr;
}

/* ================================================================== */
/*  sys_openat(dirfd, pathname, flags, mode)                          */
/* ================================================================== */

int64 sys_openat(uint64 a0, uint64 a1, uint64 a2,
                 uint64 a3, uint64 /*a4*/, uint64 /*a5*/)
{
    int dirfd = static_cast<int>(a0);
    const char* pathname = reinterpret_cast<const char*>(a1);
    int flags = static_cast<int>(a2);
    uint32 mode = static_cast<uint32>(a3);

    files_struct* files = current_files();
    if (!files) return -EMFILE;


    /* Pathname lookup */
    path p{};
    int err = filename_lookup(dirfd, pathname, 0, &p);

    if (err == -ENOENT && (flags & O_CREAT)) {
        /* Create: look up the parent directory */
        /* Find last '/' to split parent path / filename */
        const char* last_slash = nullptr;
        for (const char* s = pathname; *s; s++) {
            if (*s == '/') last_slash = s;
        }

        if (!last_slash || last_slash == pathname) {
            /* File in root or current directory */
            path parent{};
            if (last_slash == pathname) {
                /* Absolute: parent is root */
                parent.de = g_root_dentry;
                parent.mnt = g_root_mnt;
            } else {
                /* Relative: parent is cwd */
                fs_struct* fs = current_fs();
                if (!fs) return -ENOENT;
                parent = fs->pwd;
            }

            const char* name = last_slash ? last_slash + 1 : pathname;
            inode* dir_ip = parent.de->d_inode;
            if (!dir_ip || !dir_ip->i_op || !dir_ip->i_op->create) {
                return -EACCES;
            }

            /* Create the inode via the directory's i_op->create */
            qstr q{};
            q.name = name;
            q.len = 0;
            for (const char* s = name; *s; s++) q.len++;
            dentry* new_de = d_alloc(parent.de, &q);
            if (!new_de) return -ENOMEM;


            err = dir_ip->i_op->create(dir_ip, new_de, mode & ~S_IFMT, false);
            if (err) {
                /* TODO: free new_de */
                return err;
            }

            p.de = new_de;
            p.mnt = parent.mnt;
        } else {
            /* TODO: multi-component parent lookup */
            return -ENOENT;
        }
    } else if (err) {
        return err;
    }

    /* Allocate fd */
    int fd = alloc_fd(files, 0);
    if (fd < 0) {
        return fd;
    }

    /* Allocate file object */
    file* fp = alloc_empty_file(flags);
    if (!fp) {
        /* TODO: release fd */
        return -ENFILE;
    }

    fp->f_inode = p.de->d_inode;
    fp->f_path = p;
    fp->f_op = p.de->d_inode->i_fop;
    fp->f_pos = 0;

    /* Chardev: look up cdev by i_rdev and replace f_op */
    if (S_ISCHR(fp->f_inode->i_mode)) {
        extern int devfs_chrdev_open(inode* ip, file* fp);
        err = devfs_chrdev_open(fp->f_inode, fp);
        if (err) {
            fput(fp);
            return err;
        }
    } else if (fp->f_op && fp->f_op->open) {
        err = fp->f_op->open(fp->f_inode, fp);
        if (err) {
            fput(fp);
            return err;
        }
    }

    /* O_TRUNC for regular files */
    if ((flags & O_TRUNC) && S_ISREG(fp->f_inode->i_mode)) {
        fp->f_inode->i_size = 0;
    }

    fd_install(files, fd, fp);
    return fd;
}

/* ================================================================== */
/*  sys_close(fd)                                                     */
/* ================================================================== */

int64 sys_close(uint64 a0, uint64 /*a1*/, uint64 /*a2*/,
                uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    files_struct* files = current_files();
    if (!files) return -EBADF;
    return close_fd(files, fd);
}

/* ================================================================== */
/*  sys_read(fd, buf, count)                                          */
/* ================================================================== */

int64 sys_read(uint64 a0, uint64 a1, uint64 a2,
               uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    char* buf = reinterpret_cast<char*>(a1);
    uint64 count = a2;

    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, fd);
    if (!fp) return -EBADF;

    if (!(fp->f_mode & FMODE_READ)) return -EBADF;

    return vfs_read(fp, buf, count, &fp->f_pos);
}

/* ================================================================== */
/*  sys_write(fd, buf, count)                                         */
/* ================================================================== */

int64 sys_write(uint64 a0, uint64 a1, uint64 a2,
                uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    const char* buf = reinterpret_cast<const char*>(a1);
    uint64 count = a2;

    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, fd);
    if (!fp) return -EBADF;

    if (!(fp->f_mode & FMODE_WRITE)) return -EBADF;

    return vfs_write(fp, buf, count, &fp->f_pos);
}

/* ================================================================== */
/*  sys_lseek(fd, offset, whence)                                     */
/* ================================================================== */

int64 sys_lseek(uint64 a0, uint64 a1, uint64 a2,
                uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    int64 offset = static_cast<int64>(a1);
    int whence = static_cast<int>(a2);

    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, fd);
    if (!fp) return -EBADF;

    return vfs_llseek(fp, offset, whence);
}

/* ================================================================== */
/*  sys_fstat(fd, statbuf)                                            */
/* ================================================================== */

int64 sys_fstat_wrapper(uint64 a0, uint64 a1, uint64 /*a2*/,
                        uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    auto* statbuf = reinterpret_cast<kstat*>(a1);

    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, fd);
    if (!fp) return -EBADF;

    return vfs_fstat(fp, statbuf);
}

/* ================================================================== */
/*  sys_getdents64(fd, dirp, count)                                   */
/* ================================================================== */

struct linux_dirent64 {
    uint64  d_ino;
    int64   d_off;
    uint16  d_reclen;
    uint8   d_type;
    char    d_name[];
};

struct getdents_ctx {
    dir_context     ctx;
    char*           buf;
    int             count;
    int             written;
    int             error;
};

static bool filldir64(dir_context* ctx, const char* name, int namelen,
                      int64 offset, uint64 ino, unsigned int d_type)
{
    auto* gctx = container_of(ctx, getdents_ctx, ctx);

    /* Calculate record length (rounded up to 8 bytes) */
    int reclen = static_cast<int>(
        (sizeof(linux_dirent64) + namelen + 1 + 7) & ~7ULL);

    if (gctx->written + reclen > gctx->count) {
        return false;  /* Buffer full */
    }

    auto* dirent = reinterpret_cast<linux_dirent64*>(
        gctx->buf + gctx->written);

    dirent->d_ino = ino;
    dirent->d_off = offset + 1;
    dirent->d_reclen = static_cast<uint16>(reclen);
    dirent->d_type = static_cast<uint8>(d_type);

    /* Copy name */
    for (int i = 0; i < namelen; i++) {
        dirent->d_name[i] = name[i];
    }
    dirent->d_name[namelen] = '\0';

    gctx->written += reclen;
    return true;
}

int64 sys_getdents64(uint64 a0, uint64 a1, uint64 a2,
                     uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    char* buf = reinterpret_cast<char*>(a1);
    int count = static_cast<int>(a2);

    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, fd);
    if (!fp) return -EBADF;

    if (!fp->f_op || !fp->f_op->iterate_shared) {
        return -ENOTDIR;
    }

    getdents_ctx gctx{};
    gctx.ctx.actor = filldir64;
    gctx.ctx.pos = fp->f_pos;
    gctx.buf = buf;
    gctx.count = count;
    gctx.written = 0;
    gctx.error = 0;

    fp->f_op->iterate_shared(fp, &gctx.ctx);
    fp->f_pos = gctx.ctx.pos;

    return gctx.written;
}

/* ================================================================== */
/*  sys_dup(oldfd)                                                    */
/* ================================================================== */

int64 sys_dup(uint64 a0, uint64 /*a1*/, uint64 /*a2*/,
              uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int oldfd = static_cast<int>(a0);
    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, oldfd);
    if (!fp) return -EBADF;

    int newfd = alloc_fd(files, 0);
    if (newfd < 0) return newfd;

    get_file(fp);
    fd_install(files, newfd, fp);
    return newfd;
}

/* ================================================================== */
/*  sys_dup3(oldfd, newfd, flags)                                     */
/* ================================================================== */

int64 sys_dup3(uint64 a0, uint64 a1, uint64 a2,
               uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int oldfd = static_cast<int>(a0);
    int newfd = static_cast<int>(a1);
    int flags = static_cast<int>(a2);

    files_struct* files = current_files();
    if (!files) return -EBADF;

    return do_dup2(files, oldfd, newfd, flags);
}

/* ================================================================== */
/*  sys_getcwd(buf, size)                                             */
/* ================================================================== */

int64 sys_getcwd(uint64 a0, uint64 a1, uint64 /*a2*/,
                 uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    char* buf = reinterpret_cast<char*>(a0);
    uint64 size = a1;

    if (!buf || size == 0) return -EINVAL;

    fs_struct* fs = current_fs();
    if (!fs) return -ENOENT;

    char tmp[256];
    char* result = d_path(&fs->pwd, tmp, sizeof(tmp));
    if (!result) return -ERANGE;

    /* Calculate length */
    int len = 0;
    for (const char* s = result; *s; s++) len++;
    len++;  /* Include NUL */

    if (static_cast<uint64>(len) > size) return -ERANGE;

    for (int i = 0; i < len; i++) {
        buf[i] = result[i];
    }

    return len;
}

/* ================================================================== */
/*  sys_chdir(pathname)                                               */
/* ================================================================== */

int64 sys_chdir(uint64 a0, uint64 /*a1*/, uint64 /*a2*/,
                uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    const char* pathname = reinterpret_cast<const char*>(a0);

    path p{};
    int err = filename_lookup(AT_FDCWD, pathname, LOOKUP_DIRECTORY, &p);
    if (err) return err;

    if (!S_ISDIR(p.de->d_inode->i_mode)) {
        path_put(&p);
        return -ENOTDIR;
    }

    fs_struct* fs = current_fs();
    if (!fs) {
        path_put(&p);
        return -ENOENT;
    }

    set_fs_pwd(fs, &p);
    path_put(&p);
    return 0;
}

/* ================================================================== */
/*  sys_mkdirat(dirfd, pathname, mode)                                */
/* ================================================================== */

int64 sys_mkdirat(uint64 a0, uint64 a1, uint64 a2,
                  uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int dirfd = static_cast<int>(a0);
    const char* pathname = reinterpret_cast<const char*>(a1);
    uint32 mode = static_cast<uint32>(a2);

    /* Walk to the parent directory */
    /* For simplicity, support only "single component" paths for now */
    path parent{};
    int err;

    if (pathname[0] == '/') {
        parent.de = g_root_dentry;
        parent.mnt = g_root_mnt;
        pathname++;  /* skip leading / */
    } else {
        fs_struct* fs = current_fs();
        if (!fs) return -ENOENT;
        parent = fs->pwd;
        (void)dirfd;  /* TODO: respect dirfd for AT_FDCWD check */
    }

    inode* dir_ip = parent.de->d_inode;
    if (!dir_ip || !dir_ip->i_op || !dir_ip->i_op->mkdir) {
        return -EPERM;
    }

    qstr q{};
    q.name = pathname;
    q.len = 0;
    for (const char* s = pathname; *s; s++) q.len++;
    dentry* new_de = d_alloc(parent.de, &q);
    if (!new_de) return -ENOMEM;

    err = dir_ip->i_op->mkdir(dir_ip, new_de, mode | S_IFDIR);
    if (err) {
        return err;
    }

    return 0;
}

/* ================================================================== */
/*  sys_unlinkat(dirfd, pathname, flags)                               */
/* ================================================================== */

int64 sys_unlinkat(uint64 a0, uint64 a1, uint64 a2,
                   uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    (void)a0; (void)a1; (void)a2;
    /* TODO: implement unlink/rmdir */
    return -ENOSYS;
}

/* ================================================================== */
/*  sys_writev(fd, iov, iovcnt)                                       */
/* ================================================================== */

struct iovec {
    void*   iov_base;
    uint64  iov_len;
};

int64 sys_writev(uint64 a0, uint64 a1, uint64 a2,
                 uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    const iovec* iov = reinterpret_cast<const iovec*>(a1);
    int iovcnt = static_cast<int>(a2);

    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, fd);
    if (!fp) return -EBADF;
    if (!(fp->f_mode & FMODE_WRITE)) return -EBADF;

    int64 total = 0;
    for (int i = 0; i < iovcnt; i++) {
        if (iov[i].iov_len == 0) continue;
        int64 ret = vfs_write(fp, static_cast<const char*>(iov[i].iov_base),
                              iov[i].iov_len, &fp->f_pos);
        if (ret < 0) {
            return total > 0 ? total : ret;
        }
        total += ret;
        if (static_cast<uint64>(ret) < iov[i].iov_len) break;
    }
    return total;
}

/* ================================================================== */
/*  sys_ioctl — dispatch to file_operations                           */
/* ================================================================== */

int64 sys_ioctl(uint64 a0, uint64 a1, uint64 a2,
                uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    unsigned int cmd = static_cast<unsigned int>(a1);
    uint64 arg = a2;

    TaskControlBlock* curr = current_task();
    if (!curr || !curr->files) return -EBADF;

    file* fp = fcheck(curr->files, fd);
    if (!fp) return -EBADF;

    if (fp->f_op && fp->f_op->unlocked_ioctl)
        return fp->f_op->unlocked_ioctl(fp, cmd, arg);

    return -ENOTTY;
}

/* ================================================================== */
/*  sys_pipe2(fds, flags)                                             */
/* ================================================================== */

#include <lume/pipe.h>

int64 sys_pipe2(uint64 a0, uint64 a1, uint64 /*a2*/,
                uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int* user_fds = reinterpret_cast<int*>(a0);
    int flags = static_cast<int>(a1);

    files_struct* files = current_files();
    if (!files) return -EMFILE;

    int fds[2];
    int err = do_pipe2(files, fds, flags);
    if (err) return err;

    user_fds[0] = fds[0];
    user_fds[1] = fds[1];
    return 0;
}

/* ================================================================== */
/*  sys_fcntl(fd, cmd, arg)                                           */
/* ================================================================== */

/* fcntl commands — Linux ABI values */
inline constexpr int F_DUPFD         = 0;
inline constexpr int F_GETFD         = 1;
inline constexpr int F_SETFD         = 2;
inline constexpr int F_GETFL         = 3;
inline constexpr int F_SETFL         = 4;
inline constexpr int F_DUPFD_CLOEXEC = 1030;

inline constexpr int FD_CLOEXEC = 1;

/* Bitmap helpers (duplicated from fd.cc — TODO: move to shared header) */
static inline bool fcntl_bit_test(const uint64* bmap, int bit) {
    return (bmap[bit / 64] >> (bit % 64)) & 1;
}
static inline void fcntl_bit_set(uint64* bmap, int bit) {
    bmap[bit / 64] |= (1ULL << (bit % 64));
}
static inline void fcntl_bit_clear(uint64* bmap, int bit) {
    bmap[bit / 64] &= ~(1ULL << (bit % 64));
}

int64 sys_fcntl(uint64 a0, uint64 a1, uint64 a2,
                uint64 /*a3*/, uint64 /*a4*/, uint64 /*a5*/)
{
    int fd = static_cast<int>(a0);
    int cmd = static_cast<int>(a1);
    uint64 arg = a2;

    files_struct* files = current_files();
    if (!files) return -EBADF;

    file* fp = fcheck(files, fd);
    if (!fp) return -EBADF;

    switch (cmd) {
    case F_DUPFD:
    case F_DUPFD_CLOEXEC: {
        int new_fd = alloc_fd(files, static_cast<unsigned int>(arg));
        if (new_fd < 0) return new_fd;
        get_file(fp);
        fd_install(files, new_fd, fp);
        if (cmd == F_DUPFD_CLOEXEC) {
            LockGuard guard(files->file_lock);
            fcntl_bit_set(files->close_on_exec_init, new_fd);
        }
        return new_fd;
    }

    case F_GETFD: {
        LockGuard guard(files->file_lock);
        return fcntl_bit_test(files->close_on_exec_init, fd) ? FD_CLOEXEC : 0;
    }

    case F_SETFD: {
        LockGuard guard(files->file_lock);
        if (arg & FD_CLOEXEC)
            fcntl_bit_set(files->close_on_exec_init, fd);
        else
            fcntl_bit_clear(files->close_on_exec_init, fd);
        return 0;
    }

    case F_GETFL:
        return fp->f_flags;

    case F_SETFL:
        /* Only allow changing O_APPEND, O_NONBLOCK, O_ASYNC */
        fp->f_flags = (fp->f_flags & ~(O_APPEND | O_NONBLOCK)) |
                      (static_cast<unsigned int>(arg) & (O_APPEND | O_NONBLOCK));
        return 0;

    default:
        return -EINVAL;
    }
}

/* ================================================================== */
/*  sys_socket (SYS_socket = 198) & sys_sendto (SYS_sendto = 206)     */
/* ================================================================== */

int64 sys_socket(uint64, uint64, uint64, uint64, uint64, uint64)
{
    /* 
     * COMPATIBILITY STUB:
     * LumeOS currently lacks a networking stack and Unix Domain Sockets (AF_UNIX).
     * We return -EAFNOSUPPORT (Address family not supported by protocol) as expected
     * by Linux applications (like BusyBox syslogd connecting to /dev/log).
     */
    return -EAFNOSUPPORT;
}

int64 sys_sendto(uint64, uint64, uint64, uint64, uint64, uint64)
{
    /* COMPATIBILITY STUB */
    return -EAFNOSUPPORT;
}
