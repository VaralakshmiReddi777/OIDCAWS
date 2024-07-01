resource "aws_quicksight_user" "example" {
  session_name  = "an-author"
  email         = "author@example.com"
  identity_type = "IAM"
  iam_arn       = "arn:aws:iam::905418071784:user/testuser"
  user_role     = "AUTHOR"
}

