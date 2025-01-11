# Load Balancer for ASG
resource "aws_lb" "linux_alb" {
  name               = "linux-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = [var.subnet_id_1, var.subnet_id_2]

  enable_deletion_protection = false
  idle_timeout               = 60
  tags = {
    Name = "Linux-ALB"
  }
}

resource "aws_lb_target_group" "linux_tg" {
  name        = "linux-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "linux_listener" {
  load_balancer_arn = aws_lb.linux_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.linux_tg.arn
  }
}

# Linux Auto Scaling Group
resource "aws_launch_template" "linux_launch_template" {
  name          = "linux-launch-template"
  image_id      = var.ami_image_id  //linux-instance
  instance_type = var.instance_type
  key_name      = var.key_name

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    name = var.iam_instance_profile
  }
  
  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.subnet_id_1
    security_groups             = [var.task_sg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Linux-ASG-Instance"
      Owner = "Rishikesh"
    }
  }
}

resource "aws_autoscaling_group" "linux_asg" {
  launch_template {
    id      = aws_launch_template.linux_launch_template.id

    version = "$Latest"
  }

  vpc_zone_identifier = [var.subnet_id_1, var.subnet_id_2]
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1

  target_group_arns = [aws_lb_target_group.linux_tg.arn]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key = "Name"
    value = "Linux-ASG-Instance"
    propagate_at_launch = true
  }

}

# CloudWatch Alarm for CPU > 50%
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "HighCPUAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.linux_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

# Auto Scaling Policy for Scale Out
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.linux_asg.name
}