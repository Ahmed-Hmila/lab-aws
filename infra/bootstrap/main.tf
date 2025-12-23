# Module ECR
module "ecr" {
  source          = "../module/ecr"
  repository_name = "myproject-repo"
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
          Federated = data.aws_iam_openid_connect_provider.github.arn
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

# Policy S3 pour Terraform State
resource "aws_iam_policy" "github_s3_terraform" {
  name        = "GitHubTerraformS3Access"
  description = "Permissions S3 pour GitHub Actions et Terraform"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::myproject-dev-tfstate-v1",
          "arn:aws:s3:::myproject-dev-tfstate-v1/*"
        ]
      }
    ]
  })
}

# Attachement de la policy S3 au rôle
resource "aws_iam_role_policy_attachment" "github_s3" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_s3_terraform.arn
}


# Attache des policies au rôle (ajuster pour le moindre privilège)
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
