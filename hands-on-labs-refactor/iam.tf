// Get data s3 bucket arn from data_aws_res.tf
resource "aws_iam_policy" "policy" {
  name        = "data_bucket_policy"
  description = "Denyaccesstomybucket"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:Get*",
          "s3:List*"
        ],
        "Resource" : "${data.aws_s3_bucket.data_bucket.arn}"
      }
    ]
  })
}