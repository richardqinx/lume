#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "user/user.h"
#include "common/fcntl.h"

int main(int argc, char *argv[])
{
    int i, fd;

    if (argc < 2)
    {
        printf("Usage: touch files...\n");
        exit(1);
    }

    for (i = 1; i < argc; i++)
    {
        fd = open(argv[i], O_CREATE | O_RDWR);
        if (fd < 0)
        {
            printf("touch: cannot touch %s\n", argv[i]);
            exit(1);
        }
        close(fd);
    }
    exit(0);
}