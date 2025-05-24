unit untFrmCadastroTransportadora;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBGrids, ZDataset, ZSqlUpdate;

type

  { TfrmCadastroTransportadora }

  TfrmCadastroTransportadora = class(TForm)
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
    dsTransportadora: TDataSource;
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
    lblEndereco: TLabel;
    lblInscricao: TLabel;
    lblNome: TLabel;
    lblNomeFiltro: TLabel;
    lblNum: TLabel;
    lblTelefone: TLabel;
    lblContato: TLabel;
    lblUF: TLabel;
    qryTransportadora: TZQuery;
    uqryTransportadora: TZUpdateSQL;
    procedure btnPesquisarCidadeClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmCadastroTransportadora: TfrmCadastroTransportadora;

implementation

uses untFrmCadastroCidade;

{$R *.lfm}

{ TfrmCadastroTransportadora }

procedure TfrmCadastroTransportadora.btnPesquisarClick(Sender: TObject);
begin
  qryTransportadora.Active := false;
  qryTransportadora.SQL.Clear;
  qryTransportadora.SQl.add('select t.*, c.cidade, c.uf ');
  qryTransportadora.SQl.add('from transportadora t, cidade c');
  qryTransportadora.SQl.add('where t.cidade_codcidade = c.codcidade');
  if edtNomeFiltro.text <> '' then
     begin
          qryTransportadora.SQL.add('and t.transportadora like :nome_transportadora');
          qryTransportadora.ParamByName('nome_transportadora').AsString := '%' + edtNomeFiltro.text + '%';
     end;
  if edtCidadeFiltro.text <> '' then
     begin
          qryTransportadora.SQL.add('and c.cidade like :nome_cidade');
          qryTransportadora.ParamByName('nome_cidade').AsString := '%' + edtCidadeFiltro.text + '%';
     end;
  if edtCNPJFiltro.text <> '' then
     begin
          qryTransportadora.SQL.add('and t.cnpj like :cnpj');
          qryTransportadora.ParamByName('cnpj').AsString := edtCNPJFiltro.text + '%';
     end;
  if edtCodigoFiltro.text <> '' then
     begin
          qryTransportadora.SQL.add('and t.codtransportadora = :codtransportadora');
          qryTransportadora.ParamByName('codtransportadora').AsInteger := StrToInt(edtCodigoFiltro.text);
     end;
  qryTransportadora.Active := true;
end;

procedure TfrmCadastroTransportadora.btnPesquisarCidadeClick(Sender: TObject);
begin
  try
    frmCadastroCidade := TfrmCadastroCidade.create(self);
    frmCadastroCidade.ShowModal();

    qryTransportadora.Edit; //Caso o usuário não tenha selecionado para editar
    qryTransportadora.FieldByName('cidade').AsString := frmCadastroCidade.qryCidade.FieldByName('cidade').AsString;
    qryTransportadora.FieldByName('cidade_codcidade').AsInteger := frmCadastroCidade.qryCidade.FieldByName('codcidade').AsInteger;
    qryTransportadora.FieldByName('uf').AsString := frmCadastroCidade.qryCidade.FieldByName('uf').AsString;

  finally
    frmCadastroCidade.free;
  end;

end;

procedure TfrmCadastroTransportadora.FormShow(Sender: TObject);
begin
  self.Width := 870;
  self.Height := 900;
  if qryTransportadora.Active = false then
     begin
          qryTransportadora.Active := true;
     end;
end;

end.

