variable "aws_region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
}

variable "team" {
  description = "Équipe responsable"
  type        = string
}

variable "env" {
  description = "Environnement (dev, staging, prod)"
  type        = string
}

variable "company_name" {
  description = "Nom de la société"
  type        = string
}

 