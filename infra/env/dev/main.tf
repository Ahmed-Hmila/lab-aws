module "lambda" {
  source = "../../module/lambda"

  function_name = "${var.project_name}-${var.env}-lambda"
  image_uri     = var.image_uri
  tags          = local.default_tags
}

module "api_gateway" {
  source = "../../module/api-gateway"

  api_name               = "${var.project_name}-${var.env}-api"
  lambda_arn             = module.lambda.lambda_arn
  lambda_function_name   = module.lambda.lambda_function_name
  tags                   = local.default_tags
}
