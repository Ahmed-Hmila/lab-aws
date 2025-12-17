terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

# Variables
variable "project_name" {
  default = "myproject"
}

variable "team" {
  default = "data-eng"
}

variable "env" {
  default = "dev"
}

variable "company_name" {
  default = "mycompany"
}

variable "image_uri" {
  type        = string
  description = "URI de l'image Docker ECR pour la Lambda"
  default     = "380426548948.dkr.ecr.eu-west-3.amazonaws.com/fastapi-lambda-app:latest"
}

locals {
  default_tags = {
    project             = var.project_name
    team                = var.team
    "${var.company_name}:env" = var.env
  }
}

# Module Lambda
module "lambda" {
  source        = "../../module/lambda"
  function_name = "myproject-dev-lambda"
  image_uri     = var.image_uri   # ← Dynamique maintenant
  tags          = local.default_tags
}
# Module API Gateway
module "api_gateway" {
  source = "../../module/api-gateway"
  api_name = "myproject-dev-api"
  tags = local.default_tags
  # Intègre avec Lambda si nécessaire
  lambda_arn = module.lambda.lambda_arn
}



 

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