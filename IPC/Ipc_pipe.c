#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdarg.h>

#define BUF_SIZE 10

void errExit(const char *format, ...)
{
    va_list argList;
    va_start(argList, format);
    vfprintf(stderr, format, argList);
    va_end(argList);
    fprintf(stderr, "\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char *argv[])
{
    int pfd[2];
    char buf[BUF_SIZE];
    ssize_t numRead;

    if (argc != 2 || strcmp(argv[1], "--help") == 0)
        errExit("%s string", argv[0]);

    if (pipe(pfd) == -1)
        errExit("pipe");

    switch (fork())
    {
        case -1:
            errExit("fork");

        case 0:
            close(pfd[1]);

            while ((numRead = read(pfd[0], buf, BUF_SIZE)) > 0)
            {
                if (write(STDOUT_FILENO, buf, numRead) != numRead)
                    errExit("write");
            }

            write(STDOUT_FILENO, "\n", 1);
            close(pfd[0]);
            _exit(EXIT_SUCCESS);

        default:
            close(pfd[0]);

            if (write(pfd[1], argv[1], strlen(argv[1])) != (ssize_t)strlen(argv[1]))
                errExit("write");

            close(pfd[1]);
            wait(NULL);
            exit(EXIT_SUCCESS);
    }
}