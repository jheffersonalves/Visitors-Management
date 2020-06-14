program VisitorsManagement;

uses
  Vcl.Forms,
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {FrmPrincipal},
  uFrmCadastrarCliente in 'view\uFrmCadastrarCliente.pas' {FrmCadastrarCliente},
  uClienteModel in 'model\uClienteModel.pas',
  uClienteController in 'controller\uClienteController.pas',
  uDmConexao in 'dao\uDmConexao.pas' {DmConexao: TDataModule},
  uDmCliente in 'dao\uDmCliente.pas' {DmCliente: TDataModule},
  uFrmVisitas in 'view\uFrmVisitas.pas' {frmVisitas},
  uFrmNovaVisita in 'view\uFrmNovaVisita.pas' {frmDadosVisita},
  uFrmRelatorios in 'view\uFrmRelatorios.pas' {frmRelatorios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmCadastrarCliente, FrmCadastrarCliente);
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TfrmVisitas, frmVisitas);
  Application.Run;
end.
