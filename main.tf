
resource "aws_dynamodb_table" "shop_floor_alerts" {
  name             = "shop_floor_alerts"
  billing_mode     = "PROVISIONED"
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
  read_capacity    = 5
  write_capacity   = 5
  hash_key         = "PK"
  range_key        = "SK"

  attribute {
    name = "PK"
    type = "S"
  }
  attribute {
    name = "SK"
    type = "S"
  }
}
