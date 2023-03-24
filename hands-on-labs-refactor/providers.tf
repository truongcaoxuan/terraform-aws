provider "aws" {
  region = var.aws_region
  #access_key 			= " "
  #secret_key 			= " "
  #shared_credentials_file = "/user/name/.aws/creds"
  #profile 				= "profile-us-west-1"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Owner       = "Owner_default_tags"
      Provisioned = "Terraform"
      Environment = "${terraform.workspace}"
    }
  }

}

