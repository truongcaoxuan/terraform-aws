resource "aws_vpc" "vpc-region-default" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name        = "vpc-region-default"
    Environment = "prod_environment"
    Terraform   = "true"
  }
}

resource "aws_vpc" "vpc-region-west1" {
  provider   = aws.west1
  cidr_block = "10.10.0.0/16"

  tags = {
    Name        = "vpc-region-west1"
    Environment = "dr_environment"
    Terraform   = "true"
  }
}

resource "aws_vpc" "vpc-region-west2" {
  provider   = aws.west2
  cidr_block = "10.10.0.0/16"

  tags = {
    Name        = "vpc-region-west2"
    Environment = "dr_environment"
    Terraform   = "true"
  }
}