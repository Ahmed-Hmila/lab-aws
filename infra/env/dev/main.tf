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

  
 image_uri = "380426548948.dkr.ecr.eu-west-3.amazonaws.com/fastapi-lambda-app:v2"
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
  image_uri     = local.image_uri    
  tags          = local.default_tags


  private_subnet_ids   = module.vpc.private_subnets
  lambda_sg_id         = module.vpc.lambda_sg_id
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