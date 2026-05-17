# Busca os dados da fila SQS
data "aws_sqs_queue" "fila_externa" {
  name = "sqs_mensagem_bucket"
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  # Aponta para a URL da fila encontrada pelo Data Source
  queue_url = data.aws_sqs_queue.fila_externa.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "sqs:SendMessage"
        # Aponta para o ARN da fila encontrada pelo Data Source
        Resource  = data.aws_sqs_queue.fila_externa.arn
      }
    ]
  })
}