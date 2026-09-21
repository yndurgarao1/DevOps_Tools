#!/bin/bash

# Navigate to home directory
cd /home/ec2-user || exit

# Prompt user for AWS credentials
read -p "Enter AWS Access Key ID: " ACCESS_KEY
read -p "Enter AWS Secret Access Key: " SECRET_KEY

# Create provider.tf with user input
cat <<EOF > provider.tf
provider "aws" {
  region     = "us-east-1"
  access_key = "${ACCESS_KEY}"
  secret_key = "${SECRET_KEY}"
}
EOF