#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
    int i;

    if (argc < 2)
    {
        printf("Usage: kill pid...\n");
        exit(1);
    }
    for (i = 1; i < argc; i++)
    {
        int pid = atoi(argv[i]);
        if (kill(pid) < 0)
        {
            printf("kill: failed to kill %d\n", pid);
        }
    }
    exit(0);
}