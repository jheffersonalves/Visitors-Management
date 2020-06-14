unit uDmCliente;

interface

uses
  System.SysUtils, System.Classes, uDmConexao, Data.FMTBcd, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr, uClienteModel,
  Data.Win.ADODB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client;
type
  TFilterOperation = (opNome, opEmpresa, opDataVisita, opVisitaAberto, opTodasVisitas);
type
  TDmCliente = class(TDataModule)
    sqlPesquisar: TSQLDataSet;
    sqlInserir: TSQLDataSet;
    sqlAlterar: TSQLDataSet;
    sqlExcluir: TSQLDataSet;
    dspPesquisar: TDataSetProvider;
    cdsPesquisar: TClientDataSet;
    cdsPesquisarid: TIntegerField;
    cdsPesquisarnome: TStringField;
    cdsPesquisartelefone: TStringField;
    cdsPesquisarempresa_visitante: TStringField;
    dspVisitas: TDataSetProvider;
    cdsVisitas: TClientDataSet;
    sqlPesquisarid: TIntegerField;
    sqlPesquisarnome: TStringField;
    sqlPesquisartelefone: TStringField;
    sqlPesquisarempresa_visitante: TStringField;
    sqlVisitas: TSQLDataSet;
    cdsVisitasid_visita: TIntegerField;
    cdsVisitasobjetivo_visita: TStringField;
    cdsVisitashora_entrada: TStringField;
    cdsVisitashora_saida: TStringField;
    cdsVisitassetor_visita: TStringField;
    cdsVisitasfk_visitante: TIntegerField;
    sqlExcluirVisita: TSQLDataSet;
    sqlUltimaVisita: TSQLDataSet;
    sqlInserirVisita: TSQLDataSet;
    sqlFinalizarVisita: TSQLDataSet;
    sqlFiltros: TSQLDataSet;
    dspFiltros: TDataSetProvider;
    cdsFiltros: TClientDataSet;
  private
    { Private declarations }
  public
    function gerarId: Integer;
    function gerarIdVisita: Integer;
    function getIdVisita(iCodigo: Integer): Integer;
    procedure pesquisar(snome: string);
    procedure CarregarCliente(oCliente: Tcliente; iCodigo: integer);
    procedure CarregarVisitas(iCodigo: integer);
    function Inserir(oCLiente: Tcliente; out sError: String): Boolean;
    function PendenteVisita(iCodigo: Integer; out sError: String): Boolean;
    function NovaVisita(iCodigo: Integer; out sError: String; sObjetivo, sSetor: String): Boolean;
    function Alterar(oCliente: Tcliente; out sError: String): Boolean;
    function Excluir(iCodigo: Integer; out sError: String): Boolean;
    function ExcluirVisita(iIdUser, iCodigo: Integer; out sError: String): Boolean;
    function FinalizarVisita(iCodigo: Integer; out sError: String): Boolean;
    function PesquisarFiltro(sValue:String; tipe: TFilterOperation; out sError: String): boolean;
  end;

var
  DmCliente: TDmCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmCliente }

function TDmCliente.Alterar(oCliente: Tcliente; out sError: String): Boolean;
begin
    //definindo os paramentos para o update
    sqlAlterar.Params[0].AsString := oCLiente.Nome;
    sqlAlterar.Params[1].AsString := oCLiente.Tipo;
    sqlAlterar.Params[2].AsString := oCLiente.Documento;
    sqlAlterar.Params[3].AsString := oCliente.Telefone;
    sqlAlterar.Params[4].AsString := oCliente.Empresa;
    sqlAlterar.Params[5].AsInteger := oCliente.ID;

    try  // executa o insert no banco
      sqlAlterar.ExecSQL();
      result := true;
    except on E: Exception do
      begin
         sError := 'Ocorreu um erro ao alterar o cliente:' + sLineBreak + E.Message;
         result := False;    
      end;
    end;
end;

procedure TDmCliente.CarregarCliente(oCliente: Tcliente; iCodigo: integer);
var
  sqlCliente: TSQLDataSet;
