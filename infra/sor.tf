resource "aws_glue_catalog_database" "db_sor" {
  name = "db_cidade_refugio"
}

resource "aws_glue_catalog_table" "alunos_cadastro_table" {
  name          = "alunos_cadastro_sor"
  database_name = aws_glue_catalog_database.db_sor.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"   = "parquet"
    "EXTERNAL"         = "TRUE"
    "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://cdr-data-lake-sor/alunos-cadastro/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
      parameters = {
        "serialization.format" = "1"
      }
    }

    columns {
      name    = "id_aluno"
      type    = "string"
      comment = "ID único de 5 dígitos da internação."
    }
    columns {
      name    = "cpf"
      type    = "string"
      comment = "CPF do aluno"
    }
    columns {
      name    = "nome_aluno"
      type    = "string"
      comment = "Nome completo do residente."
    }
    columns {
      name    = "rg"
      type    = "string"
      comment = "RG do residente."
    }
    columns {
      name    = "contagem_passagem"
      type    = "int"
      comment = "Número sequencial desta internação (1, 2, 3...)."
    }
    columns {
      name    = "data_nascimento"
      type    = "string"
      comment = "Data de nascimento (YYYY-MM-DD)."
    }
    columns {
      name    = "familiar_responsavel"
      type    = "string"
      comment = "Nome do familiar responsável."
    }
    columns {
      name    = "tel_responsavel"
      type    = "string"
      comment = "Telefone de contato do responsável."
    }
    columns {
      name    = "status_residente"
      type    = "string"
      comment = "Status atual: ATIVO, CONCLUIDO ou DESISTENTE."
    }
    columns {
      name    = "logradouro"
      type    = "string"
      comment = "Endereço da residência no ato do cadastro."
    }
    columns {
      name    = "bairro"
      type    = "string"
      comment = "Bairro do residente."
    }
    columns {
      name    = "cidade"
      type    = "string"
      comment = "Cidade de origem."
    }
    columns {
      name    = "estado"
      type    = "string"
      comment = "Estado (UF)."
    }
    columns {
      name    = "cep"
      type    = "string"
      comment = "CEP da residência."
    }
  }

  partition_keys {
    name = "ano"
    type = "string"
  }
  partition_keys {
    name = "mes"
    type = "string"
  }
  partition_keys {
    name = "dia"
    type = "string"
  }
}