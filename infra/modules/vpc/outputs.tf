# Output pour Lambda
output "private_subnets" {
  value = module.vpc.private_subnets
}

output "lambda_sg_id" {
  value = aws_security_group.lambda_sg.id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