begin
   sqlCliente := TSQLDataSet.Create(nil);
   try
     sqlCliente.SQLConnection := DmConexao.sqlConexao;
     sqlCliente.CommandText := 'select * from cliente where (id = '+ IntToStr(iCodigo)+')';
     sqlCliente.Open;
     //oCliente.ID := sqlCliente.FieldByName()

     ocliente.ID := sqlCliente.FieldByName('id').AsInteger;
     oCliente.Nome := sqlCliente.FieldByName('nome').AsString;
     oCliente.Tipo := sqlCliente.FieldByName('tipo').AsString;
     oCliente.Documento := sqlCliente.FieldByName('documento').AsString;
     oCliente.Telefone := sqlCliente.FieldByName('telefone').AsString;
     oCliente.Empresa := sqlCliente.FieldByName('empresa_visitante').AsString;

   finally
      FreeAndNil(sqlCliente);
   end;

end;

procedure TDmCliente.CarregarVisitas(iCodigo: integer);
begin
    if cdsVisitas.Active then
      cdsVisitas.Close;

    cdsVisitas.ParamByName('fk_visitante').AsInteger := iCodigo;
    cdsVisitas.Open; // executa o sql
    cdsVisitas.First;//move a execucao para o primeiro registro
end;

function TDmCliente.Excluir(iCodigo: Integer; out sError: String): Boolean;
var
  sqlSequencia: TSQLDataSet;
begin
   sqlExcluir.Params[0].AsInteger := iCodigo;

   try//primeira exclui as visitas do cliete
   begin
     sqlSequencia := TSQLDataSet.Create(nil);

     sqlSequencia.SQLConnection := DmConexao.sqlConexao;
     sqlSequencia.CommandText := 'delete from visita where (fk_visitante ='+intToStr(iCodigo)+');';
     sqlSequencia.ExecSQL();
//     sqlSequencia.First;

       try
        sqlExcluir.ExecSQL();
        result := true;
       except on E: Exception do
       begin
           sError := 'Ocorreu um erro ao excluir o cliente:' + sLineBreak + E.Message;
           result := False;
       end;
       end;
   end;
   except on E: Exception do
   begin
      sError := 'Ocorreu um erro ao excluir as visitas do cliente:' + sLineBreak + E.Message;
      result := False;
   end;
   end;
   freeAndNil(sqlSequencia);
end;

function TDmCliente.ExcluirVisita(iIdUser, iCodigo: Integer; out sError: String): Boolean;
begin
   sqlExcluirVisita.Params[0].AsInteger := iIdUser;//fk do visitante
   sqlExcluirVisita.Params[1].AsInteger := iCodigo;//id da visita

   try
     sqlExcluirVisita.ExecSQL();
     result := true;
   except on E: Exception do
      begin
         sError := 'Ocorreu um erro ao excluir o cliente:' + sLineBreak + E.Message;
         result := False;
      end;
   end;
end;

function TDmCliente.FinalizarVisita(iCodigo: Integer; out sError: String): Boolean;
var
  sLastId: Integer;
  sDateTime: String;
  sqlSequencia: TSQLDataSet;
begin
    sLastId := getIdVisita(iCodigo);
    sDateTime := formatdatetime('c', now);

    //definindo os paramentos para o insert ====nao ta usando pq da erro..
    //sqlFinalizarVisita.Params[0].AsString := sDateTime;
    //sqlFinalizarVisita.Params[1].AsInteger := iCodigo;
    //sqlFinalizarVisita.Params[2].AsInteger := sLastId;


    try  // executa o insert no banco

       sqlSequencia := TSQLDataSet.Create(nil);
       sqlSequencia.SQLConnection := DmConexao.sqlConexao;
       sqlSequencia.CommandText := 'update visita set hora_saida='+char(39)+sDateTime+char(39)+' where (fk_visitante ='+intToStr(iCodigo)+' and id_visita='+IntToStr(sLastId)+')';
       sqlSequencia.ExecSQL();
//      sqlFinalizarVisita.Open();
      result := true;
    except on E: Exception do
      begin
         sError := 'Ocorreu um erro ao finalizar a visita do cliente:' + sLineBreak + E.Message;
         result := False;
      end;
    end;
    freeAndNil(sqlSequencia);
end;

function TDmCliente.gerarId: Integer;
var
  sqlSequencia: TSQLDataSet;
