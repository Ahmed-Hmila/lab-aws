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

  image_uri = "380426548948.dkr.ecr.eu-west-3.amazonaws.com/myproject-repo:latest"
}

# Récupération des informations du compte courant
data "aws_caller_identity" "current" {}

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
# Module SQS
##########################
module "sqs" {
  source = "../../modules/sqs"

  queue_name      = "${var.project_name}-${var.env}-queue"
  api_gateway_arn = module.api_gateway.api_arn
  apigw_sqs_role_arn = aws_iam_role.apigw_sqs_role.arn
  tags            = local.default_tags
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
  sqs_queue_arn        = module.sqs.queue_arn
}

##########################
# Rôle IAM pour API Gateway -> SQS
##########################
resource "aws_iam_role" "apigw_sqs_role" {
  name = "${var.project_name}-apigw-sqs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

##########################
# Module API Gateway
##########################
module "api_gateway" {
  source = "../../modules/api-gateway"

  api_name          = "${var.project_name}-${var.env}-api"
  sqs_queue_arn     = module.sqs.queue_arn
  sqs_queue_name    = module.sqs.queue_name
  lambda_arn        = module.lambda.lambda_arn
  region            = var.aws_region
  account_id        = data.aws_caller_identity.current.account_id
  tags              = local.default_tags

  apigw_sqs_role_arn = aws_iam_role.apigw_sqs_role.arn
}
