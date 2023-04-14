variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
  validation {
    condition     = can(regex("^us-", var.aws_region))
    error_message = "The aws_region value must be a valid region in the USA, starting with \"us-\"."
  }
}

variable "environment" {
  description = "Environment for deployment"
  type        = string
  default     = "dev"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "demo_vpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "Private Subnet"
  default = {
    "private_subnet_1" = 1
    "private_subnet_2" = 2
    "private_subnet_3" = 3
  }
}

variable "public_subnets" {
  description = "Public Subnet"
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
    "public_subnet_3" = 3
  }
}

variable "subnet_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "10.0.202.0/24"
}

variable "subnet_az" {
  description = "Availability Zone used for Variables Subnet"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_auto_ip" {
  description = "Set Automatic IP Assigment for Variables Subnet"
  type        = bool
  default     = true
}

variable "us-east-1-azs_list_str" {
  description = "List string us-east-1 AZs"
  type        = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e"
  ]
}

variable "ip_map_str" {
  description = "Map string IPs"
  type        = map(string)
  default = {
    prod = "10.0.150.0/24"
    dev  = "10.0.250.0/24"
  }
}

variable "env_map_any" {
  description = "Map any IPs & AZs"
  type        = map(any)
  default = {
    prod = {
      ip = "10.0.160.0/24"
      az = "us-east-1a"
    }
    dev = {
      ip = "10.0.170.0/24"
      az = "us-east-1e"
    }
  }
}

#----------------------------------------------
variable "num_1" {
  description = "Numbers for function labs"
  type        = number
  default     = 88
}
variable "num_2" {
  description = "Numbers for function labs"
  type        = number
  default     = 73
}
variable "num_3" {
  description = "Numbers for function labs"
  type        = number
  default     = 52
}

#-----------------------------------------------
variable "web_ingress" {
  description = "Map object security group rule"
  type = map(object(
    {
      description = string
      port        = number
      protocol    = string
      cidr_blocks = list(string)
    }
  ))
  default = {
    "80" = {
      description = "Port80"
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "443" = {
      description = "Port443"
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}