resource "aws_autoscaling_group" "terraform-asg" {
  name_prefix      = "terraform-auto-scaling-group"
  min_size         = 3 # minimum desired capacity is usually 1 EC2 per AZ
  desired_capacity = 6 # desired capacity is usually 2 EC2s per AZ
  max_size         = 9 # max desired capacity is usually 3 EC2s per AZ
  vpc_zone_identifier = [ aws_subnet.private-us-east-1a.id,
                          aws_subnet.private-us-east-1b.id,
                          aws_subnet.private-us-east-1c.id ]

  health_check_type         = "ELB"
  health_check_grace_period = 300
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.terraform-tg.arn]

  launch_template {
    id      = aws_launch_template.terraform-lt.id
    version = "$Latest"
  }

  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]

  # Instance protection for launching
  initial_lifecycle_hook {
    name                  = "instance-protection-launch"
    lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
    default_result        = "CONTINUE"
    heartbeat_timeout     = 60
    notification_metadata = "{\"key\":\"value\"}"
  }

  # Instance protection for terminating
  initial_lifecycle_hook {
    name                 = "scale-in-protection"
    lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 300
  }

  tag {
    key                 = "Name"
    value               = "terraform-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}