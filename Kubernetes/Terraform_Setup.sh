#!/bin/bash
sudo su 
yum update -y
cd /usr/local/bin
sudo wget https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_386.zip
unzip terraform_1.15.8_linux_386.zip
cd /home/ec2-user
cd DevOps_Tools/Terrform_EC2_Scripts
cp Cluster_Setup.tf /home/ec2-user
