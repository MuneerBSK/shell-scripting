#!/bin/bash

set -e

# validating whether the executed user is root user or not
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

COMPONENT=redis
LOGFILE="/tmp/$COMPONENT.log"

stat () {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m $2: Success \e[0m"
    else
        echo -e "\e[31m $2: Failure \e[0m"
        exit 2
    fi 
}

echo -n "Configuring $COMPONENT repo :"
curl -L https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo -o /etc/yum.repos.d/$COMPONENT.repo
stat $?

echo -n "Installing $COMPONENT server :"
yum install redis-6.2.13 -y      &>> $LOGFILE
stat $?

echo -n "Updating the $COMPONENT visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT/$COMPONENT.conf
stat $?

echo -n "Performing daemon-reload :"
systemctl daemon-reload    &>> $LOGFILE
systemctl restart $COMPONENT   &>> $LOGFILE
stat $?

# 2. Update the BindIP from `127.0.0.1` to `0.0.0.0` in config file `/etc/redis.conf` & `/etc/redis/redis.conf`

# ```sql
# # vim /etc/redis.conf
# # vim /etc/redis/redis.conf
# ```

# # systemctl enable redis
# # systemctl start redis
# # systemctl status redis -l