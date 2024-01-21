#!/bin/bash 

# This is a script created to launch EC2 Servers and create the associated Route53 Record 

aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58 | jq '.Images[].ImageId'
echo -n "Ami ID is $AMI_ID"

echo -n "Launching the instance with $AMI_ID as AMI :"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')