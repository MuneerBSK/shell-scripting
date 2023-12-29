#!/bin/bash

set -e

# validating whether the executed user is root user or not
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

COMPONENT=user
LOGFILE="/tmp/$COMPONENT.log"
APPUSER=roboshop

stat () {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m $2: Success \e[0m"
    else
        echo -e "\e[31m $2: Failure \e[0m"
        exit 2
    fi 
}

echo -n "Configuring the nodejs repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | bash -  &>> $LOGFILE
stat $?

echo -n "Installing NodeJS :"
yum install nodejs -y    &>> $LOGFILE
stat $?


id $APPUSER
if [ $? -ne 0 ]; then
echo -n "Creating the appilication user account :"
useradd $APPUSER       &>> $LOGFILE
stat $? 
fi

echo -n "Downloading the $COMPONENT component :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT in the $APPUSER directory:"
cd /home/$APPUSER
rm -rf /home/$APPUSER/$COMPONENT  &>> $LOGFILE
unzip -o /tmp/$COMPONENT.zip   &>> $LOGFILE
stat $?

echo -n "Configuring the permissions :"
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
stat $?

echo -n "Installing the $COMPONENT application :"
cd /home/$APPUSER/$COMPONENT
npm install   &>> $LOGFILE
stat $?

echo -n "Updating the systemd file with DB details :"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?

echo -n "Starting the $COMPONENT service :"
systemctl daemon-reload     &>> $LOGFILE
systemctl enable $COMPONENT &>> $LOGFILE
systemctl start $COMPONENT  &>> $LOGFILE
stat $?