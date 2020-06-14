object FrmCadastrarCliente: TFrmCadastrarCliente
  Left = 0
  Top = 0
  Caption = 'Controle de Visitas'
  ClientHeight = 382
  ClientWidth = 679
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRodape: TPanel
    Left = 0
    Top = 339
    Width = 679
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lbTimer: TLabel
      Left = 12
      Top = 12
      Width = 24
      Height = 13
      Caption = 'timer'
    end
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
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 679
    Height = 339
    ActivePage = tbPesq
    Align = alClient
    TabOrder = 0
    object tbPesq: TTabSheet
      Caption = 'tbPesq'
      object pnlFiltro: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 665
        Height = 46
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object edtPesquisar: TLabeledEdit
          Left = 16
          Top = 20
          Width = 241
          Height = 21
          EditLabel.Width = 124
          EditLabel.Height = 13
          EditLabel.Caption = 'Digite aqui para pesquisar'
          TabOrder = 0
        end
        object btnPesquisar: TButton
          Left = 267
          Top = 16
          Width = 75
          Height = 29
          Align = alCustom
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = btnPesquisarClick
        end
        object btRelatorio: TButton
          AlignWithMargins = True
          Left = 594
          Top = 3
          Width = 68
          Height = 40
          Align = alRight
          Caption = 'Filtros'
          TabOrder = 2
          OnClick = btRelatorioClick
        end
      end
      object pnlBtnsPesq: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 279
        Width = 665
        Height = 29
        Align = alBottom
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        object btnNovo: TButton
          AlignWithMargins = True
          Left = 425
          Top = 3
          Width = 75
          Height = 23
          Align = alRight
          Caption = 'Novo'
          TabOrder = 0
          OnClick = btnNovoClick
        end
        object btnDetalhar: TButton
          AlignWithMargins = True
          Left = 506
          Top = 3
          Width = 75
          Height = 23
          Align = alRight
          Caption = 'Detalhar'
          TabOrder = 1
          OnClick = btnDetalharClick
        end
        object btnExcluir: TButton
          AlignWithMargins = True
          Left = 587
          Top = 3
          Width = 75
          Height = 23
          Align = alRight
          Caption = 'Excluir'
          TabOrder = 2
          OnClick = btnExcluirClick
        end
        object btAbrirVisita: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 75
          Height = 23
          Align = alLeft
          Caption = 'Abrir Visita'
          TabOrder = 3
          OnClick = btAbrirVisitaClick
        end
        object btFinalizarVisita: TButton
          AlignWithMargins = True
          Left = 84
          Top = 3
          Width = 75
          Height = 23
          Align = alLeft
          Caption = 'Finalizar Visita'
          TabOrder = 4
          OnClick = btFinalizarVisitaClick
        end
      end
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 55
        Width = 665
        Height = 218
        Align = alClient
        DataSource = dsPesq
        DrawingStyle = gdsGradient
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = btnDetalharClick
        Columns = <
          item
            Alignment = taLeftJustify
            Expanded = False
            FieldName = 'id'
            Title.Caption = 'Identifica'#231#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'empresa_visitante'
            Title.Caption = 'Empresa'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Title.Caption = 'Telefone'
            Width = 110
            Visible = True
          end>
      end
    end
    object tbDados: TTabSheet
      AlignWithMargins = True
      Caption = 'tbDados'
      ImageIndex = 1
      object lblTipo: TLabel
        Left = 3
        Top = 85
        Width = 52
        Height = 13
        Caption = 'Tipo (PF/J)'
      end
      object edtCodigo: TLabeledEdit
        Left = 3
        Top = 16
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Codigo'
        Enabled = False
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Left = 3
        Top = 56
        Width = 318
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        TabOrder = 1
      end
      object cbxTipo: TComboBox
        Left = 3
        Top = 104
        Width = 145
        Height = 21
        ItemIndex = 0
        TabOrder = 2
        Text = 'Fisico'
        Items.Strings = (
          'Fisico'
          'Juridico')
      end
      object edtDocumento: TLabeledEdit
        Left = 176
        Top = 104
        Width = 145
        Height = 21
        EditLabel.Width = 113
        EditLabel.Height = 13
        EditLabel.Caption = 'Documento (CPF/CNPJ)'
        MaxLength = 15
        TabOrder = 3
      end
      object edtTelefone: TLabeledEdit
        Left = 347
        Top = 104
        Width = 134
        Height = 21
        EditLabel.Width = 42
        EditLabel.Height = 13
        EditLabel.Caption = 'Telefone'
        MaxLength = 10
        TabOrder = 4
      end
      object pnlBtnsCad: TPanel
        Left = 0
        Top = 274
        Width = 665
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 6
        object btnListar: TButton
          AlignWithMargins = True
          Left = 344
          Top = 3
          Width = 75
          Height = 25
          Align = alRight
          Caption = 'Listar'
          TabOrder = 3
          OnClick = btnListarClick
        end
        object btnAlterar: TButton
          AlignWithMargins = True
          Left = 425
          Top = 3
          Width = 75
          Height = 25
          Align = alRight
          Caption = 'Alterar'
          TabOrder = 0
          OnClick = btnAlterarClick
        end
        object btnGravar: TButton
          AlignWithMargins = True
          Left = 506
          Top = 3
          Width = 75
          Height = 25
          Align = alRight
          Caption = 'Gravar'
          TabOrder = 1
          OnClick = btnGravarClick
        end
        object btnCancelar: TButton
          AlignWithMargins = True
          Left = 587
          Top = 3
          Width = 75
          Height = 25
          Align = alRight
          Caption = 'Cancelar'
          TabOrder = 2
          OnClick = btnCancelarClick
        end
        object btnVisitas: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 75
          Height = 25
          Align = alLeft
          Caption = 'Visitas'
          TabOrder = 4
          OnClick = btnVisitasClick
        end
      end
      object Empresa: TLabeledEdit
        Left = 3
        Top = 152
        Width = 174
        Height = 21
        EditLabel.Width = 41
        EditLabel.Height = 13
        EditLabel.Caption = 'Empresa'
        TabOrder = 5
      end
    end
  end
  object dsPesq: TDataSource
    DataSet = DmCliente.cdsPesquisar
    Left = 480
    Top = 168
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 48
    Top = 344
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = DmCliente.cdsPesquisar
    BCDToCurrency = False
    Left = 184
    Top = 200
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
    ReportOptions.CreateDate = 43974.704767210650000000
    ReportOptions.LastChange = 43974.704767210650000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 264
    Top = 200
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
