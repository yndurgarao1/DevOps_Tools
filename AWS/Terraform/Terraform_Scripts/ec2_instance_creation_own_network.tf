resource "aws_vpc" "my-vpc" {
    cidr_block = "20.30.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "Own Network"
    }
}

resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "20.30.20.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Own Network Public Subnet"
    }
}

resource "aws_internet_gateway" "ynd-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "Own Network IGW"
    }
}


# Fetch the main route table created with the VPC
data "aws_route_table" "main" {
  route_table_id = aws_vpc.my-vpc.main_route_table_id
}

# Add a default route to the Internet Gateway in the main route table
resource "aws_route" "main-default-route" {
  route_table_id         = data.aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ynd-igw.id
}

# Associate your subnet with the main route table
resource "aws_route_table_association" "public-subnet-mrtb" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = data.aws_route_table.main.id
}

resource "aws_eip" "my_eip" {
    tags = {
        Name = "my-eip"
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
        cidr_blocks = ["0.0.0.0/32"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks =  ["${aws_eip.my_eip.public_ip}/32"]
    
    }
    
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks =  ["${aws_eip.my_eip.public_ip}/32"]
 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "my-instance" {
    ami           = "ami-00e801948462f718a"
    instance_type = "t3.micro"
    key_name     = "June"
    subnet_id     = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.sg_terraform.id]
    tags = {
        Name = "Own Network EC2 Instance"
    }
}

# Associate the Elastic IP with the instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.my-instance.id
  allocation_id = aws_eip.my_eip.id
}