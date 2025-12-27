#include "user/user.h"

int main();

extern "C" void _start()
{
    exit(main());
}

int main()
{
    int pid = fork();

    if (pid < 0)
    {
        write(1, "Fork failed\n", 12);
        exit(1);
    }

    if (pid == 0)
    {
        write(1, "Hello from Child!\n", 18);
        exit(0);
    }
    else
    {
        write(1, "Parent waiting...\n", 18);
        wait(0);
        write(1, "Parent: Child exited.\n", 22);
    }

    while (1);
    return 0;
}