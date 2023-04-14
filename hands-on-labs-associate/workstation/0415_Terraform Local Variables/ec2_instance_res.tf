# ========================================
# Retrieve the list of AZs in the current AWS region
# ========================================
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

# ========================================
# Terraform Data Block - Lookup Ubuntu 20.04
# ========================================
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
# ========================================
# Locals
# ========================================
locals {
  time        = timestamp()
  team        = "api_mgmt_dev"
  application = "app-server"
  server_name = "ec2-${var.environment}-api-${local.application}"
}

locals {
  common_tags = {
    Name  = lower("${local.server_name}-aws-linux-res")
    Owner = lower(local.team)
    App   = lower(local.application)
  }
}

# ========================================
# Key pair
# ========================================
resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated" {
  key_name   = "MyPublicKey${var.environment}"
  public_key = tls_private_key.generated.public_key_openssh

  lifecycle {
    ignore_changes = [key_name]
  }
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "MyPrivateKey-${var.environment}-${terraform.workspace}.pem"
}

# ============================================
# Terraform Resource Block - To Build EC2 instance in Public Subnet
# ========================================
resource "aws_instance" "ubuntu_server" {
  #depends_on    = [aws_nat_gateway.res_natgw]
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.res_publics["public_subnet_1"].id

  security_groups             = [aws_security_group.icmp-traffic.id, aws_security_group.ingress-ssh.id, aws_security_group.web-traffic.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated.key_name

  connection {
    user        = "ubuntu"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
  }

  tags = {
    Name  = "${local.server_name}-ubuntu-res"
    Owner = local.team
    App   = local.application
  }

  lifecycle {
    ignore_changes = [security_groups]
  }

  provisioner "local-exec" {
    command = "chmod 600 ${local_file.private_key_pem.filename}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /tmp",
      "sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp",
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }

}
# Terraform Resource Block - To Build EC2 instance in Public Subnet
resource "aws_instance" "web_server" {
  #depends_on    = [aws_nat_gateway.res_natgw]
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.res_publics["public_subnet_1"].id

  security_groups             = [aws_security_group.icmp-traffic.id, aws_security_group.ingress-ssh.id, aws_security_group.web-traffic.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated.key_name

  connection {
    user        = "ubuntu"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
  }

  tags = {
    Name  = "${local.server_name}-web-res"
    Owner = local.team
    App   = local.application
  }

  lifecycle {
    ignore_changes = [security_groups]
  }

  provisioner "local-exec" {
    command = "chmod 600 ${local_file.private_key_pem.filename}"
  }

  provisioner "remote-exec" {
    inline = [
      //"exit 2",
      "sudo rm -rf /tmp",
      "sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp",
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }

}

resource "aws_instance" "aws_linux" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"

  tags = local.common_tags
}