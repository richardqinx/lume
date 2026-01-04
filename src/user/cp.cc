#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "user/user.h"
#include "common/fcntl.h"

char buf[512];

int main(int argc, char *argv[])
{
    int fd_src, fd_dst, n;

    if (argc != 3)
    {
        printf("Usage: cp src dst\n");
        exit(1);
    }

    if ((fd_src = open(argv[1], O_RDONLY)) < 0)
    {
        printf("cp: cannot open source %s\n", argv[1]);
        exit(1);
    }

    if ((fd_dst = open(argv[2], O_WRONLY | O_CREATE | O_TRUNC)) < 0)
    {
        printf("cp: cannot create destination %s\n", argv[2]);
        close(fd_src);
        exit(1);
    }

    while ((n = read(fd_src, buf, sizeof(buf))) > 0)
    {
        if (write(fd_dst, buf, n) != n)
        {
            printf("cp: write error\n");
            exit(1);
        }
    }

    if (n < 0)
    {
        printf("cp: read error\n");
    }

    close(fd_src);
    close(fd_dst);
    exit(0);
}