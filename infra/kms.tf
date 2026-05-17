resource "aws_kms_key" "cdr_kms_key" {
  description             = "Chave para criptografia de documentos sensíveis dos alunos"
  
  # REDE DE SEGURANÇA: Se a chave for deletada via pipeline, a AWS não a apaga imediatamente.
  # Ela entra em estado pendente por 7 dias, permitindo cancelar a exclusão e evitar a perda permanente dos dados.
  deletion_window_in_days = 7

  # COMPLIANCE E SEGURANÇA: Rotaciona o "segredo" matemático da chave automaticamente a cada 1 ano.
  # Esse processo é invisível para a aplicação e não quebra a leitura dos arquivos antigos.
  enable_key_rotation     = true

  tags = {
    Project   = "CidadeDeRefugio"
    ManagedBy = "Terraform"
  }
}


resource "aws_kms_alias" "cdr_kms_alias" {
  name          = "alias/cdr-documentos-key"
  target_key_id = aws_kms_key.cdr_kms_key.key_id
}