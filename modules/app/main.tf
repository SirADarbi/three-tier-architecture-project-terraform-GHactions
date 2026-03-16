data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_lb" "app_alb" {
  name               = "${var.project_name}-app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.app_alb_sg_id]
  subnets            = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-app-alb"
  }
}

resource "aws_lb_target_group" "app_alb_tg" {
  name     = "${var.project_name}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }

  tags = {
    Name = "${var.project_name}-app-tg"
  }
}

resource "aws_lb_listener" "app_alb_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_alb_tg.arn
  }
}

resource "aws_launch_template" "app_ec2_lt" {
  name_prefix   = "${var.project_name}-app-lt-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  network_interfaces {
    security_groups = [var.app_ec2_sg_id]
  }

  user_data = base64encode(file("${path.module}/user-data.sh"))

  tags = {
    Name = "${var.project_name}-app-lt"
  }
}

resource "aws_autoscaling_group" "app_ec2_asg" {
  name                = "${var.project_name}-app-asg"
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.app_alb_tg.arn]
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity

  launch_template {
    id      = aws_launch_template.app_ec2_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-app-ec2"
    propagate_at_launch = true
  }
}
