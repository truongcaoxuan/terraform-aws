#Define the VPC 
resource "aws_vpc" "res_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "res-${var.vpc_name}"
    Environment = upper(var.environment)
    Terraform   = upper("true")
    # Region 		= data.aws_region.current.name
    # Region 		= var.aws_region
  }
}
#Create Internet Gateway
resource "aws_internet_gateway" "res_igw" {
  vpc_id = aws_vpc.res_vpc.id

  tags = {
    Name = "res-demo-igw"
  }
}

#Create EIP for NAT Gateway
resource "aws_eip" "res_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.res_igw]

  tags = {
    Name = "res-demo_igw_eip"
  }
}

# Deploy the private subnets using Terraform function: cidrsubnet, tolist
# https://developer.hashicorp.com/terraform/language/functions/cidrsubnet
resource "aws_subnet" "res_privates" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.res_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = {
    Name      = "res-${each.key}"
    Terraform = "true"
  }
}

# Deploy the public subnets using Terraform function: cidrsubnet, tolist
resource "aws_subnet" "res_publics" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.res_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name      = "res-${each.key}"
    Terraform = "true"
  }
}

# Deploy the variables subnet
resource "aws_subnet" "res_var_subnet" {
  vpc_id                  = aws_vpc.res_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.subnet_az
  map_public_ip_on_launch = var.subnet_auto_ip

  tags = {
    Name      = "res-var-${var.subnet_az}"
    Terraform = "true"
  }
}

# Create route tables for public and private subnets
resource "aws_route_table" "res_public_rtb" {
  vpc_id = aws_vpc.res_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.res_igw.id
    #nat_gateway_id = aws_nat_gateway.res_natgw.id
  }
  tags = {
    Name      = "res-demo_public_rtb"
    Terraform = "true"
  }
}

resource "aws_route_table" "res_private_rtb" {
  vpc_id = aws_vpc.res_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    # gateway_id     	= aws_internet_gateway.internet_gateway.id
    nat_gateway_id = aws_nat_gateway.res_natgw.id
  }
  tags = {
    Name      = "res-demo_private_rtb"
    Terraform = "true"
  }
}

# Create route table associations
resource "aws_route_table_association" "public" {
  depends_on     = [aws_subnet.res_publics]
  route_table_id = aws_route_table.res_public_rtb.id
  for_each       = aws_subnet.res_publics
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "private" {
  depends_on     = [aws_subnet.res_privates]
  route_table_id = aws_route_table.res_private_rtb.id
  for_each       = aws_subnet.res_privates
  subnet_id      = each.value.id
}

# Create NAT Gateway
resource "aws_nat_gateway" "res_natgw" {
  depends_on    = [aws_subnet.res_publics]
  allocation_id = aws_eip.res_eip.id
  subnet_id     = aws_subnet.res_publics["public_subnet_1"].id

  tags = {
    Name = "res-demo_nat_gateway"
  }
}

/*
resource "aws_subnet" "var_subnet_single" {
  vpc_id = aws_vpc.res_vpc.id
  #cidr_block        = "10.0.200.0/24"
  #cidr_block        = var.ip_map_str["prod"]
  cidr_block        = var.ip_map_str[var.environment]
  availability_zone = var.us-east-1-azs_list_str[0]
}
*/

resource "aws_subnet" "var_subnet_for_each" {
  vpc_id            = aws_vpc.res_vpc.id
  for_each          = var.ip_map_str
  cidr_block        = each.value
  availability_zone = var.us-east-1-azs_list_str[0]
}

resource "aws_subnet" "var_subnet_for_each_map" {
  vpc_id            = aws_vpc.res_vpc.id
  for_each          = var.env_map_any
  cidr_block        = each.value.ip
  availability_zone = each.value.az
}