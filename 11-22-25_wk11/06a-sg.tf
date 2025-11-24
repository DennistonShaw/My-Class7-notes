
# for web server only 
resource "aws_security_group" "my-working-server-sg" {
  name        = "my-working-server-sg"
  description = "Allow HTTP and SSH for web server"
  vpc_id      = aws_vpc.terraform-vpc.id

  tags = {
    Name = "my-working-server-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "my-working-server-sg-http" {
  security_group_id = aws_security_group.my-working-server-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "my-working-server-sg-ssh" {
  security_group_id = aws_security_group.my-working-server-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "my-working-server-sg-egress" {
  security_group_id = aws_security_group.my-working-server-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}