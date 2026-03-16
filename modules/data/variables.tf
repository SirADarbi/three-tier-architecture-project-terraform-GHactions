variable "project_name" {
  description = "The name of the project used to prefix all resources"
  type        = string
  default     = "three-tier-architecture"
}

variable "isolated_subnet_ids" {
  description = "The IDs of the isolated subnets for the database"
  type        = list(string)
}

variable "db_sg_id" {
  description = "The ID of the database security group"
  type        = string
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
