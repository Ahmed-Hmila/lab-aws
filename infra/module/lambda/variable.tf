variable "function_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "image_uri" {
  type        = string
  description = "URI de l'image ECR pour la Lambda container"
  default     = ""   
}
