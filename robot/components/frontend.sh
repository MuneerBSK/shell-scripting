#!/bin/bash

set -e

COMPONENT= "frontend"
LOGFILE= "/tmp/$COMPONENT.log"

# validating whether the executed user is root user or not

ID=$(id -u)
if [ "$ID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

stat () {
     if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
     else
        echo -e "\e[31m Failure \e[0m"
        exit 2
     fi 
}

echo -n "Installing nginx : "
yum install nginx -y  &>> $LOGFILE
stat $?


echo -n "Downloading the $COMPONENT component :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Performing cleanup old $COMPONENT content : "
cd /usr/share/nginx/html
rm -rf *    &>> $LOGFILE
stat $?

echo -n "Copying the downloaded $COMPONENT content : "
unzip /tmp/$COMPONENT.zip    &>> $LOGFILE
mv $COMPONENT-main/* .
mv static/* .
rm -rf $COMPONENT-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Starting the service : "
systemctl enable nginx    &>> $LOGFILE
systemctl start nginx     &>> $LOGFILE
stat $?



# Here are my 3 step observations :

# 1. Few of the steps are failed, still my script executed irrespective of the failure. : set -e
# 2. Instalaltion failed, because i have not validated that i have a root privileges
# 3. The information i would like to provided is like success or failure.
