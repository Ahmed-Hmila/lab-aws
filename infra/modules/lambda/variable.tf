variable "function_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "image_uri" {
  type        = string
  description = "URI de l'image ECR pour la Lambda container"
  default = "380426548948.dkr.ecr.eu-west-3.amazonaws.com/fastapi-lambda-app:v2" 
}
variable "timeout" {
  type    = number
  default = 60
}

variable "memory_size" {
  type    = number
  default = 1024
}