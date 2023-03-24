#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

# Terraform Data Block - Lookup Ubuntu 20.04
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

# Terraform Resource Block - To Build EC2 instance in Public Subnet
resource "aws_instance" "web_server" {                            # BLOCK
  ami           = data.aws_ami.ubuntu.id                          # Argument with data expression
  instance_type = "t2.micro"                                      # Argument
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id # Argument with value as expression
  tags = {
    Name = "Web EC2 Server"
  }
}