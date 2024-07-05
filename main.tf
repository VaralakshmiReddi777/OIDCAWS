resource "aws_iam_role_policy_attachment" "shopFloorAlert_lambda_role_attach" {
  role       = aws_iam_role.shopFloorAlert_lambda_role.name
  policy_arn = aws_iam_policy.shopFloorAlert_lambda_policy.arn
}