begin
   sqlSequencia := TSQLDataSet.Create(nil);
   try
     sqlSequencia.SQLConnection := DmConexao.sqlConexao;
     sqlSequencia.CommandText := 'select coalesce(max(id), 0) + 1 as seq from cliente';
     sqlSequencia.Open;
     result := sqlSequencia.FieldByName('seq').AsInteger;
   finally
     FreeAndNil(sqlSequencia);
   end;

end;

function TDmCliente.gerarIdVisita: Integer;
var
  sqlSequencia: TSQLDataSet;
begin
   sqlSequencia := TSQLDataSet.Create(nil);
   try
     sqlSequencia.SQLConnection := DmConexao.sqlConexao;
     sqlSequencia.CommandText := 'select coalesce(max(id_visita), 0) + 1 as seq from visita';
     sqlSequencia.Open;
     result := sqlSequencia.FieldByName('seq').AsInteger;
   finally
     FreeAndNil(sqlSequencia);
   end;
end;

function TDmCliente.getIdVisita(iCodigo: Integer): Integer;
var
  sqlSequencia: TSQLDataSet;
begin
   sqlSequencia := TSQLDataSet.Create(nil);
   try
     sqlSequencia.SQLConnection := DmConexao.sqlConexao;
     sqlSequencia.CommandText := 'select id_visita as seq from visita where fk_visitante ='+intToStr(iCodigo)+' order by id_visita desc limit 1';
     sqlSequencia.Open;
     result := sqlSequencia.FieldByName('seq').AsInteger;
   finally
     FreeAndNil(sqlSequencia);
   end;
end;

function TDmCliente.Inserir(oCLiente: Tcliente; out sError: String): Boolean;
var
 sText: String;
 sList: TStringList;
begin

    //definindo os paramentos para o insert
    sqlInserir.Params[0].AsInteger := gerarId;
    sqlInserir.Params[1].AsString := oCLiente.Nome;
    sqlInserir.Params[2].AsString := oCLiente.Tipo;
    sqlInserir.Params[3].AsString := oCLiente.Documento;
    sqlInserir.Params[4].AsString := oCliente.Telefone;
    sqlInserir.Params[5].AsString := oCLiente.Empresa;

    try  // executa o insert no banco
      sqlInserir.ExecSQL();
      result := true;
    except on E: Exception do
      begin
         sError := 'Ocorreu um erro ao inserir o cliente:' + sLineBreak + E.Message;
         result := False;
      end;
    end;


end;

function TDmCliente.NovaVisita(iCodigo: Integer; out sError: String; sObjetivo, sSetor: String): Boolean;
var
 sDateTime: String;
begin
   sDateTime := formatdatetime('c', now);

   sqlInserirVisita.Params[0].AsInteger := gerarIdVisita();
   sqlInserirVisita.Params[1].DataType := ftWideString;
   sqlInserirVisita.Params[1].AsWideString := sObjetivo;
   sqlInserirVisita.Params[2].AsString := sDateTime;
   sqlInserirVisita.Params[3].AsString := '00/00/0000 00:00:00';
   sqlInserirVisita.Params[4].AsString := sSetor;
   sqlInserirVisita.Params[5].AsInteger := iCodigo;

   try
     sqlInserirVisita.ExecSQL();
     result := true;
   except on E: Exception do
      begin
         sError := 'Ocorreu um erro ao excluir o cliente:' + sLineBreak + E.Message;
         result := False;
      end;
   end;
end;

function TDmCliente.PendenteVisita(iCodigo: Integer; out sError: String): Boolean;
var
  sqlCliente: TSQLDataSet;
  sLastSaida: String;
  sLastVisita: Integer;
begin
   sqlCliente := TSQLDataSet.Create(nil);
   try
     sLastVisita := getIdVisita(iCodigo);

     sqlCliente.SQLConnection := DmConexao.sqlConexao;
     sqlCliente.CommandText := 'select hora_saida from visita where fk_visitante='+IntToStr(iCodigo)+' order by id_visita desc limit 1';
     sqlCliente.Open;
     //oCliente.ID := sqlCliente.FieldByName()
     sLastSaida := sqlCliente.FieldByName('hora_saida').AsString;

     if(sLastSaida = '')then//nao tem registro de entrada ainda
     begin
        result := true;
     end
     else if (sLastSaida = '00/00/0000 00:00:00') then
     begin //tem visita pendente de saida ainda
        result := false;
        sError := 'Visita do cliente pendente de saida!';
     end
     else
       result := true;
   finally
     freeandnil(sqlCliente);
   end;

