# https://developer.hashicorp.com/terraform/language/data-sources

data "aws_s3_bucket" "data_bucket" {
  bucket = module.s3-bucket.s3_bucket_id
}

