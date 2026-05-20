#!/bin/bash
for i in {1..6}
do
 if [[ $i -eq 3 || $i -eq 4 ]]
 then 
   continue
 fi
 echo "$i"
done