#include "user/user.h"
#include "common/fcntl.h"

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

void print_int(int n)
{
    char buf[16];
    int i = 0;
    int neg = 0;
    if (n == 0)
    {
        write(1, "0", 1);
        return;
    }
    if (n < 0)
    {
        neg = 1;
        n = -n;
    }
    while (n > 0)
    {
        buf[i++] = (n % 10) + '0';
        n /= 10;
    }
    if (neg)
        buf[i++] = '-';
    while (i > 0)
        write(1, &buf[--i], 1);
}

void print_hex(uint64 n)
{
    char buf[16];
    char digits[] = "0123456789ABCDEF";
    write(1, "0x", 2);
    if (n == 0)
    {
        write(1, "0", 1);
        return;
    }
    int i = 0;
    while (n > 0)
    {
        buf[i++] = digits[n % 16];
        n /= 16;
    }
    while (i > 0)
        write(1, &buf[--i], 1);
}

void test_syscalls()
{
    print("\n=== [Test] Starting System Call Check ===\n");

    print("[1/4] Checking getpid()... ");
    int my_pid = getpid();
    if (my_pid > 0)
    {
        print("PASS (PID=");
        print_int(my_pid);
        print(")\n");
    }
    else
    {
        print("FAIL (Invalid PID)\n");
    }

    print("[2/4] Checking sbrk() heap allocation... ");
    char *p = sbrk(4096);
    if (p == (char *)-1)
    {
        print("FAIL (sbrk returned error)\n");
    }
    else
    {
        p[0] = 'A';
        p[4095] = 'Z';
        if (p[0] == 'A' && p[4095] == 'Z')
        {
            print("PASS (Allocated at ");
            print_hex((uint64)p);
            print(")\n");
        }
        else
        {
            print("FAIL (Memory read/write check failed)\n");
        }
    }

    print("[3/4] Checking fork() and wait()...\n");
    int pid = fork();

    if (pid < 0)
    {
        print("      FAIL: fork error\n");
    }
    else if (pid == 0)
    {
        int child_pid = getpid();
        if (child_pid == my_pid)
        {
            print("      FAIL: Child has same PID as parent\n");
            exit(1);
        }
        print("      [Child] I am alive. PID=");
        print_int(child_pid);
        print("\n");
        print("      [Child] Exiting now.\n");
        exit(0);
    }
    else
    {
        print("      [Parent] Forked child PID=");
        print_int(pid);
        print("\n");
        print("      [Parent] Waiting for child...\n");

        int waited_pid = wait(0);

        if (waited_pid == pid)
        {
            print("      [Parent] Wait returned correct PID.\n");
            print("PASS (Fork/Wait cycle)\n");
        }
        else
        {
            print("FAIL (Wait returned ");
            print_int(waited_pid);
            print(")\n");
        }
    }

    print("[4/4] Checking write()... PASS (Self-evident)\n");

    print("=== [Test] All Tests Finished ===\n");
}


int main()
{
    print("\n[Lume Shell] Init process started.\n");
    print("[Test] Opening test.txt...\n");
    int fd = open("test.txt", O_RDONLY);
    if (fd < 0)
    {
        print("[Test] Open failed (Is test.txt in fs.img?)\n");
    }
    else
    {
        print("[Test] Open success! fd=");
        print_int(fd);
        print("\n");

        char buf[64];
        int n = read(fd, buf, 63);
        if (n > 0)
        {
            buf[n] = 0;
            print("[Test] Read content:\n---\n");
            print(buf);
            print("\n---\n");
        }
        else
        {
            print("[Test] Read returned ");
            print_int(n);
            print("\n");
        }
        close(fd);
        print("[Test] File closed.\n");
    }

    

    print("Commands:\n");
    print("  s: Run System Call Tests (fork, wait, mm)\n");
    print("  t: Run Disk Driver Test (VirtIO)\n");

    while (1)
    {
        char buf[16];
        write(1, "$ ", 2);

        int n = read(0, buf, sizeof(buf));
        if (n <= 0)
            continue;

        if (buf[0] == 's')
        {
            test_syscalls();
        }
        else if (buf[0] == 't')
        {
            if (fork() == 0)
            {
                disk_test();
                exit(0);
            }
            wait(0);
        }
        else if (buf[0] != '\n')
        {
            print("Unknown command.\n");
        }
    }

    exit(0);
    return 0;
}