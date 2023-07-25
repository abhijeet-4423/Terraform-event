resource "aws_cloudwatch_event_rule" "rds_event_rule" {
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
}
