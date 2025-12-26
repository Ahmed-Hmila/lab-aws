locals {
  tags = var.default_tags
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = "${var.project_name}-${var.environment}-vpc"
  cidr = var.cidr

  azs = var.azs

  # Sous-réseaux publics (NAT / futurs services exposés)
  public_subnets = [
    cidrsubnet(var.cidr, 8, 0),
    cidrsubnet(var.cidr, 8, 1)
  ]

  # Sous-réseaux privés (Lambda)
  private_subnets = [
    cidrsubnet(var.cidr, 8, 10),
    cidrsubnet(var.cidr, 8, 11)
  ]

  # Sous-réseaux DB (optionnel)
  database_subnets = var.create_db_subnet ? [
    cidrsubnet(var.cidr, 8, 20),
    cidrsubnet(var.cidr, 8, 21)
  ] : []

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags

  public_subnet_tags  = merge(local.tags, { "network" = "public" })
  private_subnet_tags = merge(local.tags, { "network" = "private" })
  database_subnet_tags = merge(local.tags, { "network" = "database" })
}

# Groupe de sécurité Lambda (simple pour ton projet)
resource "aws_security_group" "lambda_sg" {
  name   = "${var.project_name}-${var.environment}-lambda-sg"
  vpc_id = module.vpc.vpc_id
  tags   = local.tags
}

