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

echo -n"Starting $COMPONENT :"
systemctl enable $COMPONENT-server   &>> $LOGFILE
systemctl start $COMPONENT-server    &>> $LOGFILE
stat $?

echo -n "Creating $COMPONENT application user :"
rabbitmqctl add_user roboshop roboshop123             &>> $LOGFILE
rabbitmqctl set_user_tags roboshop administrator      &>> $LOGFILE
stat $?


# # 
# # rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
# ​
# Ref link : https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management
# We are good with rabbitmq.Next component is PAYMENT