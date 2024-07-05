resource "aws_lambda_event_source_mapping" "trigger" {
  batch_size        = 100
  event_source_arn  = "arn:aws:dynamodb:us-east-2:905418071784:table/shop_floor_alerts"
  function_name     = "arn:aws:lambda:us-east-2:905418071784:function:SendAlertEmail"
  starting_position = "LATEST"
}
