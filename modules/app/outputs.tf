output "app_alb_dns_name" {
  description = "The DNS name of the internal app ALB"
  value       = aws_lb.app_alb.dns_name
}
