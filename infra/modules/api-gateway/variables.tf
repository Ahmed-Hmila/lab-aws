variable "api_name" {
  description = "Nom de l'API Gateway REST"
  type        = string
}

variable "tags" {
  description = "Tags communs aux ressources"
  type        = map(string)
  default     = {}
}

variable "sqs_queue_arn" {
  description = "ARN de la file SQS"
  type        = string
}

variable "sqs_queue_name" {
  description = "Nom de la file SQS"
  type        = string
}

variable "region" {
  description = "Région AWS"
  type        = string
}

variable "account_id" {
  description = "ID du compte AWS"
  type        = string
}

variable "lambda_arn" {
  description = "ARN de la Lambda pour le proxy direct"
  type        = string
}

variable "apigw_sqs_role_arn" {
  description = "ARN du rôle IAM pour permettre à API Gateway d'envoyer des messages à SQS"
  type        = string
}