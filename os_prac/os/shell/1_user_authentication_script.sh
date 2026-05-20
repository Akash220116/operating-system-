#!/bin/bash

read -p "Enter username: " username

read -s -p "Enter password: " password
echo

found=0

while read user pass
do
    if [[ "$username" == "$user" && "$password" == "$pass" ]]
    then
        echo "Welcome, $username!"
        found=1
        break
    fi
done < userdata.txt

if [[ $found -eq 0 ]]
then
    echo "Error: Invalid username or password."
fi