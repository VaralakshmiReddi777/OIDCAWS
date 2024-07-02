provider "aws" {
  region = "us-eest-2"  # Replace with your desired AWS region
}

# Create an AWS Lambda function
resource "aws_lambda_function" "my_lambda_function" {
  function_name = "my-lambda-function"
  role          = aws_iam_role.my_lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.8"
  filename      = "lambda_function.zip"  # Replace with the actual path to your Lambda code ZIP file
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "my_lambda_role" {
  name = "my-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the Lambda role (e.g., permissions to log to CloudWatch)
resource "aws_iam_policy_attachment" "my_lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::905418071784:policy/cloudwatch-logs-policy"  # Replace with your desired policy ARN
  roles      = [aws_iam_role.my_lambda_role.name]
}

# Create a CloudWatch Events rule to trigger the Lambda function on every `terraform apply`
resource "aws_cloudwatch_event_rule" "my_lambda_trigger" {
  name        = "my-lambda-trigger"
  description = "Trigger Lambda on Terraform apply"
  event_pattern = jsonencode({
    source      = ["aws.terraform"],
    detail_type = ["Terraform Apply"]
  })
}

# Create a CloudWatch Events target to invoke the Lambda function
resource "aws_cloudwatch_event_target" "my_lambda_target" {
  rule      = aws_cloudwatch_event_rule.my_lambda_trigger.name
  arn       = aws_lambda_function.my_lambda_function.arn
  target_id = "my-lambda-target"
}
