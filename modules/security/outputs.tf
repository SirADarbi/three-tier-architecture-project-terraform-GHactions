output "web_alb_sg_id" {
  value       = aws_security_group.web_alb_sg.id
  description = "The ID of the web ALB security group"
}

output "web_ec2_sg_id" {
  value       = aws_security_group.web_ec2_sg.id
  description = "The ID of the web EC2 security group"
}

output "app_alb_sg_id" {
  value       = aws_security_group.app_alb_sg.id
  description = "The ID of the app ALB security group"
}

output "app_ec2_sg_id" {
  value       = aws_security_group.app_ec2_sg.id
  description = "The ID of the app EC2 security group"
}

output "db_sg_id" {
  value       = aws_security_group.db_sg.id
  description = "The ID of the db security group"
}