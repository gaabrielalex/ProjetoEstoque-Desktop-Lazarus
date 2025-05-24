unit untFrmCadastroLoja;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, ZDataset, ZSqlUpdate;

type

  { TfrmCadastroLoja }

  TfrmCadastroLoja = class(TForm)
    btnPesquisar: TButton;
    btnPesquisarCidade: TButton;
    dbCodigoCidade: TDBEdit;
    dbEdtUF: TDBEdit;
    DBNavigator1: TDBNavigator;
    dsLoja: TDataSource;
    dbEdtNome: TDBEdit;
    dbEdtCidade: TDBEdit;
    dbEdtTelefone: TDBEdit;
    dbEdtEndereco: TDBEdit;
    dbEdtBairro: TDBEdit;
    dbEdtIsncricao: TDBEdit;
    dbEdtCNPJ: TDBEdit;
    dbEdtNum: TDBEdit;
    dbEdtCEP: TDBEdit;
    dbEdtCodigo: TDBEdit;
    DBGrid1: TDBGrid;
    DBGroupBox1: TDBGroupBox;
    edtNomeFiltro: TEdit;
    edtCidadeFiltro: TEdit;
    edtCNPJFiltro: TEdit;
    edtCodigoFiltro: TEdit;
    lblCodigoCidade: TLabel;
    lblEndereco: TLabel;
    lblCEP: TLabel;
    lblInscricao: TLabel;
    lblUF: TLabel;
    lblNum: TLabel;
    lblTelefone: TLabel;
    lblBairro: TLabel;
    lblCidadeFiltro: TLabel;
    lblCidade: TLabel;
    lblCNPJFiltro: TLabel;
    lblCNPJ: TLabel;
    lblCodigoFiltro: TLabel;
    lblCodigo: TLabel;
    lblNomeFiltro: TLabel;
    lblNome: TLabel;
    qryLoja: TZQuery;
    uqryLoja: TZUpdateSQL;
    procedure btnPesquisarCidadeClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmCadastroLoja: TfrmCadastroLoja;

implementation

uses untFrmCadastroCidade;

{$R *.lfm}

{ TfrmCadastroLoja }


procedure TfrmCadastroLoja.btnPesquisarClick(Sender: TObject);
begin
  qryLoja.Active := false;
  qryLoja.SQL.Clear;
  qryLoja.SQl.add('select l.*, c.cidade, c.uf');
  qryLoja.SQl.add('from loja l, cidade c');
  qryLoja.SQl.add('where l.cidade_codcidade = c.codcidade');
  if edtNomeFiltro.text <> '' then
     begin
          qryLoja.SQL.add('and l.nome like :nome');
          qryLOja.ParamByName('nome').AsString := '%' + edtNomeFiltro.text + '%';
     end;
  if edtCidadeFiltro.text <> '' then
     begin
          qryLoja.SQL.add('and c.cidade like :nome_cidade');
          qryLOja.ParamByName('nome_cidade').AsString := '%' + edtCidadeFiltro.text + '%';
     end;
  if edtCNPJFiltro.text <> '' then
     begin
          qryLoja.SQL.add('and l.cnpj like :cnpj');
          qryLOja.ParamByName('cnpj').AsString := edtCNPJFiltro.text + '%';
     end;
  if edtCodigoFiltro.text <> '' then
     begin
          qryLoja.SQL.add('and l.codloja = :codloja');
          qryLOja.ParamByName('codloja').AsInteger := StrToInt(edtCodigoFiltro.text);
     end;
  qryLoja.Active := true;
end;

procedure TfrmCadastroLoja.btnPesquisarCidadeClick(Sender: TObject);
begin
  try
    frmCadastroCidade := TfrmCadastroCidade.create(self);
    frmCadastroCidade.ShowModal();

    qryLoja.Edit;  //Caso o usuário não tenha selecionado para editar
    qryLoja.FieldByName('cidade').AsString := frmCadastroCidade.qryCidade.FieldByName('cidade').AsString;
    qryLoja.FieldByName('cidade_codcidade').AsInteger := frmCadastroCidade.qryCidade.FieldByName('codcidade').AsInteger;
    qryLoja.FieldByName('uf').AsString := frmCadastroCidade.qryCidade.FieldByName('uf').AsString;

  finally
    frmCadastroCidade.free;
  end;
end;

procedure TfrmCadastroLoja.FormShow(Sender: TObject);
begin
  self.Width := 870;
  self.Height := 900;
  if qryLoja.Active = false then
     begin
          qryLoja.Active := true;
     end;
end;

end.

