object frmVisitas: TfrmVisitas
  Left = 0
  Top = 0
  Caption = 'Visitas'
  ClientHeight = 358
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 649
    Height = 317
    Align = alClient
    DataSource = dsVisitas
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'hora_entrada'
        Title.Caption = 'Entrada'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hora_saida'
        Title.Caption = 'Saida'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'setor_visita'
        Title.Caption = 'Setor'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'objetivo_visita'
        Title.Caption = 'Objetivo'
        Width = 600
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_visita'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'fk_visitante'
        Visible = False
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 317
    Width = 649
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      AlignWithMargins = True
      Left = 489
      Top = 4
      Width = 75
      Height = 33
      Align = alRight
      Caption = 'Excluir'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 570
      Top = 4
      Width = 75
      Height = 33
      Align = alRight
      Caption = 'Sair'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object dsVisitas: TDataSource
    DataSet = DmCliente.cdsVisitas
    Left = 360
    Top = 144
  end
end
