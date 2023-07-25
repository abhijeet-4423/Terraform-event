variable "region" {
    default = "ap-south-1"
}
variable "access_key" {
    default = "AKIAVUQVU3KUJ3ZKTKFO"
}
variable "secret_key" {
    default = "fMjs4i6+vH4vG6C6kqP9//duAOQaPBHjlN5Noj6E"
}

variable "aws_lambda_function_name" {
    default = "ExampleLambdaFunction"
}
variable "aws_iam_role_policy_arn" {
    default = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
variable "lambda_function_sourceFile_name" {
    default = "lambda_function.py"
}
