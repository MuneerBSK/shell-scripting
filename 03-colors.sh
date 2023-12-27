#!/bin/bash

# Color	     Foreground  	     Background 
# Black	         30	                 40
# Red	         31	                 41
# Green	         32	                 42
# Yellow	     33	                 43
# Blue	         34	                 44
# Magenta	     35	                 45
# Cyan	         36	                 46
# White	         37	                 47


# The syntax to print colors is 
# Ex.

#      echo -e "\e[COL-CODEm  Your message to be printed \e[0m"
#      echo -e "\e[C32m I am printing green colour \e[0m"

echo -e "\e[31m I am printing red colour \e[0m"
echo -e "\e[32m I am printing green colour \e[0m"
echo -e "\e[33m I am printing yellow colour \e[0m"
echo -e "\e[34m I am printing blue colour \e[0m"
echo -e "\e[35m I am printing magenta colour \e[0m"

# How to print background color

#   echo -e "\e[BackGroundCOL-CODE;ForeGroundColorm  Your Message To Be Printed \e[0m"

echo -e "\e[40;30m I am printing abckground and foreground colors \e[0m"