unit uDmConexao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXMySQL;

type
  TDmConexao = class(TDataModule)
    sqlConexao: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmConexao: TDmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmConexao.DataModuleCreate(Sender: TObject);
begin
  //sqlConexao.VendorLib := 'D:\delphi_projects\exemploMVC\libmySQL.dll';
end;

end.
