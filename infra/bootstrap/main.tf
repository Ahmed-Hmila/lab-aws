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

 
variable "github_repo" {
  description = "GitHub repo au format owner/repo"
  type        = string
  default     = "yourusername/myproject"  
}

variable "account_id" {
  description = "ID du compte AWS"
  type        = string
}

# Module ECR (appelle le module ecr)
module "ecr" {
  source = "../module/ecr"
  repository_name = "myproject-repo"
}

# OIDC Provider pour GitHub
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

# IAM Role pour GitHub Actions
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_repo}:*"
          }
        }
      }
    ]
  })
}

# Attache des policies au rôle (ex: full access ECR, Lambda, API Gateway - ajuste pour least privilege)
resource "aws_iam_role_policy_attachment" "github_ecr" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "github_lambda" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_role_policy_attachment" "github_apigw" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
}

output "role_arn" {
  value = aws_iam_role.github_actions_role.arn
}