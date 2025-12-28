########################## Public subnets ##########################


resource "aws_subnet" "public-us-east-1a" {
  vpc_id = aws_vpc.terraform-vpc.id
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in this subnet 
  # which VPC to create subnet in

  cidr_block              = "10.71.1.0/24"
  availability_zone       = "us-east-1a" # specify AZ 
  map_public_ip_on_launch = true         # allow public IPs to be assigned 

  tags = {
    Name = "public-subnet-us-east-1a"
  }
}


resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.71.2.0/24"
  availability_zone       = "us-east-1b" # specify AZ 
  map_public_ip_on_launch = true         # allow public IPs to be assigned 

  tags = {
    Name = "public-subnet-us-east-1b"
  }
}


resource "aws_subnet" "public-us-east-1c" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.71.3.0/24"
  availability_zone       = "us-east-1c" # specify AZ 
  map_public_ip_on_launch = true         # allow public IPs to be assigned 

  tags = {
    Name = "public-subnet-us-east-1c"
  }
}


########################## Private subnets ##########################

resource "aws_subnet" "private-us-east-1a" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.71.11.0/24"
  availability_zone       = "us-east-1a" # specify AZ 
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-us-east-1a"
  }
}


resource "aws_subnet" "private-us-east-1b" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.71.12.0/24"
  availability_zone       = "us-east-1b" # specify AZ 
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-us-east-1b"
  }
}


resource "aws_subnet" "private-us-east-1c" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.71.13.0/24"
  availability_zone       = "us-east-1c" # specify AZ 
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-us-east-1c"
  }
}