#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main()
{
    int p1[2], p2[2];
    pid_t pid;
    char parent_msg[] = "Message from Parent";
    char child_msg[] = "Message from Child";
    char buffer[100];

    if (pipe(p1) == -1 || pipe(p2) == -1)
    {
        perror("pipe failed");
        exit(1);
    }

    pid = fork();

    if (pid < 0)
    {
        perror("fork failed");
        exit(1);
    }

    if (pid > 0)
    {
        close(p1[0]);
        close(p2[1]);

        write(p1[1], parent_msg, strlen(parent_msg) + 1);
        read(p2[0], buffer, sizeof(buffer));

        printf("Parent received: %s\n", buffer);

        close(p1[1]);
        close(p2[0]);

        wait(NULL);
    }
    else
    {
        close(p1[1]);
        close(p2[0]);

        read(p1[0], buffer, sizeof(buffer));
        printf("Child received: %s\n", buffer);

        write(p2[1], child_msg, strlen(child_msg) + 1);

        close(p1[0]);
        close(p2[1]);

        exit(0);
    }

    return 0;
}