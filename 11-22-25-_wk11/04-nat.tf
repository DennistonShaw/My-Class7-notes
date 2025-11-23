resource "aws_eip" "terraform-nat" {
  domain = "vpc"

  tags = {
    Name = "terraform-eip-nat"
  }

  depends_on = [aws_internet_gateway.terraform-igw] # explict dependency 
}

resource "aws_nat_gateway" "terraform-nat-gw" {
  allocation_id = aws_eip.terraform-nat.id # implict dependency for eip
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "terraform-nat-gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.terraform-igw]
}