#create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

#create internet gateway and attach to vpc
resource "aws_internet_gateway" "myapp_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

#use data source to get availability zones
data "aws_availability_zones" "available_zones" {}

#create public subnet az1
resource "aws_subnet" "pub_myapp_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_myapp_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public_AZ1"
  }
}
#create public subnet az2
resource "aws_subnet" "pub_myapp_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_myapp_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public_AZ2"
  }
}

#create route table and add public route
resource "aws_route_table" "myapp_public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp_igw.id
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

#associate public subnets az1 to public route table
resource "aws_route_table_association" "myapp_public_rt_assoc_az1" {
  subnet_id      = aws_subnet.pub_myapp_subnet_az1.id
  route_table_id = aws_route_table.myapp_public_rt.id
}

#associate public subnets az2 to public route table
resource "aws_route_table_association" "myapp_public_rt_assoc_az2" {
  subnet_id      = aws_subnet.pub_myapp_subnet_az2.id
  route_table_id = aws_route_table.myapp_public_rt.id
}

#create private subnet az1
resource "aws_subnet" "private_myapp_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_myapp_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private_AZ1"
  }
}
#create private subnet az2
resource "aws_subnet" "private_myapp_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_myapp_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private_AZ2"
  }
}

#create private data subnet az1
resource "aws_subnet" "private_myappdata_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_myappdata_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-myappdata_AZ1"
  }
}
#create private data subnet az2
resource "aws_subnet" "private_myappdata_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_myappdata_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-myappdata_AZ2"
  }
}