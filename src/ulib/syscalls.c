// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 * Libc Syscall Shims
 */

#include "common/types.h"
#include "user/user.h"

// Define external raw syscalls from usys.S
extern int sys_openat(int dfd, const char *filename, int flags, int mode);
extern int sys_mknodat(int dfd, const char *filename, int mode, int dev);
extern int sys_mkdirat(int dfd, const char *path, int mode);
extern int sys_unlinkat(int dfd, const char *path, int flags);
extern int sys_linkat(int olddfd, const char *oldpath, int newdfd, const char *newpath, int flags);
extern int sys_chdir(const char *path);
extern int sys_dup(int oldfd);
extern int sys_fstat(int fd, void *statbuf);
extern int sys_read(int fd, void *buf, int count);
extern int sys_write(int fd, const void *buf, int count);
extern int sys_close(int fd);
extern int sys_pipe2(int pipefd[2], int flags);
extern int sys_clone(unsigned long flags, void *stack, int *ptid, void *tls, int *ctid);
extern int sys_execve(const char *path, char *const argv[], char *const envp[]);
extern int sys_wait4(int pid, int *status, int options, void *rusage);
extern int sys_exit(int status);
extern int sys_getpid();
extern int sys_brk(int n);
extern int sys_kill(int pid, int sig);
extern int sys_nanosleep(void *req, void *rem);
extern int sys_reboot(int magic1, int magic2, int cmd, void *arg);
extern int sys_lseek(int fd, int offset, int whence);
extern void sys_putc(char c);
extern int sys_disk_test();

// --- POSIX Implementation ---

int open(const char *path, int flags)
{
    return sys_openat(AT_FDCWD, path, flags, 0);
}

int mknod(const char *path, short major, short minor)
{
    // Pack major/minor into simplified dev_t (major << 20 | minor)
    int dev = (major << 20) | (minor & 0xFFFFF);
    return sys_mknodat(AT_FDCWD, path, 0, dev);
}

int mkdir(const char *path)
{
    return sys_mkdirat(AT_FDCWD, path, 0);
}

int unlink(const char *path)
{
    return sys_unlinkat(AT_FDCWD, path, 0);
}

int link(const char *oldpath, const char *newpath)
{
    return sys_linkat(AT_FDCWD, oldpath, AT_FDCWD, newpath, 0);
}

int chdir(const char *path)
{
    return sys_chdir(path);
}

int fork()
{
    return sys_clone(0, 0, 0, 0, 0);
}

int exec(char *path, char **argv)
{
    return sys_execve(path, argv, 0);
}

int wait(uint64 status_addr)
{
    return sys_wait4(-1, (int *)status_addr, 0, 0);
}

int pipe(int p[])
{
    return sys_pipe2(p, 0);
}

int read(int fd, void *buf, int n)
{
    return sys_read(fd, buf, n);
}

int write(int fd, const void *buf, int n)
{
    return sys_write(fd, buf, n);
}

int close(int fd)
{
    return sys_close(fd);
}

int fstat(int fd, void *st)
{
    return sys_fstat(fd, st);
}

int dup(int fd)
{
    return sys_dup(fd);
}

int getpid()
{
    return sys_getpid();
}

char *sbrk(int n)
{
    return (char *)(long)sys_brk(n);
}

int kill(int pid)
{
    return sys_kill(pid, 0);
}

int sleep(int ticks)
{
    return sys_nanosleep((void *)(long)ticks, 0);
}

int shutdown()
{
    return sys_reboot(0, 0, 0, 0);
}

void putc(char c)
{
    sys_putc(c);
}

int disk_test()
{
    return sys_disk_test();
}

int lseek(int fd, int offset, int whence)
{
    return sys_lseek(fd, offset, whence);
}