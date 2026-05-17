output "kms_key_arn" {
  description = "O ARN da chave KMS criada para criptografar os dados sensíveis (RG/CPF)"
  value       = aws_kms_key.cdr_kms_key.arn
}

output "kms_key_alias" {
  description = "O alias da chave KMS para facilitar o uso em outras pipelines ou Lambdas"
  value       = aws_kms_alias.cdr_kms_alias.name
}

output "bucket_docs_alunos_name" {
  description = "O nome do bucket de documentos operacionais"
  value       = aws_s3_bucket.docs_alunos.id
}

output "bucket_docs_alunos_arn" {
  description = "O ARN do bucket de documentos operacionais (Útil para políticas de IAM)"
  value       = aws_s3_bucket.docs_alunos.arn
}

output "bucket_data_lake_sor_name" {
  description = "O nome do bucket do Data Lake (Camada SOR)"
  value       = aws_s3_bucket.data_lake_sor.id
}

output "glue_database_name" {
  description = "O nome do banco de dados no Glue Catalog"
  value       = aws_glue_catalog_database.db_sor.name
}

output "glue_table_alunos_cadastro_name" {
  description = "O nome da tabela analítica de cadastro de alunos no Glue"
  value       = aws_glue_catalog_table.alunos_cadastro_table.name
}