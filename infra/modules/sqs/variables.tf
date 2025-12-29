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
variable "sqs_delay_seconds" {
  description = "Délai avant que le message soit visible (en secondes)"
  type        = number
  default     = 0
}

variable "sqs_max_message_size" {
  description = "Taille maximale du message SQS en octets"
  type        = number
  default     = 262144
}

variable "sqs_message_retention_seconds" {
  description = "Durée de rétention des messages en secondes"
  type        = number
  default     = 345600
}

variable "sqs_receive_wait_time_seconds" {
  description = "Temps d'attente pour le long polling"
  type        = number
  default     = 0
}

variable "sqs_visibility_timeout_seconds" {
  description = "Durée pendant laquelle un message est invisible après lecture"
  type        = number
  default     = 30
}
