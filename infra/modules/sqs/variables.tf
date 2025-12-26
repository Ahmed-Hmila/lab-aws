variable "queue_name" {
  description = "Nom de la file SQS"
  type        = string
}

variable "api_gateway_arn" {
  description = "ARN de l'API Gateway pour la politique de la file"
  type        = string
}

variable "tags" {
  description = "Tags à appliquer à la file"
  type        = map(string)
  default     = {}
}
variable "apigw_sqs_role_arn" {
  description = "ARN du rôle IAM pour permettre à API Gateway d'envoyer des messages à SQS"
  type        = string
}