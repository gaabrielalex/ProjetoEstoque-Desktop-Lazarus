unit untDmConexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection;

type

  { TdmConexao }

  TdmConexao = class(TDataModule)
    dbCon: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  dmConexao: TdmConexao;

implementation

{$R *.lfm}

{ TdmConexao }

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  if dbCon.Connected = false then
     dbCon.Connected := true;
end;

end.

