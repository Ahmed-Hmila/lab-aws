variable "api_name" {
  description = "Nom de l'API Gateway HTTP"
  type        = string
}

variable "lambda_arn" {
  description = "ARN complet de la fonction Lambda"
  type        = string
}

variable "lambda_function_name" {
  description = "Nom de la fonction Lambda (sans ARN)"
  type        = string
}

variable "tags" {
  description = "Tags communs aux ressources"
  type        = map(string)
  default     = {}
}
