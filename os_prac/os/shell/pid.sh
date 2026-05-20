#!/bin/bash

# Create C program
cat > pid.c << EOF
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main() {
    pid_t pid = getpid();
    printf("Process ID: %d\n", pid);
    return 0;
}
EOF

# Compile the C program
gcc pid.c -o pid

# Run the program
./pid