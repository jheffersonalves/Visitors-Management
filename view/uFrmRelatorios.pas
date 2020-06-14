unit uFrmRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, frxClass, frxDBSet, uDmCliente;

type
  TfrmRelatorios = class(TForm)
    Panel1: TPanel;
    edtPesquisar: TLabeledEdit;
    cbFiltro: TComboBox;
    lblTipo: TLabel;
    btnPesquisar: TButton;
    DBGrid1: TDBGrid;
    pnlRodape: TPanel;
    btnFechar: TButton;
    dsFiltros: TDataSource;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btGerarRelatorioClick(Sender: TObject);
    procedure edtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
    procedure RenderColumns;
    function getcolumnName(sOriginal: String): string;
  public
    { Public declarations }
  end;

var
  frmRelatorios: TfrmRelatorios;

implementation

uses uClienteController;
{$R *.dfm}

procedure TfrmRelatorios.btGerarRelatorioClick(Sender: TObject);
begin
  frxReport1.ShowReport();//imprime relatorio
end;

procedure TfrmRelatorios.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelatorios.btnPesquisarClick(Sender: TObject);
begin
   Pesquisar;
end;

procedure TfrmRelatorios.edtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then //se foi pressionado a tecla enter
  begin
    Pesquisar;
  end;
end;

procedure TfrmRelatorios.FormShow(Sender: TObject);
var
 oCliente: TClienteController;
 sError: String;
 tipe: TFilterOperation;
begin
   try
     oCliente := TClienteController.Create();
     tipe := opTodasVisitas;
     if not oCliente.PesquisarFiltro('', tipe, sError)then//busca a tabela de todas as visitas
     begin
       Application.MessageBox(PChar(sError), 'Controle de Visitas', MB_ICONERROR);
     end;
     FreeAndNil(oCliente);
     RenderColumns;
   except on E: Exception do
     //  error
   end;
end;

function TfrmRelatorios.getcolumnName(sOriginal: String): string;
begin
  sOriginal := LowerCase(sOriginal);
  if sOriginal = 'nome' then
    result := 'Nome'
  else if sOriginal = 'empresa_visitante' then
    result := 'Empresa'
  else if sOriginal = 'telefone' then
    result := 'Telefone'
  else if sOriginal = 'documento' then
    result := 'Documento'
  else if sOriginal = 'tipo' then
    result := 'Tipo'
  else if sOriginal = 'objetivo_visita' then
    result := 'Objetivo'
  else if sOriginal = 'hora_entrada' then
    result := 'Entrada'
  else if sOriginal = 'hora_saida' then
    result := 'Saida'
  else if sOriginal = 'setor_visita' then
    result := 'Setor'
  else
    result := sOriginal;
end;

procedure TfrmRelatorios.Pesquisar;
var
 oClienteController: TClienteController;
 sColumn, sError: String; //coluna que sera realizado o select
 tipe: TFilterOperation;
begin

   if((edtPesquisar.Text = '') and (cbFiltro.ItemIndex <> 3) and (cbFiltro.ItemIndex <> 4))then
     raise Exception.Create('Digite um valor para a pesquisa');

   oClienteController := TClienteController.Create;

   if cbFiltro.ItemIndex = 0 then
     tipe:= opNome
   else if cbFiltro.ItemIndex = 1 then
     tipe:= opEmpresa
   else if cbFiltro.ItemIndex = 2 then
    tipe:= opDataVisita
   else if cbFiltro.ItemIndex = 3 then
     tipe:= opVisitaAberto
   else if cbFiltro.ItemIndex = 4 then
     tipe := opTodasVisitas
   else
      tipe:= opNome;

   try
     if not oClienteController.PesquisarFiltro(edtPesquisar.Text, tipe, sError)then
     begin
       Application.MessageBox(PChar(sError), 'Controle de Visitas', MB_ICONERROR);
     end;
     FreeAndNil(oClienteController);
   except on E: Exception do
     //  error
   end;

   RenderColumns;
end;

procedure TfrmRelatorios.RenderColumns;
var i, ColWidth, ColTextWidth:integer;
text: string;
begin//quando o painel for ativo, ajusta as colunas conforme o tamanho dos campos
 if DBGrid1.DataSource.DataSet.Active then
   begin
     DBGrid1.DataSource.DataSet.DisableControls;
     for i:= 0 to DBGrid1.Columns.Count-1 do
       begin
         DBGrid1.Columns[i].Title.Caption := getcolumnName(DBGrid1.Columns[i].Title.Caption);
         ColWidth:=DBGrid1.Canvas.TextWidth(DBGrid1.Columns[i].Field.DisplayLabel);
         DBGrid1.DataSource.DataSet.First;
       while not DBGrid1.DataSource.DataSet.EOF do
        begin
       ColTextWidth:=DBGrid1.Canvas.TextWidth(DBGrid1.Columns[i].Field.DisplayText);
          if (ColTextWidth > ColWidth) then
            begin
              ColWidth := ColTextWidth;
            end;
          DBGrid1.DataSource.DataSet.Next;
       end;{while}
       DBGrid1.Columns[i].Width:=ColWidth+10;
     end;{for}
DBGrid1.DataSource.DataSet.EnableControls;
DBGrid1.DataSource.DataSet.First;
end;
end;

end.
