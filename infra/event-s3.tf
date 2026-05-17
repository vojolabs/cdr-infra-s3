# Bucket de Documentos Operacionais
resource "aws_s3_bucket" "docs_alunos" {
  bucket = "cdr-documentos-alunos"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "docs_encryption" {
  bucket = aws_s3_bucket.docs_alunos.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.cdr_kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Configuração da Notificação (Filtro para a pasta imagens/)
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.docs_alunos.id

  queue {
    # Aponta para o ARN da fila externa
    queue_arn     = data.aws_sqs_queue.fila_externa.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "cdr_alunos/"
    # filter_prefix = "cdr_alunos/id_aluno/imagens/" 
  }
    # Garante que a permissão da fila seja aplicada ANTES do S3 tentar se conectar a ela
    depends_on = [aws_sqs_queue_policy.sqs_policy]
} 

# Bucket do Data Lake (SOR - System of Record)
resource "aws_s3_bucket" "data_lake_sor" {
  bucket = "cdr-data-lake-sor"
}