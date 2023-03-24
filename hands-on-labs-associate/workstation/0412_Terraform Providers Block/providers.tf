# Configure the AWS Provider
provider "aws" {
    region  = "us-east-1"
    access_key="my-access-key"
    secret_key="my-secret-key"
    shared_credentials_file="/Users/tf_user/.aws/creds"
    profile="customprofile"
}