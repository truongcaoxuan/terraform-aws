resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = var.size
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  tags = {
    "Name"        = "EC2 Server from Module"
    "Environment" = "Training"
  }
}

