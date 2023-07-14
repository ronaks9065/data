# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "RP-TF-VPC"
  }
}

# Four subnet public & private
resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "ap-south-1a"
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "RP-TF-Public-Subnet"
  }
}

resource "aws_subnet" "subnet_public1" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "ap-south-1b"
  cidr_block = var.public_subnet_cidr1

  tags = {
    Name = "RP-TF-Public-Subnet1"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "ap-south-1b"
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "RP-TF-Private-Subnet"
  }
}

resource "aws_subnet" "subnet_private1" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "ap-south-1c"
  cidr_block = var.private_subnet_cidr1

  tags = {
    Name = "RP-TF-Private-Subnet1"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RP-TF-IGW"
  }
}

# two Route table public & private

# Public Route Table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Public_route_table"
  }
}

resource "aws_route_table" "public_route_table1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Public_route_table1"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route = []

  tags = {
    Name = "Private_route_table"
  }
}

# in public Route table subnet association
resource "aws_route_table_association" "aw_public_route_table" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.public_route_table.id
  depends_on = [ aws_route_table.public_route_table, aws_subnet.subnet_public ]
}

resource "aws_route_table_association" "aw_public_route_table1" {
  subnet_id      = aws_subnet.subnet_public1.id
  route_table_id = aws_route_table.public_route_table1.id
}

# # add public route in public route table
# resource "aws_route" "internet_gateway_route" {
#   route_table_id            = aws_route_table.public_route_table.id
#   destination_cidr_block    = "0.0.0.0/0"
#   gateway_id                = aws_internet_gateway.gw.id
# }
# 

