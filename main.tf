resource "aws_ses_email_identity" "source_alert_email" {
  email = "varubasie@gmail.com"
}

resource "aws_ses_email_identity" "delivery_alert_email" {
  email = "reddilohith7@gmail.com"
}
