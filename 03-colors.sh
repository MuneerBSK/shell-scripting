#!/bin/bash

# Color	Foreground  	   Background 
# Black	    30	                 40
# Red	    31	                 41
# Green	    32	                 42
# Yellow	33	                 43
# Blue	    34	                 44
# Magenta	35	                 45
# Cyan	    36	                 46
# White	    37	                 47


# The syntax to print colors is 
# Ex.

#      echo -e "\e[COL-CODEm  Your message to be printed \e[0m"
#      echo -e "\e[C32m I am printing green colour \e[0m"

echo -e "\e[32m I am rpinting green colour \e[0m"