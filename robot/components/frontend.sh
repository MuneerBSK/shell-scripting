#!/bin/bash

set -e

# validating whether the executed user is root user or not

ID=$(id -u)
if [ "$ID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

echo -n "installing ngnix : "
yum install nginx -y  &>> /tmp/frontend.log

if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *    &>> /tmp/frontend.log
unzip /tmp/frontend.zip    &>> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx    &>> /tmp/frontend.log
systemctl start nginx     &>> /tmp/frontend.log

# Here are my 3 step observations :

# 1. Few of the steps are failed, still my script executed irrespective of the failure. : set -e
# 2. Instalaltion failed, because i have not validated that i have a root privileges
# 3. The information i would like to provided is like success or failure.
