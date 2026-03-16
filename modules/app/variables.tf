variable "project_name" {
  description = "The name of the project used to prefix all resources"
  type        = string
  default     = "three-tier-architecture"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "app_alb_sg_id" {
  description = "The ID of the app ALB security group"
  type        = string
}

variable "app_ec2_sg_id" {
  description = "The ID of the app EC2 security group"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "The minimum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of instances in the ASG"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "The desired number of instances in the ASG"
  type        = number
  default     = 2
}
