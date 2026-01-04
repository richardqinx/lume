#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "ulib/string.h"
#include "user/user.h"
#include "common/fcntl.h"

char buf[1024];

void grep(char *pattern, int fd)
{
    int n, m;
    char *p, *q;

    m = 0;
    while ((n = read(fd, buf + m, sizeof(buf) - m - 1)) > 0)
    {
        m += n;
        buf[m] = '\0';
        p = buf;
        while ((q = strchr(p, '\n')) != 0)
        {
            *q = 0;
            if (strstr(p, pattern) != 0)
            {
                printf("%s\n", p);
            }
            p = q + 1;
        }
        if (p == buf)
            m = 0;
        if (m > 0)
        {
            m -= p - buf;
            memmove(buf, p, m);
        }
    }
}

int main(int argc, char *argv[])
{
    int fd, i;
    char *pattern;

    if (argc < 2)
    {
        printf("Usage: grep pattern [file...]\n");
        exit(1);
    }
    pattern = argv[1];

    if (argc == 2)
    {
        grep(pattern, 0); // stdin
        exit(0);
    }

    for (i = 2; i < argc; i++)
    {
        if ((fd = open(argv[i], O_RDONLY)) < 0)
        {
            printf("grep: cannot open %s\n", argv[i]);
            exit(1);
        }
        grep(pattern, fd);
        close(fd);
    }
    exit(0);
}