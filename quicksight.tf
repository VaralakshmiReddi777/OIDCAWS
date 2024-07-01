resource "aws_quicksight_user" "example" {
  session_name  = "an-author"
  email         = "author@example.com"
  namespace     = "foo"
  identity_type = "IAM"
  iam_arn       = "arn:aws:iam::123456789012:user/Example"
  user_role     = "AUTHOR"
}
