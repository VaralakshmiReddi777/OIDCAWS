resource "aws_iam_policy" "shopFloorAlert_lambda_policy" {
  name        = "shopFloorAlert_lambda_policy"
  path        = "/"
  description = "Policy to be attached to lambda"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ses:*",
          "logs:*",
          "dynamodb:DescribeStream",
          "dynamodb:GetRecords",
          "dynamodb:GetShardIterator",
          "dynamodb:ListStreams",
        ],
        "Resource" : "*"
      }
    ]
  })
}
