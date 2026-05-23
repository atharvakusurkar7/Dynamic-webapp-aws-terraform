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
  type = string
}

variable "pub_myapp_subnet_az1_cidr" {
  description = "public my app subnet az1 cidr block"
    type = string
}
variable "pub_myapp_subnet_az2_cidr" {
  description = "public my app subnet az2 cidr block"
    type = string
}

variable "private_myapp_subnet_az1_cidr" {
  description = "private my app subnet az1 cidr block"
    type = string
}

variable "private_myapp_subnet_az2_cidr" {
  description = "private my app subnet az2 cidr block"
    type = string
}

variable "private_myappdata_subnet_az1_cidr" {
  description = "private my app database subnet az1 cidr block"
  type = string
}
variable "private_myappdata_subnet_az2_cidr" {
  description = "private my app database subnet az2 cidr block"
  type = string
}
