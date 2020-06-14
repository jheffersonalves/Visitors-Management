unit uFrmCadastrarCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uDmCliente, frxClass, frxDBSet;

type
  TOperacao = (opNovo, opAlterar, opNavegar);

  TFrmCadastrarCliente = class(TForm)
    pnlRodape: TPanel;
    btnFechar: TButton;
    pgcPrincipal: TPageControl;
    tbPesq: TTabSheet;
    tbDados: TTabSheet;
    pnlFiltro: TPanel;
    edtPesquisar: TLabeledEdit;
    btnPesquisar: TButton;
    pnlBtnsPesq: TPanel;
    btnNovo: TButton;
    btnDetalhar: TButton;
    btnExcluir: TButton;
    DBGrid1: TDBGrid;
    dsPesq: TDataSource;
    edtCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    cbxTipo: TComboBox;
    Empresa: TLabeledEdit;
    edtDocumento: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    lblTipo: TLabel;
    pnlBtnsCad: TPanel;
    btnListar: TButton;
    btnAlterar: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnVisitas: TButton;
    btAbrirVisita: TButton;
    btFinalizarVisita: TButton;
    lbTimer: TLabel;
    Timer1: TTimer;
    btRelatorio: TButton;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnDetalharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnVisitasClick(Sender: TObject);
    procedure btAbrirVisitaClick(Sender: TObject);
    procedure btFinalizarVisitaClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btRelatorioClick(Sender: TObject);
//    procedure dsPesqDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FOperacao: TOperacao;
    procedure Novo;
    procedure Detalhar;
    procedure Configuracoes;
    procedure Pesquisar;
    procedure CarregarCliente;
    procedure Listar;
    procedure Alterar;
    procedure Excluir;
    procedure Inserir;
    procedure Gravar;
    procedure AbrirVisitas;
    procedure NovaVisita;
    procedure FinalizarVisita;
    procedure HabilitarControles(aOperacao: TOperacao);
    function ValidarVisitaPendente: boolean;
  public
    { Public declarations }

  end;

var
  FrmCadastrarCliente: TFrmCadastrarCliente;

implementation

{$R *.dfm}

uses uClienteController, uClienteModel, uFrmVisitas, uFrmNovaVisita, uFrmRelatorios;

procedure TFrmCadastrarCliente.AbrirVisitas;
var
  oCLienteController: TClienteController;
  iCodigo: Integer;
begin
  FrmVisitas := TfrmVisitas.Create(nil);
  try
    oCLienteController := TClienteController.Create();
    iCodigo := StrToInt(edtCodigo.Text);
    oCLienteController.CarregarVisitas(iCodigo);

    if ( (DmCliente.cdsVisitas.Active) and (DmCliente.cdsVisitas.RecordCount > 0) ) then
    begin
      FrmVisitas.SetIdUser(iCodigo);
      FrmVisitas.ShowModal;
      if(FrmVisitas.IsReloadPage) then
        AbrirVisitas;
    end
    else
    begin
      //ShowMessage('Não há registro de visitas.');
      Application.MessageBox(PChar('Não há registro de visitas.'), 'Controle de Visitas', MB_ICONINFORMATION);
    end;
  finally
    freeandnil(FrmVisitas);
    freeandnil(oCLienteController);
  end;
end;

procedure TFrmCadastrarCliente.Alterar;
var
  oCliente: TCliente;
  oCLienteController: TClienteController;
  sErro: String;
begin
   oCliente := TCliente.Create;
   oCLienteController := TClienteController.Create;

   try
     //seta os dados que estao no formulario tbDados no objeto e envia para o DAO
     oCliente.ID := StrToIntDef(edtCodigo.Text, 0);
     oCliente.Nome := edtNome.Text;
     if cbxTipo.ItemIndex = 0 then
      oCliente.Tipo := 'F'
     else if cbxTipo.ItemIndex = 1 then
       oCliente.Tipo := 'J'
      else
        oCliente.Tipo := '';
     oCliente.Documento := edtDocumento.Text;
     oCliente.Telefone := edtTelefone.Text;
     oCliente.Empresa := Empresa.Text;

     if not oCLienteController.Alterar(oCliente, sErro) then
     begin
        raise Exception.Create('sErro');
     end
     else
     begin
       //ShowMessage('Cliente alterado com sucesso =)');
       Application.MessageBox(PChar('Cliente alterado com sucesso.'), 'Controle de Visitas', MB_ICONINFORMATION);
     end;


   finally
      freeandnil(oCliente);
      freeandnil(oCLienteController);
   end;

