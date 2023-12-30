#!/bin/bash

# set -e

COMPONENT=rabbitmq

source components/common.sh

echo -n "Installing ERlang dependency"
curl -s https://packagecloud.io/install/repositories/$COMPONENT/erlang/script.rpm.sh | sudo bash  &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/$COMPONENT/erlang/script.rpm.sh | sudo bash  &>> $LOGFILE
stat $?

echo -n "Installing $COMPONENT :"
yum install $COMPONENT-server -y   &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable $COMPONENT-server   &>> $LOGFILE
systemctl start $COMPONENT-server    &>> $LOGFILE
stat $?

rabbitmqctl list_users | grep $APPUSER                &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Creating $COMPONENT application user :"
    rabbitmqctl add_user roboshop roboshop123             &>> $LOGFILE
    stat $?
fi

echo -n "Adding required privileges to $APPUSER :"
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?

# ​
# Ref link : https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management
# We are good with rabbitmq.Next component is PAYMENT