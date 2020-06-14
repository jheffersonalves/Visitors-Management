unit uClienteModel;

interface

uses
 System.sysutils;

type
  TCliente = class
  private
    FDocumento: string;
    FID: Integer;
    FNome: string;
    FTipo: string;
    FTelefone: string;
    FEmpresa: String;
    procedure SetNome(const Value: string);
    { private declarations }

  public
    { public declarations }
    property ID: Integer read FID write FID;
    property Nome: string read FNome write SetNome;
    property Tipo: string read FTipo write FTipo;
    property Documento: string read FDocumento write FDocumento;
    property Telefone: string read FTelefone write FTelefone;
    property Empresa: string read FEmpresa write FEmpresa;
  published
    { published declarations }
  end;

implementation

{ TCliente }

procedure TCliente.SetNome(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Nome precisa ser preenchido!');

  FNome := Value;
end;

end.
