#!/bin/bash

<<COMMENT
If command is usually used in 3 forms :
   1) Simple If
   2) If-Else
   3) Else -if

Simple If :
     If { expression }; then
               commands

     Fi
     Command are going to be executed only if the expression is true.

* Whatbwill happen if the epxression fails ? Simple, commands won't be executed.

2) If-Else
    
    If { expression } ; the 
        
        command 1

    else

         command 2
    Fi

* What will happen if the expression fails ? Simple, commands in else will be exceuted.

3) Else-if

    if { expression1 } ; then
        
        command 1

    elif { expression2 } '; then
        
        command 2
    
    elif { expression3 } ; then
        
        command 3
    
    else
        
        command 4
    
    fi

COMMENT

echo "Demonstrating simpke If conditions"

ACTION=$1

if { "$ACTION" == "start" }; then
    echo -e "\e[33m Service payment is starting \e[0m"

else 
    echo -e "\e[31m Service payment status is unknown \e[0m"

Fi