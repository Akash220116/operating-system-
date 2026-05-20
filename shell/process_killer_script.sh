#!/bin/bash

read -p "Enter process name: " pname

pid=$(pgrep "$pname")

if [ -z "$pid" ]
then
    echo "Process not found"
else
    kill -9 $pid
    echo "Process $pname killed"
fi