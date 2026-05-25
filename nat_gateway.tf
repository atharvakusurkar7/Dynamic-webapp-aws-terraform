#allocate elastic ip for nat gateway used for public subnet az1
resource "aws_eip" "myapp_eip1" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gw-eip-az1"
  }
}

#create nat gateway in public subnet az1
resource "aws_nat_gateway" "myapp_nat_gw_az1" {
  allocation_id = aws_eip.myapp_eip1.id
  subnet_id     = aws_subnet.pub_myapp_subnet_az1.id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gw-az1"
  }
  depends_on = [aws_internet_gateway.myapp_igw]
}

#create private route table for private subnets and add route to nat gateway
resource "aws_route_table" "myapp_private_rt_az1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.myapp_nat_gw_az1.id
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt-az1"
  }
}

#associate private app subnet az1 to private route table az1
resource "aws_route_table_association" "myapp_private_rt_assoc_az1" {
  subnet_id      = aws_subnet.private_myapp_subnet_az1.id
  route_table_id = aws_route_table.myapp_private_rt_az1.id
}

#associate private data subnet az1 to private route table az1
resource "aws_route_table_association" "myapp_private_data_rt_assoc_az1" {
  subnet_id      = aws_subnet.private_myappdata_subnet_az1.id
  route_table_id = aws_route_table.myapp_private_rt_az1.id
}

# associate private app subnet az2 to private route table az1
resource "aws_route_table_association" "myapp_private_rt_assoc_az2" {
  subnet_id      = aws_subnet.private_myapp_subnet_az2.id
  route_table_id = aws_route_table.myapp_private_rt_az1.id
}

# associate private data subnet az2 to private route table az1
resource "aws_route_table_association" "myapp_private_data_rt_assoc_az2" {
  subnet_id      = aws_subnet.private_myappdata_subnet_az2.id
  route_table_id = aws_route_table.myapp_private_rt_az1.id
}