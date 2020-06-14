unit uClienteController;

interface

uses
  uClienteModel, uDmCliente, System.SysUtils;

type
 TClienteController = class
 private
   { private declarations }
 protected
   { protected declarations }
 public
   { public declarations }
   constructor Create();
   destructor Destroy; override;
   procedure Pesquisar(sNome: String);
   procedure CarregarCliente(oCliente: TCliente; iCodigo: integer);
   procedure CarregarVisitas(iCodigo: integer);
   function PesquisarFiltro(sValue:String; tipe: TFilterOperation; out sError: String): boolean;
   function PendenteVisita(iCodigo: Integer; var sErro: String): Boolean;
   function NovaVisita(iCodigo: Integer; var sErro: String; sObjetivo, sSetor: String): Boolean;
   function Inserir(oCliente: tCliente; var sErro: string): Boolean;
   function Alterar(oCliente: TCliente; var sErro: String): Boolean;
   function Excluir(iCodigo: Integer; var sErro: String): Boolean;
   function ExcluirVisita(iIdUser, iCodigo: Integer; var sErro: String): Boolean;
   function FinalizarVisita(iCodigo: Integer; var sErro: String): Boolean;
 published
   { published declarations }
 end;

implementation

{ TClienteController }

function TClienteController.Alterar(oCliente: TCliente; var sErro: String): Boolean;
begin
  Result := DmCLiente.Alterar(oCLiente, sErro);
end;

procedure TClienteController.CarregarCliente(oCliente: TCliente; iCodigo: integer);
begin
   DmCliente.CarregarCliente(oCLiente, iCodigo);
end;

procedure TClienteController.CarregarVisitas(iCodigo: integer);
begin
   DmCliente.CarregarVisitas(iCodigo);
end;

constructor TClienteController.Create;
begin
//    DmCliente := TDmCliente.Create(nil);
end;

destructor TClienteController.Destroy;
begin
//  freeandnil(DmCliente);
  inherited;
end;

function TClienteController.Excluir(iCodigo: Integer;  var sErro: String): Boolean;
begin
   result := DmCliente.Excluir(iCodigo, sErro);
end;

function TClienteController.ExcluirVisita(iIdUser, iCodigo: Integer; var sErro: String): Boolean;
begin
   result := DmCliente.ExcluirVisita(iIdUser, iCodigo, sErro);
end;

function TClienteController.FinalizarVisita(iCodigo: Integer; var sErro: String): Boolean;
begin
  result := DmCliente.FinalizarVisita(iCodigo, sErro);
end;

function TClienteController.Inserir(oCliente: tCliente; var sErro: string): Boolean;
begin
     Result := DmCliente.Inserir(oCliente, sErro);
end;

function TClienteController.NovaVisita(iCodigo: Integer; var sErro: String; sObjetivo, sSetor: String): Boolean;
begin
  Result := DmCliente.NovaVisita(iCodigo, sErro, sObjetivo, sSetor);
end;

function TClienteController.PendenteVisita(iCodigo: Integer; var sErro: String): Boolean;
begin
   Result := DmCliente.PendenteVisita(iCodigo, sErro);
end;

procedure TClienteController.Pesquisar(sNome: String);
begin
    DmCliente.pesquisar(sNome);
end;

function TClienteController.PesquisarFiltro(sValue:String; tipe: TFilterOperation; out sError: String): boolean;
begin
    result := DmCliente.pesquisarFiltro(sValue, tipe, sError);
end;

end.
