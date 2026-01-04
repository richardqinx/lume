#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf("Usage: mv old new\n");
        exit(1);
    }

    if (link(argv[1], argv[2]) < 0)
    {
        printf("mv: failed to link %s to %s\n", argv[1], argv[2]);
        exit(1);
    }

    if (unlink(argv[1]) < 0)
    {
        printf("mv: failed to unlink %s\n", argv[1]);
        exit(1);
    }

    exit(0);
}