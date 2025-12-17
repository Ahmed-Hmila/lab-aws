variable "function_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn  # Crée un rôle basique
  handler       = "index.handler"  # Ajuste
  runtime       = "nodejs20.x"     # Ajuste
  filename      = "lambda.zip"     # Ou image_uri si ECR

  tags = var.tags
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}