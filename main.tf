provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}
/*resource "aws_cloudwatch_event_rule" "rds_event_rule" {
    name = var.aws_cloudwatch_event_rule_name 
    description = "CloudWatch Event Rule for RDS DB instance start or restart" 
    event_pattern = jsonencode({
        "source" : ["aws.rds"],  
        "detail-type" : ["RDS DB Instance Event"], 
        "detail": {
            "EventCategories": [
                "availability",
                "notification"
            ],
            "EventID": [
                "0006",
                "0088"
            ],
            "SourceIdentifier": [
                "test-db"
            ]
        }
    })
}*/
module "cloudwatch_event" {
  source = "./modules/cloudwatch_event"
}
resource "aws_lambda_function" "example_lambda_function" {
  filename = data.archive_file.lambda_function.output_path
  function_name = var.aws_lambda_function_name
  role = module.aws_lambda_role.iam_role_arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.8"
}
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example_lambda_function.function_name
  principal = "events.amazonaws.com"
  source_arn = module.cloudwatch_event.cloudwatch_event_arn
}
/*resource "aws_iam_role" "lambda_role" {
    name = "lambda-execution-role"
    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }]
    })
}*/
module "aws_lambda_role" {
  source = "./modules/iam_role"
}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy_attachment" {
  policy_arn = var.aws_iam_role_policy_arn
  role = module.aws_lambda_role.iam_role_name
}
data "archive_file" "lambda_function" {
  type = "zip"
  source_file = var.lambda_function_sourceFile_name
  output_path = "lambda_function.zip"
}

