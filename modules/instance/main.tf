resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = var.public_key
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
resource "aws_instance" "jump" {
  ami                     = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type           = "t3.micro"
  subnet_id               = var.public_subnet_ids[0]
  security_groups         = var.security_group_id
  
  key_name                = "ssh-key"
  tags = {
    Name = "jump"
  }
}


