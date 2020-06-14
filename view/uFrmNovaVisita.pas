unit uFrmNovaVisita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmDadosVisita = class(TForm)
    btSalvar: TButton;
    Cancelar: TButton;
    pnPrincipal: TPanel;
    Objetivo: TLabeledEdit;
    Setor: TLabeledEdit;
    horarioentrada: TLabeledEdit;
    Visitante: TLabeledEdit;
    procedure CancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure SetorEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FCliente: String;
    property Cliente: string write FCliente;
  end;

var
  frmDadosVisita: TfrmDadosVisita;

implementation

{$R *.dfm}

procedure TfrmDadosVisita.btSalvarClick(Sender: TObject);
begin
  if((Objetivo.Text = '') or (Setor.Text = ''))then
  begin
    MessageDlg('Insira os dados da Visita!', mtError, [mbOK], 0);
  end
  else
  begin
    Close;
  end;
end;

procedure TfrmDadosVisita.CancelarClick(Sender: TObject);
begin
  Objetivo.Text := '';
  Setor.Text := '';
 Close;
end;

procedure TfrmDadosVisita.FormShow(Sender: TObject);
begin
  horarioentrada.Text := DateTimeToStr(now);
  Visitante.Text := FCliente;
end;

procedure TfrmDadosVisita.SetorEnter(Sender: TObject);
begin
   //btSalvarClick(nil);
end;

end.
