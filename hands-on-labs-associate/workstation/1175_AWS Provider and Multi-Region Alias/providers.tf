# Configure the AWS Provider region-default
provider "aws" {
  region = "us-east-1"
}

# Configure the AWS Provider region-us-west-1
provider "aws" {
  alias  = "west1"
  region = "us-west-1"
}

# Configure the AWS Provider region-us-west-2
provider "aws" {
  alias  = "west2"
  region = "us-west-2"
}