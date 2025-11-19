resource "aws_launch_template" "terraform-LT" {
  name_prefix   = "terraform-LT"
  image_id      = "ami-0cae6d6fe6048ca2c"
  instance_type = "t3.micro"

  #   key_name = "MyLinuxBox"

  vpc_security_group_ids = [aws_security_group.my-working-server-sg.id]

  user_data = base64encode(file("user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "terraform-LT"
      Service = "terraform"
      Owner   = "Dennis"
      Planet  = "Planet-Rock"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}