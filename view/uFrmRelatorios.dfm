object frmRelatorios: TfrmRelatorios
  Left = 0
  Top = 0
  Caption = 'Visitas'
  ClientHeight = 382
  ClientWidth = 679
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 679
    Height = 57
    Align = alTop
    Color = clAppWorkSpace
    ParentBackground = False
    TabOrder = 0
    object lblTipo: TLabel
      Left = 280
      Top = 8
      Width = 24
      Height = 13
      Caption = 'Filtro'
    end
    object edtPesquisar: TLabeledEdit
      Left = 13
      Top = 27
      Width = 241
      Height = 21
      EditLabel.Width = 124
      EditLabel.Height = 13
      EditLabel.Caption = 'Digite aqui para pesquisar'
      TabOrder = 0
      OnKeyPress = edtPesquisarKeyPress
    end
    object cbFiltro: TComboBox
      Left = 280
      Top = 27
      Width = 121
      Height = 21
      ItemIndex = 0
      TabOrder = 1
      Text = 'Nome'
      Items.Strings = (
        'Nome'
        'Empresa'
        'Data visita'
        'Visitas em aberto'
        'Todas visitas')
    end
    object btnPesquisar: TButton
      AlignWithMargins = True
      Left = 600
      Top = 4
      Width = 75
      Height = 49
      Align = alRight
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = btnPesquisarClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 57
    Width = 679
    Height = 282
    Align = alClient
    DataSource = dsFiltros
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 339
    Width = 679
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnFechar: TButton
      AlignWithMargins = True
      Left = 601
      Top = 3
      Width = 75
      Height = 37
      Align = alRight
      Caption = 'Sair'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
  object dsFiltros: TDataSource
    AutoEdit = False
    DataSet = DmCliente.cdsFiltros
    Left = 520
    Top = 120
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSource = dsFiltros
    BCDToCurrency = False
    Left = 184
    Top = 168
  end
  object frxReport1: TfrxReport
    Version = '5.1.5'
    DataSet = frxDBDataset1
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43974.707585810180000000
    ReportOptions.LastChange = 43974.707585810180000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 304
    Top = 160
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
end
