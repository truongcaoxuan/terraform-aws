terraform {
  required_version = "~> 1.4.2"

  /* Uncomment this block to use Terraform Cloud
  cloud {
      organization = "organization-name"
      workspaces {
        name = "learn-terraform-*"
      }
  }
  */

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " 4.59.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }

  /*
  # Local backend
  backend "local" {
    path = "terraform.tfstate.d"
  }

  # S3 backend
  backend "s3" {
    bucket = "my-terraform-state-truongcx"
    key    = "prod/aws_infra"
    region = var.aws_region

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

  # HTTP backend
  backend "http" {
    address      = "http://localhost:5000/terraform_state/my_state"
    lock_address = "http://localhost:5000/terraform_lock/my_state"

    lock_method    = "PUT"
    unlock_address = "http://localhost:5000/terraform_lock/my_state"
    unlock_method  = "DELETE"
  }

  # TFC (Terraform Cloud) backend
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "YOUR-ORGANIZATION"

    workspaces {
      name = "my-aws-app"
    }
  }
*/

}
