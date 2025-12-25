output "api_endpoint" {
  description = "URL publique de l'API Gateway"
  value       = aws_api_gateway_stage.stage.invoke_url
}

output "api_arn" {
  description = "ARN d'exécution de l'API Gateway"
  value       = aws_api_gateway_rest_api.api.execution_arn
}

output "api_gateway_url" {
  description = "URL de base de l'API Gateway sans le protocole"
  value       = replace(aws_api_gateway_stage.stage.invoke_url, "https://", "")
}