variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "create_db_subnet" {
  type    = bool
  default = false
}

variable "default_tags" {
  type = map(string)
}
