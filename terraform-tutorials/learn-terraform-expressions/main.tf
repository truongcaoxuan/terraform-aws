# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      hashicorp-learn = "expressions"
    }
  }
}





resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.common_tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = local.common_tags
}

resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_subnet

  tags = local.common_tags
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_elb" "learn" {
  name    = "Learn-ELB"
  subnets = [aws_subnet.subnet_public.id]
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  #instances                   = [aws_instance.ubuntu.id]
  instances                   = aws_instance.ubuntu[*].id
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = local.common_tags
}


