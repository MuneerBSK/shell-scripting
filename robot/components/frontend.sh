#!/bin/bash

set -e

yum install nginx -y

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx
systemctl start nginx

# Here are my 3 step observations :

# 1. Few of the steps are failed, still my script executed irrespective of the failure. : set -e
# 2. Instalaltion failed, because i have not validated that i have a root privileges
# 3. The information i would like to provided is like success or failure.
