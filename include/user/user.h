#pragma once
typedef unsigned long long uint64;

extern "C" {
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
    int fstat(int fd, void *st);
    int link(const char *, const char *);
    int mkdir(const char *);
    int chdir(const char *);
    int dup(int fd);
    int getpid();
    char *sbrk(int n);
    int sleep(int ticks);
    int uptime();

    
    void putc(char c);
}