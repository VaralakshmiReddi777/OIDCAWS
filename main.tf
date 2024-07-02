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
