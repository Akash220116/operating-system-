#!/bin/bash

FILE="todo.txt"

# Create file if not exists
touch "$FILE"

# ADD TASK 
if [[ $1 == "add" ]]
then
    shift
    echo "[ ] $*" >> "$FILE"
    echo "Task added!"

# LIST TASKS 
elif [[ $1 == "list" ]]
then
    if [[ ! -s $FILE ]]
    then
        echo "No tasks found."
        exit 0
    fi

    nl -w2 -s". " "$FILE"

#  MARK DONE 
elif [[ $1 == "done" ]]
then
    line=$2

    task=$(sed -n "${line}p" "$FILE")

    if [[ -z "$task" ]]
    then
        echo "Invalid task number"
        exit 1
    fi

    updated=$(echo "$task" | sed 's/\[ \]/[x]/')

    sed -i "${line}s/.*/$updated/" "$FILE"

    echo "Nice job 🚀 Task completed!"

# CLEAR TASKS 
elif [[ $1 == "clear" ]]
then
    > "$FILE"
    echo "Todo list cleared 🧹"

# SEARCH TASKS
elif [[ $1 == "search" ]]
then
    shift
    grep -n "$*" "$FILE"

# INVALID COMMAND 
else
    echo "Usage:"
    echo "./todo.sh add \"task\""
    echo "./todo.sh list"
    echo "./todo.sh done <number>"
    echo "./todo.sh clear"
    echo "./todo.sh search \"keyword\""
fi