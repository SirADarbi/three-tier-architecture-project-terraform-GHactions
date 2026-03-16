output "dns_name" {
  description = "The DNS name of the web ALB"
  value       = aws_lb.web_alb.dns_name
}
