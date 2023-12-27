#!/bin/bash 

# There are 4 types of command available : 

# 1) Binary                   ( /bin  , /sbin )
# 2) Aliases                  ( Alises are shortcuts,  alias net="netstat -tulpn" )
# 3) Shell Built-in Commands  
# 4) Functions                # Functions are nothing but a set of command that can be written in a sequence and can be called n number of times as per your choice.

# Declaring a function 

sample() {
    echo "I am a messaged called from sample function"
}

# This how we call a function.
stat() {
    echo -e"\t total number of sessions : $(who | wc -l)"
    echo "Todays date is $(date +%F)"
    echo "Load average on the system is $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')"
    echo "\t stat function completed"
}

echo "calling stat function"
stat