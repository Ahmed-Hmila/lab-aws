terraform {
  backend "s3" {
    bucket         = "myproject-dev-tfstate-v1"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-3"   
    encrypt        = true
  }
}