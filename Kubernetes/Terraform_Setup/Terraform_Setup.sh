#!/bin/bash
sudo su 
yum update -y
yum install -y git
sudo wget https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_386.zip
mv terraform_1.15.8_linux_386.zip /usr/local/bin/
cd /usr/local/bin
unzip terraform_1.15.8_linux_386.zip
mkdir AWS_Terraform
cp /home/ec2-user/DevOps_Tools/Kubernetes/Terraform_Setup/AWS_Provider.sh /home/ec2-user/AWS_Terraform
cp /home/ec2-user/DevOps_Tools/Kubernetes/K8S_CLuster_Setup_Terraform_Code/K8S_Cluster_Setup.tf /home/ec2-user/AWS_Terraform