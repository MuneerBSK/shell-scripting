#!/bin/bash

# syntax for CASE
# case $var in
#       opt1) command1 ;;

#       opt2) command2 ;;

# esac

case $ACTION in

     start)
         echo "starting payment service"
         ;;
     stop)
         echo "Stopping Payment service"
         ;;
     restart)
         echo "Restarting payment service"
         ;;