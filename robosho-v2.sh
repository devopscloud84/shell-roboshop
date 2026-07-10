#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
ZONE_ID="Z02249102KA0AGQ9QRMTE" # replace with your zone ID
DOMAIN_NAME="daws8486.online" # replace with your domain name
DOMAIN_NAME="daws90s.shop" # replace with your domain name
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

### Validation ###
if [ $# -lt 2 ]; then
    echo -e "$R ERROR:: Atleast 2 arguments required $N"
    echo "USAGE: $0 [create/delete] [instance1] [instance2...]"
    exit 1
fi