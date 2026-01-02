#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "ulib/string.h"
#include "user/user.h"

int main()
{
    char *argv[] = {(char *)"sh", 0};

    printf("[Init] Starting Lume OS Shell...\n");

    while (1)
    {
        // printf("fork start\n");
        int pid = fork();
        // printf("fork suceess, pid=%i\n", pid);
        
        if (pid < 0)
        {
            printf("[Init] fork failed!\n");
            exit(1);
        }

        if (pid == 0)
        {
            
            char sh_path[] = "/sh";
            exec(sh_path, argv);

            printf("[Init] exec sh failed\n");
            return 0;
            exit(1);
        }
        else
        {
            // break;
            int status;
            int wpid;
            while (1)
            {
                wpid = wait((uint64)&status);

                if (wpid == pid)
                {
                    printf("Shell Exit");
                    break;
                }
                if (wpid < 0)
                {
                    printf("[Init] wait error or no child\n");

                    break;
                }
            }
        }
    }
    return 0;
}