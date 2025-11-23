
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

# ############################ SG for ping 

# resource "aws_security_group" "my-working-server-sg-ping" {
#   name        = "my-working-server-sg-ping"
#   description = "Allow icmp for ping"
#   vpc_id      = aws_vpc.terraform-vpc.id

#   tags = {
#     Name = "my-working-server-sg-ping"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "my-working-server-sg-icmp" {
#   security_group_id = aws_security_group.my-working-server-sg-ping.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = -1
#   ip_protocol = "icmp"
#   to_port     = -1
# }

# resource "aws_vpc_security_group_egress_rule" "my-working-server-sg-egress_for_ping" {
#   security_group_id = aws_security_group.my-working-server-sg-ping.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
# }