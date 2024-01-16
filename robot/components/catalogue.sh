#!/bin/bash 

# set -e 

COMPONENT=catalogue
LOGFILE="/tmp/$COMPONENT.log"
APPUSER=roboshop

# Validting whether the executed user is a root user or not 
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute this script as a root user or with a sudo as prefix \e[0m" 
    exit 1
fi 

stat() {
    if [ $1 -eq 0 ] ; then 
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[31m Failure \e[0m"
        exit 2
    fi 
}

echo -n "Configuring the nodejs repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | bash -  &>> $LOGFILE
stat $?

Echo -n "Installing nodejs :"
yum install nodejs -y   &>> $LOGFILE
stat $?

echo -n "Creating application user account :"
useradd $APPUSER   &>> $LOGFILE
stat $?

echo -n "Downloading the $COMPONENT component :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT in the $APPUSER directory :"
cd /home/roboshop
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
stat $?
 

# $ mv catalogue-main catalogue
# $ cd /home/roboshop/catalogue
# $ npm install
# ```

# 1. Update SystemD file with correct IP addresses
    
#     Update `MONGO_DNSNAME` with MongoDB Server IP
    
#     ```sql
#     $ vim systemd.servce
#     ```
    
# 2. Now, lets set up the service with systemctl.

# ```bash
# # mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# # systemctl daemon-reload
# # systemctl start catalogue
# # systemctl enable catalogue
# # systemctl status catalogue -l

# **NOTE:** You should see the log saying `connected to MongoDB`

# **Ref Log:** {"level":"info","time":1656660782066,"pid":12217,"hostname":"ip-172-31-13-123.ec2.internal","msg":**"MongoDB connected",**"v":1}
# ```