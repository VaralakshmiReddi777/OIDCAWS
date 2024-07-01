resource "aws_ssm_parameter" "fsystem01" {
  name      = "/systems/fsystem01/config"
  type      = "String"
  value     = "https://www.website2.com"
  overwrite = true
}

resource "aws_ssm_parameter" "fsystem02" {
  name            = "/systems/fsystem02/config"
  type            = "String"
  value           = "https://www.ESL2.com"
  overwrite = true
}
