object DmCliente: TDmCliente
  OldCreateOrder = False
  Height = 409
  Width = 818
  object sqlPesquisar: TSQLDataSet
    CommandText = 
      'select id, nome, telefone, empresa_visitante from cliente where ' +
      '(nome like :nome)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'nome'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 24
    Top = 16
    object sqlPesquisarid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object sqlPesquisarnome: TStringField
      FieldName = 'nome'
      Size = 80
    end
    object sqlPesquisartelefone: TStringField
      FieldName = 'telefone'
      Size = 10
    end
    object sqlPesquisarempresa_visitante: TStringField
      FieldName = 'empresa_visitante'
      Size = 240
    end
  end
  object sqlInserir: TSQLDataSet
    CommandText = 
      'insert into cliente (id, nome, tipo, documento, telefone, empres' +
      'a_visitante) values (:id, :nome, :tipo, :documento, :telefone, :' +
      'empresa_visitante)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'nome'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'tipo'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'documento'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'telefone'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'empresa_visitante'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 104
    Top = 16
  end
  object sqlAlterar: TSQLDataSet
    CommandText = 
      'update cliente set nome = :nome,'#13#10'tipo = :tipo,'#13#10'documento = :do' +
      'cumento,'#13#10'telefone = :telefone,'#13#10'empresa_visitante = :empresa_vi' +
      'sitante'#13#10'where (id = :id)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'nome'
        ParamType = ptInput
      end
      item
        DataType = ftFixedChar
        Name = 'tipo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'documento'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'telefone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'empresa_visitante'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 184
    Top = 16
  end
  object sqlExcluir: TSQLDataSet
    CommandText = 'delete from cliente where (id = :id)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 256
    Top = 16
  end
  object dspPesquisar: TDataSetProvider
    DataSet = sqlPesquisar
    Constraints = False
    Left = 24
    Top = 96
  end
  object cdsPesquisar: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'nome'
        ParamType = ptInput
      end>
    ProviderName = 'dspPesquisar'
    Left = 24
    Top = 160
    object cdsPesquisarid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object cdsPesquisarnome: TStringField
      FieldName = 'nome'
      Size = 80
    end
    object cdsPesquisartelefone: TStringField
      FieldName = 'telefone'
      Size = 10
    end
    object cdsPesquisarempresa_visitante: TStringField
      FieldName = 'empresa_visitante'
      Size = 240
    end
  end
  object dspVisitas: TDataSetProvider
    DataSet = sqlVisitas
    Constraints = False
    Left = 384
    Top = 96
  end
  object cdsVisitas: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_visitante'
        ParamType = ptInput
      end>
    ProviderName = 'dspVisitas'
    Left = 384
    Top = 168
    object cdsVisitasid_visita: TIntegerField
      FieldName = 'id_visita'
      Required = True
    end
    object cdsVisitasobjetivo_visita: TStringField
      FieldName = 'objetivo_visita'
      Required = True
      Size = 240
    end
    object cdsVisitashora_entrada: TStringField
      FieldName = 'hora_entrada'
      Required = True
      Size = 5
    end
    object cdsVisitashora_saida: TStringField
      FieldName = 'hora_saida'
      Required = True
      Size = 5
    end
    object cdsVisitassetor_visita: TStringField
      FieldName = 'setor_visita'
      Required = True
      Size = 240
    end
    object cdsVisitasfk_visitante: TIntegerField
      FieldName = 'fk_visitante'
      Required = True
    end
  end
  object sqlVisitas: TSQLDataSet
    CommandText = 'select * from visita where (fk_visitante like :fk_visitante)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_visitante'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 384
    Top = 24
  end
  object sqlExcluirVisita: TSQLDataSet
    CommandText = 
      'delete from visita where (fk_visitante = :fk_visitante) and (id_' +
      'visita = :id_visita)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_visitante'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'id_visita'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 456
    Top = 24
  end
  object sqlUltimaVisita: TSQLDataSet
    CommandText = 
      'select hora_saida from visita where (fk_visitante = :fk_visitant' +
      'e) order by id_visita desc limit 1'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_visitante'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 536
    Top = 24
  end
  object sqlInserirVisita: TSQLDataSet
    CommandText = 
      'insert into visita (id_visita, objetivo_visita, hora_entrada, ho' +
      'ra_saida, setor_visita, fk_visitante) values (:id, :objetivo, :e' +
      'ntrada, :saida, :setor, :fk)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'objetivo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'entrada'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'saida'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'setor'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 616
    Top = 24
  end
  object sqlFinalizarVisita: TSQLDataSet
    CommandText = 
      'update visita set (hora_saida like :saida) where (fk_visitante l' +
      'ike :fk) and (id_visita like :id)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'saida'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 616
    Top = 88
  end
  object sqlFiltros: TSQLDataSet
    CommandText = 
      'select * from (database like :database) where (fk_visitante like' +
      ' :fk_visitante)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'database'
        ParamType = ptInput
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'fk_visitante'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = DmConexao.sqlConexao
    Left = 728
    Top = 24
  end
  object dspFiltros: TDataSetProvider
    DataSet = sqlFiltros
    Left = 728
    Top = 88
  end
  object cdsFiltros: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFiltros'
    Left = 728
    Top = 152
  end
end
