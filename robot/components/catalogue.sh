#!/bin/bash

set -e

# validating whether the executed user is root user or not
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

COMPONENT="catalogue"
LOGFILE="/tmp/$COMPONENT.log"
APPUSER=roboshop


