#!/bin/bash

# syntax for CASE
# case $var in
#       opt1) command1 ;;

#       opt2) command2 ;;

# esac

ACTION=$1

case $ACTION in

     start)
         echo -e "\e[32m starting payment service \e[0m"
         ;;
     stop)
         echo -e "\e[34m Stopping Payment service \e[0m"
         ;;
     restart)
         echo -e "\e[35m Restarting payment service \e[0m"
         ;;
esac