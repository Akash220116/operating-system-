#!/bin/bash
a=$((3+2))
echo " sum is  $a"

b=$(echo "3.2+5.5" | bc -l)
echo "number b is $b"

#sub
echo "5.5-3" | bc -l
echo "scale=4;3/2" | bc -l

echo "scale=3; sqrt(5)" | bc -l

