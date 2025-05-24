unit untFrmCadastroFornecedor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBGrids, ZDataset, ZSqlUpdate;

type

  { TfrmCadastroFornecedor }

  TfrmCadastroFornecedor = class(TForm)
    btnPesquisar: TButton;
    btnPesquisarCidade: TButton;
    dbCodigoCidade: TDBEdit;
    dbEdtBairro: TDBEdit;
    dbEdtCEP: TDBEdit;
    dbEdtCidade: TDBEdit;
    dbEdtCNPJ: TDBEdit;
    dbEdtCodigo: TDBEdit;
    dbEdtEndereco: TDBEdit;
    dbEdtIsncricao: TDBEdit;
    dbEdtNome: TDBEdit;
    dbEdtNum: TDBEdit;
    dbEdtTelefone: TDBEdit;
    dbEdtContato: TDBEdit;
    dbEdtUF: TDBEdit;
    DBGrid1: TDBGrid;
    DBGroupBox1: TDBGroupBox;
    DBNavigator1: TDBNavigator;
    dsFornecedor: TDataSource;
    edtCidadeFiltro: TEdit;
    edtCNPJFiltro: TEdit;
    edtCodigoFiltro: TEdit;
    edtNomeFiltro: TEdit;
    lblBairro: TLabel;
    lblCEP: TLabel;
    lblCidade: TLabel;
    lblCidadeFiltro: TLabel;
    lblCNPJ: TLabel;
    lblCNPJFiltro: TLabel;
    lblCodigo: TLabel;
    lblCodigoCidade: TLabel;
    lblCodigoFiltro: TLabel;
    lblContato: TLabel;
    lblEndereco: TLabel;
    lblInscricao: TLabel;
    lblNome: TLabel;
    lblNomeFiltro: TLabel;
    lblNum: TLabel;
    lblTelefone: TLabel;
    lblUF: TLabel;
    qryFornecedor: TZQuery;
    uqryFornecedor: TZUpdateSQL;
    procedure btnPesquisarCidadeClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmCadastroFornecedor: TfrmCadastroFornecedor;

implementation

uses untFrmCadastroCidade;

{$R *.lfm}

{ TfrmCadastroFornecedor }

procedure TfrmCadastroFornecedor.btnPesquisarClick(Sender: TObject);
begin
  qryFornecedor.Active := false;
  qryFornecedor.SQL.Clear;
  qryFornecedor.SQl.add('select f.*, c.cidade, c.uf');
  qryFornecedor.SQl.add('from fornecedor f, cidade c');
  qryFornecedor.SQl.add('where f.cidade_codcidade = c.codcidade');
  if edtNomeFiltro.text <> '' then
     begin
          qryFornecedor.SQL.add('and f.fornecedor like :nome_fornecedor');
          qryFornecedor.ParamByName('nome_fornecedor').AsString := '%' + edtNomeFiltro.text + '%';
     end;
  if edtCidadeFiltro.text <> '' then
     begin
          qryFornecedor.SQL.add('and c.cidade like :nome_cidade');
          qryFornecedor.ParamByName('nome_cidade').AsString := '%' + edtCidadeFiltro.text + '%';
     end;
  if edtCNPJFiltro.text <> '' then
     begin
          qryFornecedor.SQL.add('and f.cnpj like :cnpj');
          qryFornecedor.ParamByName('cnpj').AsString := edtCNPJFiltro.text + '%';
     end;
  if edtCodigoFiltro.text <> '' then
     begin
          qryFornecedor.SQL.add('and f.codfornecedor = :codfornecedor');
          qryFornecedor.ParamByName('codfornecedor').AsInteger := StrToInt(edtCodigoFiltro.text);
     end;
  qryFornecedor.Active := true;
end;

procedure TfrmCadastroFornecedor.btnPesquisarCidadeClick(Sender: TObject);
begin
  try
    frmCadastroCidade := TfrmCadastroCidade.create(self);
    frmCadastroCidade.ShowModal();

    qryFornecedor.Edit; //Caso o usuário não tenha selecionado para editar
    qryFornecedor.FieldByName('cidade').AsString := frmCadastroCidade.qryCidade.FieldByName('cidade').AsString;
    qryFornecedor.FieldByName('cidade_codcidade').AsInteger := frmCadastroCidade.qryCidade.FieldByName('codcidade').AsInteger;
    qryFornecedor.FieldByName('uf').AsString := frmCadastroCidade.qryCidade.FieldByName('uf').AsString;
  finally
    frmCadastroCidade.free;
  end;
end;

procedure TfrmCadastroFornecedor.FormShow(Sender: TObject);
begin
  self.Width := 870;
  self.Height := 900;
  if qryFornecedor.Active = false then
     begin
          qryFornecedor.Active := true;
     end;
end;

end.

