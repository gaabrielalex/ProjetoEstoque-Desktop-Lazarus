unit untFrmCadastroCategoria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DBCtrls, ZDataset, ZSqlUpdate;

type

  { TfrmCadastroCategoria }

  TfrmCadastroCategoria = class(TForm)
    btnPesquisar: TButton;
    dbEdtDescricao: TDBEdit;
    dbEdtCodigo: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsCategoria: TDataSource;
    edtCodigoFiltro: TEdit;
    edtDescricaoFiltro: TEdit;
    GroupBox1: TGroupBox;
    lblCodigoFiltro: TLabel;
    lblCodigo: TLabel;
    lblDescricaoFiltro: TLabel;
    lblDescricao: TLabel;
    qryCategoria: TZQuery;
    uqryCategoria: TZUpdateSQL;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmCadastroCategoria: TfrmCadastroCategoria;

implementation

{$R *.lfm}

{ TfrmCadastroCategoria }

procedure TfrmCadastroCategoria.FormShow(Sender: TObject);
begin
  self.Height := 551;
  self.Width := 631;
  if qryCategoria.Active = false then
     qryCategoria.Active := true;
  end;

procedure TfrmCadastroCategoria.btnPesquisarClick(Sender: TObject);
begin
  qryCategoria.Active := false;
  qryCategoria.SQL.Clear;
  qryCategoria.SQL.add(' select *');
  qryCategoria.SQL.add(' from categoria');
  qryCategoria.SQL.add(' where 1=1');
  if edtCodigoFiltro.Text <> '' then
     begin
       qryCategoria.SQL.add( ' and codcategoria = :codcategoria');
       qryCategoria.ParamByName('codcategoria').AsInteger := StrToInt(edtCodigoFiltro.Text);
     end;
  if edtDescricaoFiltro.Text <> '' then
     begin
       qryCategoria.SQL.add( ' and categoria like :categoria');
       qryCategoria.ParamByName('categoria').AsString := '%' + edtDescricaoFiltro.Text + '%';
     end;
  qryCategoria.Active := true;
end;

end.

