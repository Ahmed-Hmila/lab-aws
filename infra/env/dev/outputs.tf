
output "api_url" {
  value       = module.api_gateway.api_endpoint
  description = "URL principale de ton API FastAPI (ajoute https:// devant)"
}

output "fastapi_docs" {
  value       = "${module.api_gateway.api_endpoint}/docs"
  description = "Swagger UI (ajoute https:// devant)"
}

output "fastapi_openapi" {
  value       = "${module.api_gateway.api_endpoint}/openapi.json"
  description = "OpenAPI JSON (ajoute https:// devant)"
}