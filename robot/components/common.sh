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

NODEJS() {
    echo -n "Configuring the nodejs repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | bash -  &>> $LOGFILE
    stat $?
}