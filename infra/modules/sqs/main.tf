resource "aws_sqs_queue" "queue" {
  name                      = var.queue_name
  delay_seconds             = var.sqs_delay_seconds
  max_message_size          = var.sqs_max_message_size
  message_retention_seconds = var.sqs_message_retention_seconds
  receive_wait_time_seconds = var.sqs_receive_wait_time_seconds
  visibility_timeout_seconds = var.sqs_visibility_timeout_seconds

  tags = var.tags
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.apigw_sqs_role_arn
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.queue.arn
      }
    ]
  })
}
