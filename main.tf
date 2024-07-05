provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_role" "shopFloorAlert_lambda_role" {
  name = "shopFloorAlert_lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

