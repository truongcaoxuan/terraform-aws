/*
resource "aws_instance" "app_a" {
  depends_on = [module.vpc]

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.app_security_group.security_group_id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

  tags = {
    Terraform   = "true"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_instance" "app_b" {
  depends_on = [module.vpc]

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id              = module.vpc.private_subnets[1]
  vpc_security_group_ids = [module.app_security_group.security_group_id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

  tags = {
    Terraform   = "true"
    Project     = var.project_name
    Environment = var.environment
  }
}

*/