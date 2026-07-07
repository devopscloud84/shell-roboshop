#!/bin/bash

LOGS_FOLDER="/var/logs/roboshop"
sudo mkdir -p $LOGS_FOLDER
sudo chown -R ec2-user:ec2-user $LOGS_FOLDER
sudo chmod -R 755 $LOGS_FOLDER
LOGS_FILE="$LOGS_FOLDER/$0.log"




USERID=$(id -u)
R="/e[31m"
G="/e[32m"
Y="/e[33m"
N="/e[0m"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0]; then
echo  -e "$TIMESTAMP [ERROR] $R please run this script with root access $N" | tee -a $LOGS_FILE
    exit 1
fi

 VALIDATE(){
    if [ $1 -ne 0]; then
        echo -e "$TIMESTAMP [ERROR] $2...$R FAILURE $N" |tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$TIMESTAMP [SUCCESS] $2...$G SUCCESS $N" |tee -a $LOGS_FILE
    fi
 }

dnf module disable redis -y
dnf module enable redis:7 -y
cp mongo.repo  /etc/yum.repos.d/mongo.repo
VALIDATE $? "Installing redis7"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "Allowing remote connections"

systemctl enable redis 
systemctl start redis 
VALIDATE $? "Started redis"
