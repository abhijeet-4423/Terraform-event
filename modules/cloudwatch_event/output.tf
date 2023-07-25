output "cloudwatch_event_arn" {
	value = aws_cloudwatch_event_rule.rds_event_rule.arn
}

