##########################
# Locals
##########################
locals {
  default_tags = {
    project                 = var.project_name
    team                    = var.team
    environment             = var.env
    "${var.company_name}:env" = var.env
  }

  
 image_uri = "380426548948.dkr.ecr.eu-west-3.amazonaws.com/myproject-repo:lambda-20251218090602-fastapi-data-eng-dev"
}


##########################
# Module VPC
##########################
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.env

  cidr = "10.0.0.0/16"
  azs  = ["eu-west-3a", "eu-west-3b"]

  create_db_subnet = false

  default_tags = local.default_tags
}

##########################
# Module Lambda
##########################
module "lambda" {
  source = "../../modules/lambda"

  function_name = "${var.project_name}-${var.env}-lambda"
  image_uri     = var.image_uri 
  tags          = local.default_tags
}

##########################
# Module API Gateway
##########################
module "api_gateway" {
  source = "../../modules/api-gateway"

  api_name               = "${var.project_name}-${var.env}-api"
  lambda_arn             = module.lambda.lambda_arn
  lambda_function_name   = module.lambda.lambda_function_name
  tags                   = local.default_tags
}