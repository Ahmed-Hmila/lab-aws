
output "api_url" {
  value       = module.api_gateway.api_endpoint
  description = "URL principale de ton API FastAPI"
}

output "fastapi_docs" {
  value       = "${module.api_gateway.api_endpoint}/docs"
  description = "Swagger UI"
}

output "fastapi_openapi" {
  value       = "${module.api_gateway.api_endpoint}/openapi.json"
  description = "OpenAPI JSON"
}