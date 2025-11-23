
# for web server only 
resource "aws_security_group" "my-working-server-lb-sg" {
  name        = "my-working-server-lb-sg"
  description = "Allow HTTP and SSH for web server"
  vpc_id      = aws_vpc.terraform-vpc.id

  tags = {
    Name = "my-working-server-lb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "my-working-server-lb-sg-http" {
  security_group_id = aws_security_group.my-working-server-lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "my-working-server-lb-sg-egress-allow-all-ipv4" {
  security_group_id = aws_security_group.my-working-server-lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}