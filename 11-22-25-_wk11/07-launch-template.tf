resource "aws_launch_template" "terraform-lt" {
  name_prefix   = "terraform-lt"
  description   = "launch template for the web tier apps"
  image_id      = "ami-0cae6d6fe6048ca2c"
  instance_type = "t3.micro"

  #   key_name = ""

  vpc_security_group_ids = [aws_security_group.my-working-server-sg.id]

  user_data = base64encode(file("user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "terraform-lt"
      Service = "terraform"
      Owner   = "Dennis"
      Planet  = "Planet-Rock"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
# name
# description
# ami
# instance type
# key
# SG
# public IP true/false
# user data