end;

procedure TDmCliente.pesquisar(snome: string);
begin
    if cdsPesquisar.Active then
       cdsPesquisar.Close;

    cdsPesquisar.ParamByName('nome').AsString := '%' + snome + '%';
    cdsPesquisar.Open; // executa o sql
    cdsPesquisar.First;//move a execucao para o primeiro registro
end;

function TDmCliente.PesquisarFiltro(sValue:String; tipe: TFilterOperation; out sError: String): boolean;
var
  sDatabase: String;
  sFormatDate: TFormatSettings;
  sStringDate: string;
  sDateTime: TDateTime;
begin
   sError := '';
   if tipe = opNome then
     sDatabase := 'cliente'
   else if (tipe = opDataVisita) or (tipe = opVisitaAberto) then
     sDatabase := 'visita'
   else if (tipe = opNome) then
     sDatabase := 'cliente'
   else
     sDatabase := 'cliente';

    if cdsFiltros.Active then
      cdsFiltros.Close;

    if(tipe = opDataVisita)then
    begin
      try
        sFormatDate := TFormatSettings.Create;
        sFormatDate.DateSeparator := '/';
        sFormatDate.ShortDateFormat := 'yyyy/mm/dd';
        sFormatDate.TimeSeparator := ':';
        sFormatDate.ShortTimeFormat := 'hh:mm';
        sFormatDate.LongTimeFormat := 'hh:mm:ss';
        sValue := sValue.Insert(4,'/');
        sValue := sValue.Insert(7,'/');
        if TryStrToDate(sValue, sDateTime, sFormatDate) then
        begin
          sValue := DateToStr(sDateTime) + '%';
        end
        else
        begin
          result := false;
          sError := 'Formato de data inválida! Formato: yyyymmdd';
        end;
      except on E: Exception do
      begin
        result := false;
        sError := 'Formato de data inválida! Formato: yyyymmdd';
      end;
      end;
    end
    else if(tipe = opVisitaAberto) then
    begin
      sValue := '00/00/0000 00:00:00';
    end
    else if(tipe = opNome) then
    begin
      sValue := '%'+sValue+'%';
    end;

    if(sError = '')then//se nao tem erro no formato
    begin
      if tipe = opNome then
      begin
        sqlFiltros.CommandText := 'select visita.objetivo_visita, visita.hora_entrada, visita.hora_saida, visita.setor_visita, cliente.nome as Nome from cliente, visita where cliente.ID = visita.fk_visitante and cliente.Nome like '+chr(39)+sValue+chr(39);
      end
      else if tipe = opEmpresa then
      begin
        sqlFiltros.CommandText := 'select visita.objetivo_visita, visita.hora_entrada, visita.hora_saida, visita.setor_visita, cliente.nome, cliente.empresa_visitante from cliente, visita where cliente.ID = visita.fk_visitante and cliente.empresa_visitante = '+char(39)+sValue+char(39);
      end
      else if tipe = opDataVisita then
      begin
        sqlFiltros.CommandText := 'select visita.objetivo_visita, visita.hora_entrada, visita.hora_saida, visita.setor_visita, cliente.nome, cliente.empresa_visitante from cliente, visita where cliente.ID = visita.fk_visitante and visita.hora_entrada like '+chr(39)+sValue+chr(39);
      end
      else if tipe = opVisitaAberto then
       begin
          sqlFiltros.CommandText := 'select visita.objetivo_visita, visita.hora_entrada, visita.hora_saida, visita.setor_visita, cliente.nome, cliente.empresa_visitante from cliente, visita where cliente.ID = visita.fk_visitante and visita.hora_saida like '+char(39)+'00/00/0000 00:00:00'+chr(39);
       end
      else if tipe = opTodasVisitas then
      begin
        sqlFiltros.CommandText := 'select visita.objetivo_visita, visita.hora_entrada, visita.hora_saida, visita.setor_visita, cliente.nome, cliente.empresa_visitante from cliente, visita where cliente.ID = visita.fk_visitante';
      end;
      cdsFiltros.Open; // executa o sql
      cdsFiltros.First;//move a execucao para o primeiro registro
      result:= true;
    end;
end;

end.