end;

procedure TFrmCadastrarCliente.btAbrirVisitaClick(Sender: TObject);
begin
   NovaVisita;
end;

procedure TFrmCadastrarCliente.btFinalizarVisitaClick(Sender: TObject);
begin

   if not ValidarVisitaPendente then
   begin
      //raise Exception.Create('Cliente nao possui visitas em aberto');
      Application.MessageBox(PChar('Cliente nao possui visitas em aberto.'), 'Controle de Visitas', MB_ICONWARNING);
  end
  else if MessageDlg('Deseja realmente finalizar a visita deste cliente?',mtConfirmation, [mbYes, mbNo], 0) = IDYES then
  begin
    FinalizarVisita;
  end;
end;

procedure TFrmCadastrarCliente.btnAlterarClick(Sender: TObject);
begin
  FOperacao := opAlterar;
  //Gravar;
  HabilitarControles(opAlterar);
end;

procedure TFrmCadastrarCliente.btnCancelarClick(Sender: TObject);
begin
   HabilitarControles(opNavegar);
end;

procedure TFrmCadastrarCliente.btnDetalharClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TFrmCadastrarCliente.btnExcluirClick(Sender: TObject);
begin
   Excluir;
end;

procedure TFrmCadastrarCliente.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadastrarCliente.btnGravarClick(Sender: TObject);
begin
   Gravar;
   HabilitarControles(opNavegar);
end;

procedure TFrmCadastrarCliente.btnListarClick(Sender: TObject);
begin
  Listar;
end;

procedure TFrmCadastrarCliente.btnNovoClick(Sender: TObject);
begin
  Novo;
  HabilitarControles(opNovo);
end;

procedure TFrmCadastrarCliente.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TFrmCadastrarCliente.btnVisitasClick(Sender: TObject);
begin
  AbrirVisitas;
end;

procedure TFrmCadastrarCliente.btRelatorioClick(Sender: TObject);
var
  FrmRelatorios: TfrmRelatorios;
begin
   try
     //frxReport1.ShowReport;
     //abre a tela de filtros para os relatorios
     FrmRelatorios := TfrmRelatorios.Create(nil);
     FrmRelatorios.ShowModal;//abre a janela e espera ela fechar
   finally
     freeandNil(FrmRelatorios);
   end;
end;

procedure TFrmCadastrarCliente.CarregarCliente;
var
  oCliente: TCliente;
  oClienteController: TClienteController;
begin
   oCliente := TCliente.Create;
   oClienteController := TClienteController.Create;

   try
     oClienteController.CarregarCliente(oCliente, dsPesq.DataSet.FieldByName('id').AsInteger);

     //preenche o dados do formulario (tbDados) com as informacoes do objeto cliente
     edtCodigo.Text := IntToStr(oCliente.ID);
     edtNome.Text := oCliente.Nome;
     if oCliente.Tipo = 'F' then
       cbxTipo.ItemIndex := 0
     else if oCliente.Tipo = 'J' then
       cbxTipo.ItemIndex := 1
     else
       cbxTipo.ItemIndex := -1;
     edtDocumento.Text := oCliente.Documento;
     edtTelefone.Text := oCliente.Telefone;
     Empresa.Text := oCliente.Empresa;
   finally
      freeandNil(oCliente);
      freeandNil(oClienteController);
   end;


end;

procedure TFrmCadastrarCliente.Configuracoes;
begin     //metodo chamado pelo formshow (quando abre a formulario)
  tbPesq.TabVisible := false; //fica invisivel a tab em cima
  tbDados.TabVisible := false;//fica invisivel a tab em cima
  pgcPrincipal.ActivePage := tbPesq;
  Pesquisar;
  dbGrid1.DataSource.DataSet.First;
  Timer1Timer(nil);
end;

procedure TFrmCadastrarCliente.Detalhar;
begin
  CarregarCliente;
  HabilitarControles(opNavegar);
  FOperacao := opNavegar;
  pgcPrincipal.ActivePage := tbDados;
