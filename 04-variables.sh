#!/bin/bash

# What is a variable? A variable is something which holds some value dynamically.

a=10
b=20
c=30

# no data types are avaailable in Basha by default
# Everything is considered as STRING
 
# How do you print a variable?
# We iuse a special character, called $ to print.
# echo $a

echo $a
echo ${a}
echo "$c"

echo "I am printing the value of d $d"

# When you try to print a variable which is not declared, bash is going to consider that as NULL or EMPTY

rm -rf /data/${DATA_DIR}   # /data/test ----> rm -rf /data/

# How do you supply variables from the command line 
# export varName =  value 
