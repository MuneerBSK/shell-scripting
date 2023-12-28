#!/bin/bash

set -e

# validating whether the executed user is root user or not
if [ "$EUID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

COMPONENT="mongo"
LOGFILE="/tmp/$COMPONENT.log"

stat () {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m $2: Success \e[0m"
    else
        echo -e "\e[31m $2: Failure \e[0m"
        exit 2
    fi 
}

# Configuring MongoDB repository
echo -n "Configuring the $COMPONENT repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $? "Configuring the $COMPONENT repo"

# Installing MongoDB
echo -n "Installing $COMPONENT :"
yum install -y mongodb-org &>> $LOGFILE
stat $? "Installing $COMPONENT"

# Starting MongoDB
echo -n "Starting $COMPONENT :"
systemctl enable mongod &>> $LOGFILE
systemctl start mongod &>> $LOGFILE
stat $? "Starting $COMPONENT"

# Updating MongoDB visibility
echo -n "Updating the $COMPONENT visibility : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $? "Updating the $COMPONENT visibility"

# Performing Daemon-reload and restarting MongoDB
echo -n "Performing Daemon-reload : "
systemctl daemon-reload &>> $LOGFILE
systemctl restart mongod &>> $LOGFILE
stat $? "Performing Daemon-reload and restarting $COMPONENT"


# # curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# # cd /tmp
# # unzip mongodb.zip
# # cd mongodb-main
# # mongo < catalogue.js
# # mongo < users.js