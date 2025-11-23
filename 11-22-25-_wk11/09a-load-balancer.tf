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

  enable_deletion_protection = false #Lots of death and suffering here, make sure it's false

  tags = {
    Name    = "terraform-load-balancer"
    Service = "terraform"
    Owner   = "Dennis"
    Project = "Web Service"
  }
}