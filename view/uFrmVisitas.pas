unit uFrmVisitas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmVisitas = class(TForm)
    DBGrid1: TDBGrid;
    dsVisitas: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure Excluir;
  public
    { Public declarations }
    FIdUser: Integer;
    FIsReloadPage: Boolean;
    procedure SetIdUser(sId: Integer);
    property IsReloadPage: boolean read FIsReloadPage;
  end;

var
  frmVisitas: TfrmVisitas;

implementation

{$R *.dfm}

uses uDmCliente, uClienteController;

procedure TfrmVisitas.Button1Click(Sender: TObject);
begin
   Excluir;
end;

procedure TfrmVisitas.Button2Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmVisitas.Excluir;
var
  oClienteController: TClienteController;
  sErro: String;
  sIdVisita: Integer;
begin
   oClienteController := TClienteController.Create;
   sIdVisita := dsVisitas.DataSet.FieldByName('id_visita').AsInteger;

   try  //se o dataset Pesquisar ta ativo e tem registro
   begin
     if MessageDlg('Deseja realmente excluir esta visita?',mtConfirmation, [mbYes, mbNo], 0) = IDYES then
     begin
        if not oClienteController.ExcluirVisita(FIdUser,sIdVisita, sErro) then
          raise Exception.Create(sErro);
        //oClienteController.CarregarVisitas(sIdVisita);
     end;
   end
   finally
      freeandnil(oclienteController);
   end;
   FIsReloadPage := true;
   Close;
end;

procedure TfrmVisitas.FormActivate(Sender: TObject);
var i, ColWidth, ColTextWidth:integer;
begin//quando o painel for ativo, ajusta as colunas conforme o tamanho dos campos
FIsReloadPage := false;
 if DBGrid1.DataSource.DataSet.Active then
   begin
     DBGrid1.DataSource.DataSet.DisableControls;
     for i:= 0 to DBGrid1.Columns.Count-1 do
       begin
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

procedure TfrmVisitas.SetIdUser(sId: Integer);
begin
  FIdUser := sId;
end;

end.
