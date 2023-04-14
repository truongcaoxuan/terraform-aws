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
    /*
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
    */
  }
}