#environmental variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

#vpc variables
variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "pub_myapp_subnet_az1_cidr" {
  description = "public my app subnet az1 cidr block"
  type        = string
}
variable "pub_myapp_subnet_az2_cidr" {
  description = "public my app subnet az2 cidr block"
  type        = string
}

variable "private_myapp_subnet_az1_cidr" {
  description = "private my app subnet az1 cidr block"
  type        = string
}

variable "private_myapp_subnet_az2_cidr" {
  description = "private my app subnet az2 cidr block"
  type        = string
}

variable "private_myappdata_subnet_az1_cidr" {
  description = "private my app database subnet az1 cidr block"
  type        = string
}
variable "private_myappdata_subnet_az2_cidr" {
  description = "private my app database subnet az2 cidr block"
  type        = string
}

# Security groups variables
variable "ssh_location" {
  description = "ip that can ssh into the server"
  type        = string
}

# rds variables
variable "database_instance_class" {
  description = "database instance type"
  type        = string
}

variable "database_instance_identifier" {
  description = "database instance identifier"
  type        = string
}

variable "multi_az_deployment" {
  description = "create a standby db instance"
  type        = bool
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

# acm variables
variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "subject_alternative_names" {
  description = "sub domain names"
  type        = string
}

# ecs variables
variable "architecture" {
  description = "ecs cpu architecture"
  type        = string
}

variable "container_image" {
  description = "container image uri"
  type        = string
}
# S3 variables
variable "env_file_bucket_name" {
  description = "s3 bucket name"
  type        = string
}

variable "env_file_name" {
  description = "env file name"
  type        = string
}
# route53 variables
variable "record_name" {
  description = "sub domain name"
  type = string
}