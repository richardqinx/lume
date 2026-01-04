#include "ulib/stdio.h"
#include "user/user.h"

int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        printf("Usage: mkdir <dirname> ...\n");
        exit(1);
    }

    for (int i = 1; i < argc; i++)
    {
        if (mkdir(argv[i]) < 0)
        {
            printf("mkdir: cannot create directory '%s'\n", argv[i]);
        }
    }

    exit(0);
}