end;

procedure TFrmCadastrarCliente.Excluir;
var
 oClienteController: TClienteController;
 sErro: String;
begin
   oClienteController := TClienteController.Create;
   
   try  //se o dataset Pesquisar ta ativo e tem registro
   if ( (DmCliente.cdsPesquisar.Active) and (DmCliente.cdsPesquisar.RecordCount > 0) ) then
   begin
     if MessageDlg('Deseja realmente excluir este cliente?',mtConfirmation, [mbYes, mbNo], 0) = IDYES then
     begin
        if not oClienteController.Excluir(DmCliente.cdsPesquisarid.AsInteger, sErro) then
          raise Exception.Create(sErro);

          //pesquisa de volta o ultimo registro que foi pesquisado
        oClienteController.Pesquisar(edtPesquisar.Text);
     end;
   end
   else
      raise  Exception.Create('Não há regsitro para ser excluido!');
   finally
      freeandnil(oclienteController);
   end;


end;

procedure TFrmCadastrarCliente.FinalizarVisita;
var
 oClienteController: TClienteController;
 sErro: String;
 sCodigo: Integer;
begin
   oClienteController := TClienteController.Create;
   sCodigo :=  dsPesq.DataSet.FieldByName('id').AsInteger;
   try
      if(oClienteController.FinalizarVisita(sCodigo, sErro)) then
      begin
        //ShowMessage('Visita finalizada com sucesso!');
          Application.MessageBox(PChar('Visita finalizada com sucesso'), 'Controle de Visitas', MB_ICONINFORMATION);
      end
      else
        raise Exception.Create(sErro);
   finally
     freeandNil(oClienteController);
   end;
end;

procedure TFrmCadastrarCliente.FormCreate(Sender: TObject);
begin
  DmCliente := TDmCliente.Create(nil);
end;

procedure TFrmCadastrarCliente.FormDestroy(Sender: TObject);
begin
  freeAndNil(DmCliente);
end;

procedure TFrmCadastrarCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then //se foi pressionado a tecla enter
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFrmCadastrarCliente.FormShow(Sender: TObject);
begin
  Configuracoes;
end;

procedure TFrmCadastrarCliente.Gravar;
var
 oClienteController: TClienteController;
begin
   oClienteController := TClienteController.Create;

   try
     case FOperacao of
       opNovo: Inserir;
       opAlterar: Alterar;
     end;

     oClienteController.Pesquisar(edtPesquisar.Text);
     
   finally
     freeandnil(oClienteController);
   end;
   
end;

procedure TFrmCadastrarCliente.HabilitarControles(aOperacao: TOperacao);
begin
  case aOperacao of
    opNovo:
    begin
      edtNome.Enabled := True;
      cbxTipo.Enabled := True;
      lblTipo.Enabled := True;
      edtDocumento.Enabled := True;
      edtTelefone.Enabled := True;
      Empresa.Enabled := True;
      btnGravar.Enabled := true;
      btnCancelar.Enabled := true;
      btnListar.Enabled := false;
      btnFechar.Enabled := false;
      btnAlterar.Enabled := false;
    end;
    opAlterar:
    begin
      edtNome.Enabled := True;
      cbxTipo.Enabled := True;
      lblTipo.Enabled := true;
      edtDocumento.Enabled := True;
      edtTelefone.Enabled := True;
      Empresa.Enabled := true;
      btnGravar.Enabled := true;
      btnCancelar.Enabled := true;
      btnListar.Enabled := false;
      btnFechar.Enabled := false;
      btnAlterar.Enabled := false;
      btnVisitas.Enabled := false;
    end;
    opNavegar:
    begin
      edtNome.Enabled := false;
      cbxTipo.Enabled := false;
      lblTipo.Enabled := false;
      edtDocumento.Enabled := false;
      edtTelefone.Enabled := false;
      Empresa.Enabled := false;
      btnGravar.Enabled := false;
      btnCancelar.Enabled := false;
      btnListar.Enabled := True;
      btnFechar.Enabled := True;
      btnAlterar.Enabled := True;
      btnVisitas.Enabled := true;
    end;
  end;

  if edtCodigo.Text = '' then
    btnVisitas.Enabled := false;

end;

