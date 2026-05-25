#create database subnet group for rds instance
resource "aws_db_subnet_group" "myapp_db_subnet_group" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = [aws_subnet.private_myappdata_subnet_az1.id, aws_subnet.private_myappdata_subnet_az2.id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  }
}

#create rds instance
resource "aws_db_instance" "myapp_rds_instance" {
  identifier              = "${var.project_name}-${var.environment}-rds-instance"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.database_instance_class
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.myapp_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.myapp_rds_sg.id]
  skip_final_snapshot     = true
  multi_az                = var.multi_az_deployment
  storage_encrypted       = true
  }