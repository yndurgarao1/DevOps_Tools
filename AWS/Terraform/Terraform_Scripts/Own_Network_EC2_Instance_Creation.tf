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

resource "aws_security_group" "own-network-sg" {
    name = "Own Network Security Group "
    description = "Allow SSH access"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "Own Network SG "
    }
}

