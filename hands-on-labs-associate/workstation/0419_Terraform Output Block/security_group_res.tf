# ========================================
# Create Security Group - SSH Traffic
# ========================================
resource "aws_security_group" "ingress-ssh" {
  name   = "allow-all-ssh-${terraform.workspace}-sg"
  vpc_id = aws_vpc.res_vpc.id
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
    #prevent_destroy       = true
  }
}

# ========================================
# Create Security Group - Web Traffic
# ========================================
resource "aws_security_group" "web-traffic" {
  name        = "allow-web-traffic-${terraform.workspace}-sg"
  vpc_id      = aws_vpc.res_vpc.id
  description = "Web Traffic"
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
    #prevent_destroy       = true
  }
}

# ========================================
# Create Security Group - ICMP Traffic
# ========================================
resource "aws_security_group" "icmp-traffic" {
  name        = "allow-icmp-ping-${terraform.workspace}-sg"
  vpc_id      = aws_vpc.res_vpc.id
  description = "ICMP for Ping Access"

  ingress {
    description = "Allow ICMP Traffic"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
    #prevent_destroy       = true
  }
}

# ========================================
# Create Security Group Web Traffic - Dynamic Local 
# ========================================
locals {
  ingress_rules = [{
    port        = 443
    description = "Port443"
    },
    {
      port        = 80
      description = "Port80"
    }
  ]
}

resource "aws_security_group" "web-traffic-dynamic-local" {
  name   = "allow-web-traffic-dynamic-local-sg"
  vpc_id = aws_vpc.res_vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  lifecycle {
    create_before_destroy = true
    #prevent_destroy       = true
  }
}

# ========================================
# Create Security Group Web Traffic - Dynamic Variable
# ========================================
resource "aws_security_group" "web-traffic-dynamic-var" {
  name   = "allow-web-traffic-dynamic-var-sg"
  vpc_id = aws_vpc.res_vpc.id

  dynamic "ingress" {
    for_each = var.web_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  lifecycle {
    create_before_destroy = true
    #prevent_destroy       = true
  }

}