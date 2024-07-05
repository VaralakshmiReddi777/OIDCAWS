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

resource "aws_iam_role_policy_attachment" "shopFloorAlert_lambda_role_attach" {
  role       = aws_iam_role.shopFloorAlert_lambda_role.name
  policy_arn = aws_iam_policy.shopFloorAlert_lambda_policy.arn
}
