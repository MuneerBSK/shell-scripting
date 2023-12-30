LOGFILE="/tmp/$COMPONENT.log"
APPUSER=roboshop

# validating whether the executed user is root user or not
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then
    echo -e "\e[31m You should execute it as root user or with a sudo prefix \e[0m"
    exit 1
fi

stat () {
    
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m $2: Success \e[0m"
    else
        echo -e "\e[31m $2: Failure \e[0m"
        exit 2
    fi 
}

CREATE_USER() {

      id $APPUSER
      if [ $? -ne 0 ]; then
            echo -n "Creating the application user account :"
            useradd $APPUSER    &>> $LOGFILE
            stat $? 
      fi

}

DOWNLOAD_AND_EXTRACT() {

    echo -n "Downloading the $COMPONENT component :"
    curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
    stat $? 

    echo -n "Extracting the $COMPONENT in the $APPUSER directory"
    cd /home/$APPUSER 
    rm -rf /home/$APPUSER/$COMPONENT &>> $LOGFILE
    unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
    stat $? 

    echo -n "Configuring the permissions :"
    mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
    chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
    stat $?

}

NPM_INSTALL () {

    echo -n "Installing the $COMPONENT application :"
    cd /home/$APPUSER/$COMPONENT
    npm install   &>> $LOGFILE
    stat $?

}

CONFIG_SVC() {

    echo -n "Updating the systemd file with DB details :"
    sed -i -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
    mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
    stat $?

    echo -n "Starting the $COMPONENT service :"
    systemctl daemon-reload     &>> $LOGFILE
    systemctl enable $COMPONENT &>> $LOGFILE
    systemctl start $COMPONENT  &>> $LOGFILE
    stat $?

}

MVN_PACKAGE() {

    echo -n "Creating the $COMPONENT Package :"
    cd /home/$APPUSER/$COMPONENT/ 
    mvn clean package  &>> $LOGFILE
    mv target/shipping-1.0.jar shipping.jar
    stat $?   
}

JAVA() {

    echo -n "Installing Maven  :" 
    yum install maven -y &>> $LOGFILE
    stat $?

    # Calling Create-User Functon 
    CREATE_USER

    # Calling Download_And_Extract Function
    DOWNLOAD_AND_EXTRACT

    # Calling Maven Package Functon
    MVN_PACKAGE

    # Calling Config-Svc Function
    CONFIG_SVC

}

NODEJS() {

    echo -n "Configuring the nodejs repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | bash -  &>> $LOGFILE
    stat $?

    echo -n "Installing NodeJS :"
    yum install nodejs -y    &>> $LOGFILE
    stat $?

    # Calling Create-User Functon 
    CREATE_USER

    # Calling Download_And_Extract Function
    DOWNLOAD_AND_EXTRACT

    # Calling NPM install function
    NPM_INSTALL

    # Calling Config-Svc Function
    CONFIG_SVC

}



