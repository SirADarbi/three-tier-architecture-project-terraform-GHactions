variable "project_name" {
  description = "The name of the project used to prefix all resources"
  type        = string
  default     = "three-tier-architecture"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "The number of availability zones to use"
  type        = number
  default     = 2
}

variable "aws_region" {
  description = "The region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "appdb"
}

variable "instance_class" {
  description = "The instance class for the RDS database"
  type        = string
  default     = "db.t3.micro"
}

variable "instance_type" {
  description = "The EC2 instance type for web and app tiers"
  type        = string
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "The desired number of EC2 instances in the ASG"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the ASG"
  type        = number
  default     = 4
}
