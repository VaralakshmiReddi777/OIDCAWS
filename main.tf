data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/sendAlertEmail/index.js"
  output_path = "sendAlertEmail.zip"
}

resource "aws_lambda_function" "send_alert_email" {
  function_name = "SendAlertEmail"
  role          = "arn:aws:iam::905418071784:role/shopFloorAlert_lambda_role"
  runtime       = "nodejs16.x"
  filename      = "sendAlertEmail.zip"
  handler       = "index.handler"
  timeout       = "15"

  source_code_hash = data.archive_file.lambda.output_base64sha256

}
