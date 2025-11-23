resource "aws_lb_target_group" "terraform-tg" {
  name        = "terraform-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.terraform-vpc.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "terraform-target-group"
    Service = "terraform"
    Owner   = "Dennis"
    Project = "Web Service"
  }
}