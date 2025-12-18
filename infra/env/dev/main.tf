locals {
  default_tags = {
    project                 = var.project_name
    team                    = var.team
    environment             = var.env
    "${var.company_name}:env" = var.env
  }

  
  image_uri = "380426548948.dkr.ecr.eu-west-3.amazonaws.com/myproject-repo:lambda-20251218090602-fastapi-data-eng-dev"
}
 
module "lambda" {
  source = "../../module/lambda"

  function_name = "${var.project_name}-${var.env}-lambda"
  image_uri     = local.image_uri  # On utilise la valeur locale
  tags          = local.default_tags
}

module "api_gateway" {
  source = "../../module/api-gateway"

  api_name               = "${var.project_name}-${var.env}-api"
  lambda_arn             = module.lambda.lambda_arn
  lambda_function_name   = module.lambda.lambda_function_name
  tags                   = local.default_tags
}