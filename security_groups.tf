#create security group for application load balancer
resource "aws_security_group" "myapp_alb_sg" {
  name        = "${var.project_name}-${var.environment}-myapp_alb_sg"
  description = "enable http/https access on port 80/443 for application load balancer"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "allow http traffic from internet to alb"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "allow https traffic from internet to alb"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-myapp_alb_sg"
  }
}

#create security group for the bastion host ka jumpbox
resource "aws_security_group" "myapp_bastion_sg" {
  name        = "${var.project_name}-${var.environment}-myapp_bastion_sg"
  description = "enable ssh access on port 22 for bastion host from internet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "allow ssh traffic from internet to bastion host"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ssh_location]
  }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.project_name}-${var.environment}-myapp_bastion_sg"
    }
}

#create security group for the app server
resource "aws_security_group" "myapp_app_sg" {
  name        = "${var.project_name}-${var.environment}-myapp_app_sg"
  description = "enable http access on port 80/443 for app server from alb security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "allow http traffic from alb to app server"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.myapp_alb_sg.id]
  }

  ingress {
    description      = "allow ssh traffic from internet to app server"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.myapp_alb_sg.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-myapp_app_server_sg"
  }
}

#create security group for the database server
resource "aws_security_group" "myapp_db_sg" {
  name        = "${var.project_name}-${var.environment}-myapp_db_sg"
  description = "enable mysql access on port 3306 for database server from app server security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "allow mysql traffic from app server to database server"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.myapp_app_sg.id]
  }

  ingress {
    description      = "custom access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.myapp_bastion_sg.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-myapp_db_sg"
  }

}

#create security group for rds instance
resource "aws_security_group" "myapp_rds_sg" {
  name        = "${var.project_name}-${var.environment}-myapp_rds_sg"
  description = "enable mysql access on port 3306 for rds instance"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "allow mysql traffic from app server to rds instance"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.myapp_app_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-myapp_rds_sg"
  }
}
