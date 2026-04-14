// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard Qin
 */
#pragma once

typedef unsigned long long uint64;

#define AT_FDCWD -100

#ifdef __cplusplus
extern "C"
{
#endif

    // Raw Linux System Calls
    int sys_openat(int dfd, const char *filename, int flags, int mode);
    int sys_mknodat(int dfd, const char *filename, int mode, int dev);
    int sys_mkdirat(int dfd, const char *path, int mode);
    int sys_unlinkat(int dfd, const char *path, int flags);
    int sys_linkat(int olddfd, const char *oldpath, int newdfd, const char *newpath, int flags);
    int sys_chdir(const char *path);
    int sys_dup(int oldfd);
    int sys_fstat(int fd, void *statbuf);
    int sys_read(int fd, void *buf, int count);
    int sys_write(int fd, const void *buf, int count);
    int sys_close(int fd);
    int sys_pipe2(int pipefd[2], int flags);
    int sys_clone(unsigned long flags, void *stack, int *ptid, void *tls, int *ctid);
    int sys_execve(const char *path, char *const argv[], char *const envp[]);
    int sys_wait4(int pid, int *status, int options, void *rusage);
    int sys_exit(int status);
    int sys_getpid();
    int sys_brk(int n);
    int sys_kill(int pid, int sig);
    int sys_nanosleep(void *req, void *rem);
    int sys_reboot(int magic1, int magic2, int cmd, void *arg);
    int sys_lseek(int fd, int offset, int whence);

    // Custom
    void sys_putc(char c);
    int sys_disk_test();

    // POSIX Wrappers
    int fork();
    int exit(int status);
    int wait(uint64 status_addr);
    int pipe(int p[]);
    int write(int fd, const void *buf, int n);
    int read(int fd, void *buf, int n);
    int close(int fd);
    int kill(int pid);
    int exec(char *, char **);
    int open(const char *, int);
    int mknod(const char *, short, short);
    int unlink(const char *);
    int link(const char *, const char *);
    int fstat(int fd, void *st);
    int mkdir(const char *);
    int chdir(const char *);
    int dup(int fd);
    int getpid();
    char *sbrk(int n);
    int sleep(int ticks);
    int uptime();
    int shutdown();
    int lseek(int fd, int offset, int whence);

    // Debug
    void putc(char c);
    int disk_test();

#ifdef __cplusplus
}
#endif