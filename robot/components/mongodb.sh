#!/bin/bash

set -e

# validating whether the executed user is root user or not
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

COMPONENT="mongodb"
LOGFILE="/tmp/$COMPONENT.log"

stat () {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m $2: Success \e[0m"
    else
        echo -e "\e[31m $2: Failure \e[0m"
        exit 2
    fi 
}

echo -n "Configuring the $COMPONENT repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT"
yum install -y mongodb-org  &>> LOGFILE
stat $?


# systemctl enable mongod
# systemctl start mongod

# Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

# vim /etc/mongod.conf

# systemctl restart mongod


  

# Every Database needs the schema to be loaded for the application to work.

# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js
