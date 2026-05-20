#!/bin/bash

user="admin"
pass="1234"

read -p "Username: " u
read -s -p "Password: " p
echo

if [[ "$u" == "$user" && "$p" == "$pass" ]]
then
    echo "Login successful"
else
    echo "Access denied"
fi