data "aws_iam_policy_document" "lambda_execution_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Grant permission to write data to DynamoDB
resource "aws_iam_policy" "dynamodb_write_policy" {
  name        = "dynamodb-write-policy"
  description = "Policy to allow writing to DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
        ],
        Effect   = "Allow",
       Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "dynamodb_write_policy_attachment" {
  name       = "dynamodb_write_policy_attachment"
  roles      = [aws_iam_role.lambda_execution_role.name]
  policy_arn = aws_iam_policy.dynamodb_write_policy.arn
}
