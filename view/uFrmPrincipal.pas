unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    btnCliente: TButton;
    procedure btnClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirCliente;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uFrmCadastrarCliente;

procedure TFrmPrincipal.AbrirCliente;
begin
  FrmCadastrarCliente := TFrmCadastrarCliente.Create(nil);
  try
    FrmCadastrarCliente.btnPesquisarClick(nil);
    FrmCadastrarCliente.ShowModal;
  finally
    freeandnil(FrmCadastrarCliente);
  end;
end;

procedure TFrmPrincipal.btnClienteClick(Sender: TObject);
begin
   AbrirCliente;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
   AbrirCliente;
end;

end.
