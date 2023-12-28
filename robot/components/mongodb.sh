#!/bin/bash

# set -e

COMPONENT=mongodb
source components/common.sh

echo -n "Configuring the $COMPONENT repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $? "Configuring the $COMPONENT repo"

echo -n "Installing $COMPONENT :"
yum install -y mongodb-org &>>$LOGFILE
stat $? "Installing $COMPONENT"

echo -n "Starting $COMPONENT :"
systemctl enable mongod &>>$LOGFILE
systemctl start mongod &>>$LOGFILE
stat $? "Starting $COMPONENT"

echo -n "Updating the $COMPONENT visibility : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $? "Updating the $COMPONENT visibility"

echo -n "Performing Daemon-Reload : "
systemctl daemon-reload &>>$LOGFILE
systemctl restart mongod 
stat $? "Performing Daemon-Reload"

echo -n "Downloading the $COMPONENT schema :"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $? "Downloading the $COMPONENT schema"

echo -n "Extracting the $COMPONENT schema : "
cd /tmp 
unzip -o mongodb.zip &>>$LOGFILE
stat $? "Extracting the $COMPONENT schema"

echo -n "Injecting the schema :"
cd /tmp/$COMPONENT-main
mongo < catalogue.js &>>$LOGFILE
mongo < users.js &>>$LOGFILE
stat $? "Injecting the schema"
