const aws = require('aws-sdk')

const oParams = {
    Destination: { /* required */
        ToAddresses: [
            "reddilohith7@gmail.com",
            /* more items */
        ]
    },
    Message: { /* required */
        Body: { /* required */
            Text: {
                Charset: "UTF-8",
                Data: ""
            }
        },
        Subject: {
            Charset: "UTF-8",
            Data: "KPI Alert"
        }
    },
    Source: "varubasi@gmail.com", /* required */
}

const ses = new aws.SES()

exports.handler = async (event) => {
    console.log(JSON.stringify(event))

    for (let item of event.Records) {

        if (item.eventName === 'REMOVE') return

        /**********************Parsing the params from event object*******************/
        const plant = item.dynamodb.NewImage.Plant['S']
        const line = item.dynamodb.NewImage.Line['S']
        const actualValue = parseInt(item.dynamodb.NewImage.KpiValue['N'])
        const thresholdValue = parseInt(item.dynamodb.NewImage.ThresholdValue['N'])
        const kpiName = item.dynamodb.NewImage.KpiName['S']
        /*****************************************************************************/

        if (actualValue > thresholdValue) {
            try {
                const msgBody = `${kpiName} has exceeded the threshold value ${thresholdValue} by ${actualValue - thresholdValue} units for plant ${plant} and line ${line}`

                oParams.Message.Body.Text['Data'] = msgBody
                await ses.sendEmail(oParams).promise()
            } catch (error) {
                return error.message
            }
        }
    }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/sendAlertEmail/index.js"
  output_path = "sendAlertEmail.zip"
}

resource "aws_lambda_function" "send_alert_email" {
  function_name = "SendAlertEmail"
  role          = aws_iam_role.shopFloorAlert_lambda_role.arn
  runtime       = "nodejs16.x"
  filename      = "sendAlertEmail.zip"
  handler       = "index.handler"
  timeout       = "15"

  source_code_hash = data.archive_file.lambda.output_base64sha256

}
