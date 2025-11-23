# resource "aws_instance" "my-working-server" {
#   ami                         = "ami-0cae6d6fe6048ca2c"
#   associate_public_ip_address = true
#   instance_type               = "t3.micro"
#   # key_name = 
#   vpc_security_group_ids = [aws_security_group.my-working-server-sg.id]
#   subnet_id              = aws_subnet.public-us-east-1a.id

#   user_data = file("user_data.sh")

#   tags = {
#     Name = "my-working-server"
#   }
# }