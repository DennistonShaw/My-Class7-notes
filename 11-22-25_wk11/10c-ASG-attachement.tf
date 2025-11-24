# Attaches the ASG to the Target Group
resource "aws_autoscaling_attachment" "terraform_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
  lb_target_group_arn    = aws_lb_target_group.terraform-tg.arn
}