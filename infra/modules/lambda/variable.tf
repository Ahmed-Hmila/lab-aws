variable "function_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "image_uri" {
  type        = string
  description = "URI de l'image ECR pour la Lambda container"
  default = "380426548948.dkr.ecr.eu-west-3.amazonaws.com/myproject-repo:latest" 
}
variable "timeout" {
  type    = number
  default = 60
}

variable "memory_size" {
  type    = number
  default = 1024
}

variable "private_subnet_ids" {
  type = list(string)
  description = "Subnets privés pour la Lambda"
}

variable "lambda_sg_id" {
  type = string
  description = "Groupe de sécurité pour la Lambda"
}
variable "sqs_queue_arn" {
  description = "ARN de la file SQS pour le déclencheur"
  type        = string
  default     = ""
}