procedure TFrmCadastrarCliente.Inserir;
var
  oCliente: Tcliente;
  oCLienteController: TClienteController;
  sErro: String;
begin
    oCliente := TCliente.Create;
    oCLienteController := TClienteController.Create;

    try

      //insere os dados do formulario no objeto
      oCliente.Nome := edtNome.Text;
      if cbxTipo.ItemIndex = 0 then
        oCliente.Tipo := 'F'
      else if cbxTipo.ItemIndex = 1 then
        oCliente.Tipo := 'J'
      else
        oCliente.Tipo := '';
      oCliente.Documento := edtDocumento.Text;
      oCliente.Telefone := edtTelefone.Text;
      oCliente.Empresa := Empresa.Text;

      if not oCLienteController.Inserir(oCliente, sErro) then
        raise Exception.Create(sErro)
      else
        Application.MessageBox(PChar('Novo visitante cadastrado com sucesso'), 'Controle de Visitas', MB_ICONINFORMATION);

      
    finally
       freeandnil(oCliente);
       freeandnil(oCLienteController);
    end;

end;

procedure TFrmCadastrarCliente.Listar;
begin //ativa a pagina de pesquisa
  pgcPrincipal.ActivePage := tbPesq;
end;

procedure TFrmCadastrarCliente.NovaVisita;
var
  oClienteController: TClienteController;
  sErro: String;
  FrmNovosDadosVisita: TfrmDadosVisita;
  sObjetivo, sSetor: String;
begin
   oClienteController := TClienteController.Create;

   try
      if not oClienteController.PendenteVisita(dsPesq.DataSet.FieldByName('id').AsInteger, sErro)then
      begin
        MessageDlg(sErro, mtError, [mbOK], 0);
      end
      else //pega os dados para inserir
      begin
        FrmNovosDadosVisita := TfrmDadosVisita.Create(nil);
        FrmNovosDadosVisita.Cliente := dsPesq.DataSet.FieldByName('nome').AsString;
        FrmNovosDadosVisita.ShowModal;

        sObjetivo := FrmNovosDadosVisita.Objetivo.Text;
        sSetor := FrmNovosDadosVisita.Setor.Text;

        if ((sObjetivo <> EmptyStr) and (sSetor <> EmptyStr)) then
        begin
          if not oClienteController.NovaVisita(dsPesq.DataSet.FieldByName('id').AsInteger, sErro, sObjetivo, sSetor)then
          begin
            //ShowMessage(sErro);
            Application.MessageBox(PChar(sErro), 'Controle de Visitas', MB_ICONERROR);
          end
          else
          begin
            //ShowMessage('Nova visita registrada com sucesso!');
            Application.MessageBox(PChar('Nova visita registrada com sucesso'), 'Controle de Visitas', MB_ICONINFORMATION);
          end;
        end
        else
        begin
          //cliente cancelou o registro da nova visita
        end;
        freeAndNil(FrmNovosDadosVisita);
      end;
   finally
     freeAndNil(oClienteController);
   end;
end;

procedure TFrmCadastrarCliente.Novo;
begin
  FOperacao := opNovo;
  edtCodigo.Text := '';
  edtNome.Text := '';
  edtDocumento.Text := '';
  edtTelefone.Text := '';
  Empresa.Text := '';
  cbxTipo.ItemIndex := 0;

  btnVisitas.Enabled := false;

  pgcPrincipal.ActivePage := tbDados;
end;

procedure TFrmCadastrarCliente.Pesquisar;
var
 oClienteController: TClienteController;
begin
   oClienteController := TClienteController.Create;
   try
     oClienteController.Pesquisar(edtPesquisar.Text);
     FreeAndNil(oClienteController);
   except on E: Exception do
     //  error
   end;
end;

procedure TFrmCadastrarCliente.Timer1Timer(Sender: TObject);
begin
   lbTimer.Caption:= DateTimeToStr(Now);
end;

function TFrmCadastrarCliente.ValidarVisitaPendente: boolean;
var
  oClienteController: TClienteController;
  sErro: String;
begin
   oClienteController := TClienteController.Create;

   try

      if oClienteController.PendenteVisita(dsPesq.DataSet.FieldByName('id').AsInteger, sErro)then
        result := false
      else
        result := true;
   finally
     freeAndNil(oClienteController);
   end;
end;

end.
