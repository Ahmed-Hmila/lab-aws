output "api_endpoint" {
  description = "URL publique de l'API Gateway"
  value       = aws_api_gateway_stage.stage.invoke_url
}

output "api_arn" {
  description = "ARN d'exécution de l'API Gateway"
  value       = aws_api_gateway_rest_api.api.execution_arn
}


output "apigw_sqs_role_arn" {
  description = "ARN du rôle IAM pour API Gateway → SQS"
  value       = aws_iam_role.apigw_sqs_role.arn
}