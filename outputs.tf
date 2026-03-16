output "web_alb_dns_name" {
  description = "The DNS name of the web-facing ALB"
  value       = module.web.dns_name
}

output "app_alb_dns_name" {
  description = "The DNS name of the internal app ALB"
  value       = module.app.app_alb_dns_name
}

output "db_instance_endpoint" {
  description = "The endpoint of the RDS database"
  value       = module.data.db_instance_endpoint
  sensitive   = true
}
