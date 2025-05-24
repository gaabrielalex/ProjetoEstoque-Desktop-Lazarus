unit untFrmCadastroCidade;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  DBGrids, ZConnection, ZDataset, ZSqlUpdate;

type

  { TfrmCadastroCidade }

  TfrmCadastroCidade = class(TForm)
    btnPesquisar: TButton;
    DBCmbBoxUF: TDBComboBox;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsCidade: TDataSource;
    dbEdtCodigo: TDBEdit;
    dbEdtCidade: TDBEdit;
    edtCidadeFiltro: TEdit;
    edtUFFiltro: TEdit;
    GroupBox1: TGroupBox;
    lblCidade: TLabel;
    lblCodigo: TLabel;
    lblCidadeFiltro: TLabel;
    lblUFFiltro: TLabel;
    lblUF: TLabel;
    qryCidade: TZQuery;
    uqryCidade: TZUpdateSQL;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmCadastroCidade: TfrmCadastroCidade;

implementation

{$R *.lfm}

{ TfrmCadastroCidade }

procedure TfrmCadastroCidade.FormShow(Sender: TObject);
begin
     self.Height := 594;
     self.Width := 504;
     if qryCidade.Active = false then
     begin
        qryCidade.Active := true;
     end;
end;

procedure TfrmCadastroCidade.btnPesquisarClick(Sender: TObject);
begin
  qryCidade.Active := false;
  qryCidade.SQL.Clear;
  qryCidade.SQL.add('select *');
  qryCidade.SQL.add('from cidade');
  qryCidade.SQL.add('where 1=1');
  if edtCidadeFiltro.text <> '' then
     begin
        qryCidade.SQL.add('and cidade like :cidade');
        qryCidade.ParamByName('cidade').AsString := '%' + edtCidadeFiltro.text + '%';
     end;
  if edtUFFiltro.Text <> '' then
     begin
        qryCidade.SQL.add('and uf like :uf');
        qryCidade.ParamByName('uf').AsString := edtUFFiltro.text + '%';
     end;
  qryCidade.Active := true;
end;

end.

