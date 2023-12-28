#!/bin/bash

set -e

# validating whether the executed user is root user or not
if [ "$EUID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

COMPONENT="frontend"
LOGFILE="/tmp/$COMPONENT.log"

stat () {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m $2: Success \e[0m"
    else
        echo -e "\e[31m $2: Failure \e[0m"
        exit 2
    fi 
}

echo -n "Installing nginx : "
yum install nginx -y &>> $LOGFILE
stat $? "Installing nginx"

echo -n "Downloading the $COMPONENT component :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $? 

echo -n "Performing cleanup of old $COMPONENT content : "
cd /usr/share/nginx/html
rm -rf * &>> $LOGFILE
stat $? 

echo -n "Copying the downloaded $COMPONENT content : "
unzip /tmp/$COMPONENT.zip &>> $LOGFILE
mv $COMPONENT-main/* .
mv static/* .
rm -rf $COMPONENT-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $? 

echo -n "Starting the service : "
systemctl enable nginx &>> $LOGFILE
systemctl start nginx &>> $LOGFILE
stat $? 