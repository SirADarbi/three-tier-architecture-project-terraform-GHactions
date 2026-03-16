data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_lb" "web_alb" {
  name               = "${var.project_name}-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.project_name}-web-alb"
  }
}

resource "aws_lb_target_group" "web_alb_tg" {
  name     = "${var.project_name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }

  tags = {
    Name = "${var.project_name}-web-tg"
  }
}

resource "aws_lb_listener" "web_alb_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }
}

resource "aws_launch_template" "web_ec2_lt" {
  name_prefix   = "${var.project_name}-web-lt-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  network_interfaces {
    security_groups = [var.web_ec2_sg_id]
  }

  user_data = base64encode(file("${path.module}/user-data.sh"))

  tags = {
    Name = "${var.project_name}-web-lt"
  }
}

resource "aws_autoscaling_group" "web_ec2_asg" {
  name                = "${var.project_name}-web-asg"
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns   = [aws_lb_target_group.web_alb_tg.arn]
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity

  launch_template {
    id      = aws_launch_template.web_ec2_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web-ec2"
    propagate_at_launch = true
  }
}
