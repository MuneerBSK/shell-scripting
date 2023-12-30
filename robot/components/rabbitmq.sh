#!/bin/bash

# set -e

COMPONENT=rabbitmq

source components/common.sh

echo -n "Installing ERlang dependency"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>> $LOGFILE
stat $?

echo -n "Installing $COMPONENT :"
yum install rabbitmq-server -y   &>> $LOGFILE
stat $?

echo -n"Starting $COMPONENT :"
systemctl enable rabbitmq-server   &>> $LOGFILE
systemctl start rabbitmq-server    &>> $LOGFILE
stat $?

echo -n "Creating $COMPONENT application user :"
rabbitmqctl add_user roboshop roboshop123             &>> $LOGFILE
rabbitmqctl set_user_tags roboshop administrator      &>> $LOGFILE



# # 
# # rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
# ​
# Ref link : https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management
# We are good with rabbitmq.Next component is PAYMENT