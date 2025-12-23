# Récupération du OIDC existant pour GitHub
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# Certificat TLS de GitHub (optionnel, si tu en as besoin)
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}
