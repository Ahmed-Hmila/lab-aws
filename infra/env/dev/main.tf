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

locals {
  default_tags = {
    project             = var.project_name
    team                = var.team
    "${var.company_name}:env" = var.env
  }
}

# Module Lambda
module "lambda" {
  source = "../../../module/lambda"
  function_name = "myproject-dev-lambda"
  tags = local.default_tags
  # Ajoute d'autres params comme handler, runtime, etc.
}

# Module API Gateway
module "api_gateway" {
  source = "../../../module/api-gateway"
  api_name = "myproject-dev-api"
  tags = local.default_tags
  # Intègre avec Lambda si nécessaire
  lambda_arn = module.lambda.lambda_arn
}