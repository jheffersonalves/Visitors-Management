object frmDadosVisita: TfrmDadosVisita
  Left = 0
  Top = 0
  Caption = 'Dados da Nova Visita'
  ClientHeight = 276
  ClientWidth = 485
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
  object pnPrincipal: TPanel
    Left = 0
    Top = 240
    Width = 485
    Height = 36
    Align = alBottom
    TabOrder = 2
    object Cancelar: TButton
      AlignWithMargins = True
      Left = 406
      Top = 4
      Width = 75
      Height = 28
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = CancelarClick
    end
    object btSalvar: TButton
      AlignWithMargins = True
      Left = 325
      Top = 4
      Width = 75
      Height = 28
      Align = alRight
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btSalvarClick
    end
  end
  object Objetivo: TLabeledEdit
    Left = 128
    Top = 87
    Width = 193
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Objetivo'
    TabOrder = 0
  end
  object Setor: TLabeledEdit
    Left = 128
    Top = 152
    Width = 193
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'Setor'
    TabOrder = 1
    OnEnter = SetorEnter
  end
  object horarioentrada: TLabeledEdit
    Left = 356
    Top = 28
    Width = 121
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = 'Horario de Entrada'
    Enabled = False
    TabOrder = 3
  end
  object Visitante: TLabeledEdit
    Left = 8
    Top = 28
    Width = 177
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Visitante'
    Enabled = False
    TabOrder = 4
  end
end
