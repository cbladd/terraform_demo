resource "aws_vpc" "main" {
  count            = 2
  
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC-${count.index}"
  }
}

resource "aws_subnet" "main_subnet_public_1" {
  count = 1
  vpc_id     = aws_vpc.main[0].id
  cidr_block = "10.0.1.0/24"

  tags = {
      Name = "Main-PublicA1-${count.index}"
    }
}

resource "aws_subnet" "main_subnet_public_2" {
  count = 1
  vpc_id     = aws_vpc.main[0].id
  cidr_block = "10.0.2.0/24"

  tags = {
      Name = "Main-PublicA2-${count.index}"
    }
}

data "aws_availability_zones" "available" {} 

resource "aws_subnet" "main_subnet_private_1" {
  count = 1
  vpc_id     = aws_vpc.main[count.index].id
  availability_zone= "us-west-2a"
  map_public_ip_on_launch = false
  cidr_block = "10.0.3.0/24"

  tags = {
      Name = "Main-PrivateB1-${count.index}"
    }
}

resource "aws_subnet" "main_subnet_private_2" {
  count = 1
  vpc_id     = aws_vpc.main[count.index].id
  availability_zone= "us-west-2b"
  map_public_ip_on_launch = false
  cidr_block = "10.0.4.0/24"

  tags = {
      Name = "Main-PrivateB1-${count.index}"
    }
}

resource "aws_subnet" "main_subnet_private_3" {
  count = 1
  vpc_id     = aws_vpc.main[count.index].id
  availability_zone= "us-west-2c"
  map_public_ip_on_launch = false
  cidr_block = "10.0.5.0/24"

  tags = {
      Name = "Main-PrivateB1-${count.index}"
    }
}
resource "aws_security_group" "vpc_sg" {
        count = 1
        vpc_id      = aws_vpc.main[0].id
        name = "vpc_sg"
        description = "Allow all traffic from inside the VPC"
 
        ingress {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = [aws_vpc.main[count.index].cidr_block]
        }
        egress {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = [aws_vpc.main[count.index].cidr_block] 
        }
}

resource "aws_security_group" "ssh_sg" {
        count = 1
        vpc_id      = aws_vpc.main[0].id
        name = "ssh_sg"
        description = "Allow SSH from the jump box"
 
        ingress {
          from_port = 22
          to_port = 22
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        egress {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        }
}

resource "aws_internet_gateway" "gw" {
  count = 1
  vpc_id = aws_vpc.main[count.index].id
  
  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public_table" {
  count = 1
  vpc_id      = aws_vpc.main[0].id
         
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw[count.index].id
    }

  tags = {
    Name = "Public"
  }
}

resource "aws_route_table_association" "us_west_2_public_1" {
  count = 1
  subnet_id = aws_subnet.main_subnet_public_1[count.index].id
  route_table_id = aws_route_table.public_table[count.index].id
}

resource "aws_route_table_association" "us_west_2_public_2" {
  count = 1
  subnet_id = aws_subnet.main_subnet_public_2[count.index].id
  route_table_id = aws_route_table.public_table[count.index].id
}

