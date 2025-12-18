locals {
  default_tags = {
    project                 = var.project_name
    team                    = var.team
    environment             = var.env
    "${var.company_name}:env" = var.env
  }
}
 