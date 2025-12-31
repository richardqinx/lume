#include "user/user.h"

int strlen(const char *s)
{
    int n = 0;
    while (s[n])
        n++;
    return n;
}

void print(const char *s)
{
    write(1, s, strlen(s));
}

void print_int(int val)
{
    char buf[16];
    int i = 0;
    if (val == 0)
    {
        print("0");
        return;
    }
    if (val < 0)
    {
        print("-");
        val = -val;
    }
    while (val > 0)
    {
        buf[i++] = (val % 10) + '0';
        val /= 10;
    }
    while (i > 0)
    {
        char c = buf[--i];
        write(1, &c, 1);
    }
}

void pass() { print(" -> [PASS]\n"); }
void fail()
{
    print(" -> [FAIL]\n");
    exit(1);
}

int main()
{
    print("\n=== Lume OS Full Validation ===\n");

    print("[TEST 1] Write\n");
    print("  System call write is working.");
    pass();

    print("[TEST 2] GetPID\n");
    int parent_pid = getpid();
    print("  Parent PID: ");
    print_int(parent_pid);
    if (parent_pid > 0)
        pass();
    else
        fail();

    print("[TEST 3] Fork, Wait & COW\n");
    int val = 100;
    int pid = fork();

    if (pid < 0)
    {
        print("  Fork Failed\n");
        fail();
    }

    if (pid == 0)
    {
        print("  [Child] PID: ");
        print_int(getpid());
        print("\n");

        if (val != 100)
        {
            print("  [Child] Data corruption!\n");
            exit(1);
        }

        val = 200;
        print("  [Child] Modified val to 200. Exiting.\n");
        exit(0);
    }
    else
    {
        print("  [Parent] Waiting for child...\n");
        int child_pid = wait(0);

        print("  [Parent] Child ");
        print_int(child_pid);
        print(" exited.\n");

        print("  [Parent] Check val (Expect 100): ");
        print_int(val);

        if (val == 100)
            pass();
        else
        {
            print("  [Parent] Memory Isolation Failed! Val=");
            print_int(val);
            fail();
        }
    }

    print("\n=== All Tests Passed ===\n");
    while (1)
        ;
    return 0;
}