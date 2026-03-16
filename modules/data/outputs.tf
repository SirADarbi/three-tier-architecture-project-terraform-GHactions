output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.db_instance.endpoint
  sensitive   = true
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.db_instance.port
}
