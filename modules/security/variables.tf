variable "project_name" {
  description = "The name of the project used to prefix all resources"
  type        = string
  default     = "three-tier-architecture"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
