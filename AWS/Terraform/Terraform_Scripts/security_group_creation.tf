resource "aws_vpc" "my-vpc" {
    cidr_block = "25.30.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "my-vpc"
    }
}


resource "aws_security_group" "sg_terraform" {
    name        = "sg_terraform"
    description = "Security group created by Terraform"
    vpc_id      = aws_vpc.my-vpc.id
    tags = {
        Name = "SG-1-Terraform"
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [0.0.0.0/0]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [0.0.0.0/0]
    
    }
    
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [0.0.0.0/0]
 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

