resource "aws_lb" "terraform-alb" {
  name               = "terraform-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my-working-server-lb-sg.id]
  subnets = [
    aws_subnet.public-us-east-1a.id,
    aws_subnet.public-us-east-1b.id,
    aws_subnet.public-us-east-1c.id
  ]
  enable_deletion_protection = false
  #Lots of death and suffering here, make sure it's false

  tags = {
    Name    = "terraformLoadBalancer"
    Service = "terraform"
    Owner   = "Dennis"
    Project = "Web Service"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform-tg.arn
  }
}

# data "aws_acm_certificate" "cert" {
#   domain   = "balerica-aisecops.com"
#   statuses = ["ISSUED"]
#   most_recent = true
# }


# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.terraform_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"  # or whichever policy suits your requirements
#   certificate_arn   = data.aws_acm_certificate.cert.arn



#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.terraform_tg.arn
#   }
# }

output "lb_dns_name" {
  value       = aws_lb.terraform-alb.dns_name
  description = "The DNS name of the terraform Load Balancer."
}