variable "github_repo" {
  description = "GitHub repo au format owner/repo"
  type        = string
  default     = "yourusername/myproject"  
}

variable "account_id" {
  description = "ID du compte AWS"
  type        = string
}