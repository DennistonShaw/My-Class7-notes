# Auto Scaling Policy
resource "aws_autoscaling_policy" "terraform-scaling-policy" {
  name                   = "terraform-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.name

  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 120

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}