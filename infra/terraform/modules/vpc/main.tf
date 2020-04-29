#=================
# Input To Module
#=================
// AWS認証情報
variable "region" {}

// VPC
variable "vpc_cidr_block" {}

// Subnet
variable "subnet_public_1a_cidr_block" {}
variable "subnet_public_1c_cidr_block" {}

// EC2 Instance
variable "instance_app_name" {}

#=============
# VPC
#=============
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.instance_app_name}-vpc"

  }
}

#=================
# Internet Gateway
#=================
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id // アタッチするVPCのID
  tags = {
    Name = "${var.instance_app_name}-internet-gateway"
  }
}

#=============
# Subnet
#=============
resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.vpc.id // アタッチするVPCのID
  cidr_block = var.subnet_public_1a_cidr_block
  availability_zone = var.region
  tags = {
    Name = "${var.instance_app_name}-public-subnet-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = aws_vpc.vpc.id // アタッチするVPCのID
  cidr_block = var.subnet_public_1c_cidr_block
  availability_zone = var.region
  tags = {
    Name = "${var.instance_app_name}-public-subnet-1c"
  }
}

#=============
# Route Table
#=============
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id // アタッチするVPCのID
  tags = {
    Name = "${var.instance_app_name}-public-route-table"
  }
}

#==============================
# Subnet と Route Table の紐付け
#==============================
resource "aws_route_table_association" "public_1a" {
  subnet_id = aws_subnet.public_1a.id // アタッチするSubnetのID
  route_table_id = aws_route_table.public_rt.id // アタッチするRoute TableのID
}

resource "aws_route_table_association" "public_1c" {
  subnet_id = aws_subnet.public_1c.id
  route_table_id = aws_route_table.public_rt.id
}