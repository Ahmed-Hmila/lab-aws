output "api_endpoint" {
  description = "URL publique de l'API Gateway"
  value       = "${aws_api_gateway_deployment.deployment.invoke_url}${aws_api_gateway_stage.stage.stage_name}"
}

output "api_arn" {
  description = "ARN d'exécution de l'API Gateway"
  value       = aws_api_gateway_rest_api.api.execution_arn
}
