#!/bin/bash

TODAYDATE=$(date +%F) # This wqy of declaring is called hardcoding.

echo -e "welcome to Bash training, todays date is \e[32m ${TODAYDATE} \e[0m"

echo -e "Number of users sessions in the system are : \e[32m  $(who | wc -l) \e[0m"